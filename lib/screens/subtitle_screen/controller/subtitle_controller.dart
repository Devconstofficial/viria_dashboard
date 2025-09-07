import 'dart:async';

import 'dart:developer';

import 'dart:typed_data';

import 'dart:html' as html;

import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import 'package:file_picker/file_picker.dart';

import 'package:viria_dashboard/custom_widgets/custom_snackbar.dart';

import 'package:viria_dashboard/models/fonts_model.dart';

import 'package:viria_dashboard/utils/app_colors.dart';

import 'package:viria_dashboard/web_services/fonts_services.dart';

import 'package:viria_dashboard/web_services/presigned_url_services.dart';

class SubtitleController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isFetchingFonts = false.obs;

  final FontsServices fontsServices = FontsServices();
  final PresignedUrlServices presignedUrlServices = PresignedUrlServices();

  Rxn<Uint8List> thumbnailBytes = Rxn<Uint8List>();
  RxnString assFileName = RxnString();
  RxnString ttfFileName = RxnString();
  RxnString imageName = RxnString();

  Uint8List? assFileBytes;
  Uint8List? ttfFileBytes;

  RxList<FontModel> fonts = <FontModel>[].obs;

  Future<void> pickThumbnail() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpg", "jpeg", "webp"],
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      thumbnailBytes.value = result.files.single.bytes;
      imageName.value = result.files.single.name;
    } else {
      showCustomSnackbar("Invalid File", "Please select a valid image file.");
    }
  }

  Future<void> pickAssFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["ass"],
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      assFileName.value = result.files.single.name;
      assFileBytes = result.files.single.bytes;
    } else {
      showCustomSnackbar("Invalid File", "Only .ass files are allowed.");
    }
  }

  Future<void> pickTtfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["ttf", "otf"],
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      ttfFileName.value = result.files.single.name;
      ttfFileBytes = result.files.single.bytes;
    } else {
      showCustomSnackbar(
        "Invalid File",
        "Only .ttf or .otf files are allowed.",
      );
    }
  }

  void removeThumbnail() {
    thumbnailBytes.value = null;
    imageName.value = null;
  }

  void removeAssFile() {
    assFileName.value = null;
    assFileBytes = null;
  }

  void removeTtfFile() {
    ttfFileName.value = null;
    ttfFileBytes = null;
  }

  Future<String?> _uploadToS3({
    required Uint8List bytes,

    required String fileName,

    required String contentType,
  }) async {
    try {
      final presignedData = await presignedUrlServices.getPresignedUrl(
        folderPath: "fonts",

        fileName: fileName,

        contentType: contentType,
      );

      if (presignedData == null) {
        showCustomSnackbar("Error", "Failed to get presigned URL.");

        return null;
      }

      final url = presignedData["url"]!;

      final key = presignedData["key"]!;

      final request = html.HttpRequest();

      request.open("PUT", url);

      request.setRequestHeader("Content-Type", contentType);

      final completer = Completer<void>();
      
      request.upload.onProgress.listen((event) {
        log("📤 Upload progress: ${event.loaded}/${event.total}");
      });
      request.onLoadEnd.listen((event) {
        log("Upload completed with status ${request.status}");

        completer.complete();
      });




      request.onError.listen((event) {
        completer.completeError("Upload failed");
      });

      request.send(bytes);

      await completer.future;

      return "https://viriaa-data.s3.eu-north-1.amazonaws.com/$key";
    } catch (e) {
      log("Upload error: $e");

      showCustomSnackbar("Error", "Upload failed. Please try again.");

      return null;
    }
  }

  Future<void> saveFont() async {
    if (thumbnailBytes.value == null ||
        assFileBytes == null ||
        ttfFileBytes == null) {
      showCustomSnackbar("Error", "Please select all required files.");

      return;
    }

    try {
      isLoading.value = true;

      final imageLink = await _uploadToS3(
        bytes: thumbnailBytes.value!,

        fileName: imageName.value ?? "thumbnail.png",

        contentType: "image/png",
      );

      final assLink = await _uploadToS3(
        bytes: assFileBytes!,

        fileName: assFileName.value ?? 'default_ass_file.ass',

        contentType: "text/x-ass",
      );

      final ttfLink = await _uploadToS3(
        bytes: ttfFileBytes!,

        fileName: ttfFileName.value ?? 'default_font_file.ttf',

        contentType: "font/ttf",
      );

      if (imageLink == null || assLink == null || ttfLink == null) {
        showCustomSnackbar("Error", "One or more uploads failed.");

        return;
      }

      final response = await fontsServices.addFont(
        imageLink: imageLink,

        assFileLink: assLink,

        fontFileLink: ttfLink,
      );

      if (response != null) {
        await fetchFonts();
        Get.back();

        showCustomSnackbar(
          "Success",

          "Font uploaded successfully.",

          backgroundColor: kGreenColor,
        );

        removeThumbnail();

        removeAssFile();

        removeTtfFile();
      }
    } catch (e, stack) {
      log("saveFont error: $e\n$stack");

      showCustomSnackbar("Error", "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFonts() async {
    try {
      isFetchingFonts.value = true;

      final fetched = await fontsServices.getFonts();

      if (fetched != null) {
        fonts.assignAll(fetched);
      }
    } catch (e, stack) {
      log("fetchFonts error: $e\n$stack");
    } finally {
      isFetchingFonts.value = false;
    }
  }

  Future<void> deleteFont(String fontId) async {
    try {
      isLoading.value = true;

      final deleted = await fontsServices.deleteFont(fontId);

      if (deleted != null) {
        fonts.removeWhere((f) => f.fontId == fontId);

        showCustomSnackbar(
          "Success",

          "Font deleted successfully.",

          backgroundColor: kGreenColor,
        );
      }
    } catch (e, stack) {
      log("deleteFont error: $e\n$stack");

      showCustomSnackbar("Error", "Something went wrong while deleting.");
    } finally {
      isLoading.value = false;
    }
  }
}
