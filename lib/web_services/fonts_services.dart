import 'dart:developer';
import 'package:viria_dashboard/models/fonts_model.dart';
import 'package:viria_dashboard/models/response_model.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_management.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_token_keys.dart';
import 'package:viria_dashboard/web_services/http_request_client.dart';
import 'package:viria_dashboard/web_services/web_urls.dart';

class FontsServices {
  FontsServices._();

  static final FontsServices _instance = FontsServices._();

  factory FontsServices() => _instance;

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<List<FontModel>?> getFonts() async {
    final userToken = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kGetFontsUrl,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    log("getFonts==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {

    final fontsJson = responseModel.data?["data"]?["fonts"];

    if (fontsJson is List<dynamic>) {
      return fontsJson.map((f) => FontModel.fromJson(f)).toList();
    }
  }
    return null;
  }

Future<FontModel?> addFont({
    required String imageLink,
    required String assFileLink,
    required String fontFileLink,
  }) async {
    final userToken = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final body = {
      "image": imageLink,
      "assFileLink": assFileLink,
      "fontFileLink": fontFileLink,
    };

    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kAddFontUrl,
      requestBody: body,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    log("addFont==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final fontData = responseModel.data["data"]["font"];
      if (fontData != null) {
        return FontModel.fromJson(fontData);
      }
    }
    return null;
  }


  Future<FontModel?> deleteFont(String fontId) async {
    final userToken = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: "${WebUrls.kDeleteFontUrl}/$fontId",
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    log("deleteFont==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return FontModel.fromJson(responseModel.data["data"]["font"]);
    }
    return null;
  }
}
