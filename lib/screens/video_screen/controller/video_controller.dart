import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:viria_dashboard/custom_widgets/custom_snackbar.dart';
import 'package:viria_dashboard/models/background_video_model.dart';
import 'package:viria_dashboard/utils/app_colors.dart';
import 'package:viria_dashboard/web_services/presigned_url_services.dart';
import 'package:viria_dashboard/web_services/videos_services.dart';
import 'dart:html' as html;

class VideoController extends GetxController {
  final TextEditingController videoTitleController = TextEditingController();
  final Rx<Uint8List?> selectedVideoBytes = Rx<Uint8List?>(null);
  final RxString selectedFileName = "".obs;
  final Rx<VideoPlayerController?> videoPlayerController =
      Rx<VideoPlayerController?>(null);
  RxBool isLoading = false.obs;

  final VideosServices videosServices = VideosServices();
  final PresignedUrlServices presignedUrlServices = PresignedUrlServices();
  RxBool isFetchingVideos = false.obs;
  RxList<BackgroundVideoModel> backgroundVideos = <BackgroundVideoModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchBackgroundVideos(); 
  }

  Future<void> fetchBackgroundVideos() async {
    try {
      isFetchingVideos.value = true;
      final videos = await videosServices.getBackgroundVideos();
      backgroundVideos.assignAll(videos);
      log("✅ Background videos fetched: ${backgroundVideos.length}");
    } catch (e, stack) {
      log("Error fetching background videos: $e\n$stack");
    } finally {
      isFetchingVideos.value = false;
    }
  }


  @override
  void onClose() {
    videoPlayerController.value?.dispose();
    super.onClose();
  }

  Future<void> pickAndLoadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      final file = result.files.single;
      selectedFileName.value = file.name;
      final bytes = file.bytes;

      log("Picked video: ${file.name}");

      if (bytes != null && bytes.isNotEmpty) {
        selectedVideoBytes.value = bytes;
        _initializeVideoPlayerBytes(bytes);
      } else {
        log("Selected video is empty");
        showCustomSnackbar("Error", "Selected video is empty.");
      }
    }
  }

  void _initializeVideoPlayerBytes(Uint8List bytes) {
    videoPlayerController.value?.dispose();

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final ctrl = VideoPlayerController.network(url);
    ctrl
        .initialize()
        .then((_) {
          if (ctrl.value.isInitialized) {
            videoPlayerController.value = ctrl;
          } else {
            log('Video player failed to initialize.');
          }
        })
        .catchError((e) {
          log('Error initializing video player: $e');
        });
  }

  Future<String?> uploadVideoToS3() async {
    if (selectedVideoBytes.value == null || selectedFileName.value.isEmpty) {
      log("No video selected for upload");
      showCustomSnackbar("Error", "No video selected for upload.");
      return null;
    }

    if (selectedVideoBytes.value!.isEmpty) {
      log("Selected video is empty");
      showCustomSnackbar("Error", "Selected video is empty.");
      return null;
    }

    isLoading.value = true;

    final fileName = selectedFileName.value;
    final extension = fileName.split('.').last;
    final contentType = "video/$extension";

    final presignedData = await presignedUrlServices.getPresignedUrl(
      folderPath: "backgrounds",
      fileName: fileName,
      contentType: contentType,
    );

    if (presignedData == null) {
      log("Failed to get presigned URL");
      isLoading.value = false;
      return null;
    }

    log("✅ Presigned data: $presignedData");

    final url = presignedData["url"]!;
    final key = presignedData["key"]!;

    try {
      final request = html.HttpRequest();
      request.open("PUT", url);
      request.setRequestHeader("Content-Type", contentType);

      request.upload.onProgress.listen((event) {
        log("📤 Upload progress: ${event.loaded}/${event.total}");
      });

      final completer = Completer<void>();

      request.onLoadEnd.listen((event) {
        log("✅ Upload completed with status ${request.status}");
        completer.complete();
      });

      request.onError.listen((event) {
        log("Upload failed");
        completer.completeError("Upload failed");
      });

      request.send(selectedVideoBytes.value);

      await completer.future;

      return "https://viriaa-data.s3.eu-north-1.amazonaws.com/$key";
    } catch (e) {
      log("Error uploading video: $e");
      showCustomSnackbar("Error", "Video upload failed. Please try again.");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveBackgroundVideo() async {
    try {
      isLoading.value = true;

      final s3Url = await uploadVideoToS3();
      if (s3Url == null) {
        log("Video upload failed or was cancelled.");
        isLoading.value = false;
        return;
      }

      final title = videoTitleController.text.trim();
      if (title.isEmpty) {
        log("Title is empty. Please enter a title before saving.");
        showCustomSnackbar(
          "Error",
          "Title is empty. Please enter a title before saving.",
        );
        isLoading.value = false;
        return;
      }

      final body = {"title": title, "link": s3Url};
      final response = await videosServices.addBackgroundVideo(body);

      if (response is BackgroundVideoModel) {
        log("🎉 Video saved successfully: $response");
        Get.back();
        showCustomSnackbar(
          "Success",
          "Background video added successfully. It will be live shortly.",
          backgroundColor: kGreenColor,
        );
        videoTitleController.clear();
        selectedVideoBytes.value = null;
        selectedFileName.value = "";
        videoPlayerController.value = null;
      } else if (response is String) {
        log("Failed to save video: $response");
        showCustomSnackbar("Error", response);
      } else {
        log("Unexpected response from addBackgroundVideo: $response");
      }
    } catch (e, stack) {
      log("Exception while saving background video: $e\n$stack");
      showCustomSnackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteVideo(String id) async {
  try {
    isLoading.value = true;

    final response = await videosServices.deleteBackgroundVideo(id);

    if (response == true) {
      backgroundVideos.removeWhere((video) => video.videoId == id);

      showCustomSnackbar(
        "Success",
        "Background video deleted successfully.",
        backgroundColor: kGreenColor,
      );
    } else {
      log("Failed to delete video: $response");
      showCustomSnackbar("Error", response.toString());
    }
  } catch (e, stack) {
    log("Exception while deleting background video: $e\n$stack");
    showCustomSnackbar("Error", "Something went wrong while deleting.");
  } finally {
    isLoading.value = false;
  }
}

}
