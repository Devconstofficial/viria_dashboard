import 'dart:developer';
import 'package:viria_dashboard/models/response_model.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_management.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_token_keys.dart';
import 'package:viria_dashboard/web_services/http_request_client.dart';
import 'package:viria_dashboard/web_services/web_urls.dart';

class PresignedUrlServices {
  PresignedUrlServices._();

  static final PresignedUrlServices _instance = PresignedUrlServices._();

  factory PresignedUrlServices() => _instance;

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<Map<String, String>?> getPresignedUrl({
    required String folderPath,
    required String fileName,
    required String contentType,
  }) async {
    final userToken = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final body = {
      "folderPath": folderPath,
      "fileName": fileName,
      "contentType": contentType,
    };

    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kAddPredesignedUrl,
      requestBody: body,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    log("getPresignedUrl==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final data = responseModel.data;
      return {
        "url": data["url"],
        "key": data["key"],
      };
    }

    return null; 
  }
}
