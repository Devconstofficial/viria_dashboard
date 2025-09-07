import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';
import 'package:viria_dashboard/screens/auth_screens/controller/auth_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class VerifyOtpScreen extends GetView<AuthController> {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthComponent(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 26.h),
            Center(child: Image.asset(kLogoImage, height: 56.h, width: 150.w)),
            SizedBox(height: 170.h),
            CustomText(
              text: "Verify OTP",
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
              color: kPrimaryColor,
            ),
            SizedBox(height: 16.h),
            CustomText(
              text:
                  "Please enter OTP sent to your email: ${controller.emailController.text} for verification.",
              fontWeight: FontWeight.w500,
              fontSize: 19.sp,
            ),

            SizedBox(height: 19.h),

            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceBetween,
              fieldWidth: 56,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: kWhiteColor,
                enabledBorderColor: kBlackColor,
                borderColor: kBlackColor,
                focusBorderColor: kPrimaryColor,
                disabledBorderColor: kWhiteColor,
              ),
              fieldStyle: FieldStyle.underline,
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              outlineBorderRadius: 12.r,
              style: const TextStyle(fontSize: 17),
              onChanged: (pin) {
                controller.otpController.text = pin;
              },
              onCompleted: (pin) async {
                controller.otpController.text = pin;
              },
            ),
            SizedBox(height: 36.h),
            CustomButton(
              title: "Verify OTP",
              onTap: () {
                controller.verifyOtp();
              },
              showGradient: true,
              showBorder: true,
              showShadow: true,
            ),
          ],
        ),
        image: kAuthImage3,
      ),
    );
  }
}
