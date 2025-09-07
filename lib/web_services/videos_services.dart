import 'dart:developer';
import 'package:viria_dashboard/models/background_video_model.dart';
import 'package:viria_dashboard/models/response_model.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_management.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_token_keys.dart';
import 'package:viria_dashboard/web_services/http_request_client.dart';
import 'package:viria_dashboard/web_services/web_urls.dart';

class VideosServices {
  VideosServices._();

  static final VideosServices _instance = VideosServices._();

  factory VideosServices() => _instance;

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> addBackgroundVideo(Map<String, dynamic> backgroundVideoData) async {
    final userToken = await _sessionManagement.getSessionToken(tokenKey: SessionTokenKeys.kUserTokenKey);

    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kAddBackgroundVideoUrl,
      requestBody: backgroundVideoData,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    log("addBackgroundVideo==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final videoJson = responseModel.data["data"]["backgroundVideo"];
      return BackgroundVideoModel.fromJson(videoJson);
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<List<BackgroundVideoModel>> getBackgroundVideos() async {
    final userToken = await _sessionManagement.getSessionToken(tokenKey: SessionTokenKeys.kUserTokenKey);

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kGetBackgroundVideosUrl,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    log("getBackgroundVideos==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final videosJson = responseModel.data["data"]["backgroundVideos"] as List;
      return videosJson.map((e) => BackgroundVideoModel.fromJson(e)).toList();
    }

    return [];
  }

  Future<dynamic> deleteBackgroundVideo(String backgroundVideoId) async {
    final userToken = await _sessionManagement.getSessionToken(tokenKey: SessionTokenKeys.kUserTokenKey);

    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: "${WebUrls.kDeleteBackgroundVideoUrl}/$backgroundVideoId",
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    log("deleteBackgroundVideo==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true; 
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}
