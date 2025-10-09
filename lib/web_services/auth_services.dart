import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:viria_dashboard/models/response_model.dart';
import 'package:viria_dashboard/screens/sidemenu/controller/sidemenu_controller.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_management.dart';
import 'package:viria_dashboard/utils/session_management.dart/session_token_keys.dart';
import 'package:viria_dashboard/web_services/http_request_client.dart';
import 'package:viria_dashboard/web_services/web_urls.dart';
import '../models/user_model.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> signInUser({required String email}) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kSignInUrl,
      requestBody: {"email": email},
      requestHeader: {'Content-Type': 'application/json',},
    );

    log("signInUser==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final otpToken = responseModel.data["data"]["otpToken"];
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kOtpTokenKey,
        tokenValue: otpToken,
      );

      log("OTP Token received: $otpToken");

      return true;
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> verifyOTP({required String otp}) async {
    final otpToken = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kOtpTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kVerifyOTPUrl,
      requestBody: {"otpToken": otpToken, "otp": otp},
      requestHeader: {'Content-Type': 'application/json'},
    );

    log("verifyOTP==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final data = responseModel.data["data"];
      final userJson = data["user"];
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserTokenKey,
        tokenValue: data["authToken"],
      );
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kRefreshTokenKey,
        tokenValue: data["refreshToken"],
      );
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserModelKey,
        tokenValue: jsonEncode(userJson),
      );

      log("User after OTP verification: $userJson");

      return UserModel.fromJson(userJson);
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> refreshAuthToken() async {
    final refreshToken = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kRefreshTokenKey,
    );

    ResponseModel responseModel = await _client.customRequest(
      'PUT',
      url: WebUrls.kRefreshTokenUrl,
      requestHeader: {'Content-Type': 'application/json'},
      requestBody: {"refreshToken": refreshToken},
    );

    log("refreshAuthToken==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final data = responseModel.data["data"];
      final userJson = data["user"];
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserTokenKey,
        tokenValue: data["authToken"],
      );
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kRefreshTokenKey,
        tokenValue: data["refreshToken"],
      );
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserModelKey,
        tokenValue: jsonEncode(userJson),
      );

      log("User after refresh: $userJson");

      return UserModel.fromJson(userJson);
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> logout() async {
  final refreshToken = await _sessionManagement.getSessionToken(
    tokenKey: SessionTokenKeys.kRefreshTokenKey,
  );

  ResponseModel responseModel = await _client.customRequest(
    'POST',
    url: WebUrls.kLogoutUrl,
    requestHeader: {
      'Content-Type': 'application/json',
    },
    requestBody: {"refreshToken": refreshToken},
  );

  log("logout==================> $responseModel");

  if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {

    await _sessionManagement.removeSession(token: SessionTokenKeys.kUserTokenKey);
    await _sessionManagement.removeSession(token: SessionTokenKeys.kRefreshTokenKey);
    await _sessionManagement.removeSession(token: SessionTokenKeys.kUserModelKey);
    await _sessionManagement.removeSession(token: SessionTokenKeys.kOtpTokenKey); 
    Get.find<SideMenuController>().stopAutoRefreshToken();
    log("User logged out, token auto-refresh stopped");
    return true; 
  }

  return responseModel.data["message"] ?? responseModel.statusDescription;
}


  Future<dynamic> getUserFromSession() async {
    var result = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserModelKey,
    );
    log("getUserFromSession======>$result");
    if (result.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(result));
    }
  }
}
