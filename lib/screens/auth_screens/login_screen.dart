import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:viria_dashboard/custom_widgets/auth_component.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_textField.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_text.dart';
import '../../utils/app_strings.dart';
import '../../utils/common_code.dart';
import 'controller/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        CommonCode.unFocus(context);
      },
      child: Scaffold(
        body: AuthComponent(
          isAuth: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26.h),
                Center(child: Image.asset(kLogoImage,height: 56.h,width: 150.w,)),
                SizedBox(height: 169.h),
                CustomText(text: "Sign In",fontSize: 40.sp,fontWeight: FontWeight.bold,color: kPrimaryColor,),
                SizedBox(height: 16.h),
                CustomText(text: "Please fill your detail to access your account.",fontSize: 19,fontWeight: FontWeight.w400),
                SizedBox(height: 36.h),
                CustomText(text: "Email",fontSize: 17.sp,fontWeight: FontWeight.w600,),
                SizedBox(height: 4.h),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: "Enter your email",
                  borderColor: kBlackColor,
                  borderRadius: 10,
                ),
                SizedBox(height: 25.h),

                CustomText(text: "Password",fontSize: 17.sp,fontWeight: FontWeight.w600,),
                SizedBox(height: 4.h),
                CustomTextField(
                  controller: controller.passwordController,
                  hintText: "Enter your password",
                  borderColor: kBlackColor,
                  borderRadius: 10,
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed(kSendOtpScreenRoute);
                        },
                        child: CustomText(
                          text: "Forgot Password?",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 110.h),
                CustomButton(
                    title: "Sign in",
                    showShadow: true,
                    showBorder: true,
                    showGradient: true,
                    onTap: (){
                      Get.toNamed(kDashboardScreenRoute);
                    }),
              ],
            ),
            image: kAuthImage1)
      ),
    );
  }
}
