import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/custom_widgets/custom_snackbar.dart';
import 'package:viria_dashboard/utils/app_colors.dart';
import 'package:viria_dashboard/utils/app_strings.dart';
import 'package:viria_dashboard/utils/common_code.dart';
import 'package:viria_dashboard/web_services/auth_services.dart';
import 'package:viria_dashboard/models/user_model.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  final AuthService _service = AuthService();

  Future<void> signInUser() async {
    try {
      if (!CommonCode.isValidEmail(emailController.text.trim())) {
        showCustomSnackbar("ERROR", "Please enter a valid email address.");
        return;
      }
      CommonCode.show();
      final response = await _service.signInUser(
        email: emailController.text.trim(),
      );

      if (response == true) {
        CommonCode.hide();
        showCustomSnackbar(
          "SUCCESS",
          "OTP sent to your email address ${emailController.text.trim()}",
          backgroundColor: kGreenColor2,
        );
        Get.toNamed(kVerifyOtpScreenRoute);
      } else if (response is String) {
        CommonCode.hide();
        showCustomSnackbar("ERROR", response);
      }
    } catch (e) {
      CommonCode.hide();
      showCustomSnackbar("ERROR", "Error: $e");
    }
  }

  Future<void> verifyOtp() async {
    try {
      if (otpController.text.trim().length != 4) {
        showCustomSnackbar("ERROR", "Please enter a valid 4-digit OTP.");
        return;
      }
      CommonCode.show();
      final response = await _service.verifyOTP(otp: otpController.text.trim());

      if (response is UserModel) {
        CommonCode.hide();
        showCustomSnackbar(
          "SUCCESS",
          "OTP verified successfully. You're logged in now.",
          backgroundColor: kGreenColor2,
        );
        Get.toNamed(kDashboardScreenRoute);
      } else if (response is String) {
        CommonCode.hide();
        showCustomSnackbar("ERROR", response);
      }
    } catch (e) {
      CommonCode.hide();
      showCustomSnackbar("ERROR", "Error: $e");
    }
  }
}
