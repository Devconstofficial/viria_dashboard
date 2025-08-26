import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_strings.dart';
import 'controller/forgot_pass_controller.dart';

class SendOtpScreen extends GetView<ForgotController> {
  const SendOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AuthComponent(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 26.h),
            Center(child: Image.asset(kLogoImage,height: 56.h,width: 150.w,)),
            SizedBox(height: 170.h),
            CustomText(text: "Forget Password?",fontWeight: FontWeight.bold,fontSize: 40.sp,color: kPrimaryColor,),
            SizedBox(height: 16.h),
            CustomText(text: "Please enter your email to reset your password.",fontWeight: FontWeight.w500,fontSize: 19.sp,),
            SizedBox(height: 36.h),
            CustomText(text: "Email",fontWeight: FontWeight.w600,fontSize: 17.sp,),
            SizedBox(height: 4.h),
            CustomTextField(
              hintText: "debra.holt@example.com",
              borderRadius: 10,
            ),
            SizedBox(height: 36.h),
            CustomButton(
              title: "Verify Email",
              onTap: () {
                Get.toNamed(kVerifyOtpScreenRoute);
              },
              showGradient: true,
              showBorder: true,
            ),
          ],
        ), image: kAuthImage2,
      ),

    );
  }
}
