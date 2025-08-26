import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/utils/app_strings.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';
import 'controller/forgot_pass_controller.dart';

class SetNewPassScreen extends GetView<ForgotController> {
  const SetNewPassScreen({super.key});

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
              text: "Set New Password",
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
            SizedBox(height: 19.h),
            CustomText(
              text: "Please enter your new password.",
              fontWeight: FontWeight.w500,
              fontSize: 19.sp,
            ),
            SizedBox(height: 19.h),
            CustomText(
              text: "New Password",
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            SizedBox(height: 4.h),
            CustomTextField(hintText: "••••••••", borderRadius: 10),
            SizedBox(height: 24.h),
            CustomText(
              text: "Confirm New Password",
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            SizedBox(height: 4.h),
            CustomTextField(hintText: "••••••••", borderRadius: 10),
            SizedBox(height: 48.h),
            CustomButton(
                title: "Change Password",
                onTap: () {
                  Get.toNamed(kAuthScreenRoute);
                  },
              showShadow: true,
              showBorder: true,
              showGradient: true,
            ),
          ],
        ),
        image: kAuthImage2,
      ),
    );
  }
}
