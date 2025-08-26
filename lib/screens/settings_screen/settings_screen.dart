import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/custom_widgets/custom_button.dart';
import 'package:viria_dashboard/screens/settings_screen/controller/settings_controller.dart';
import 'package:viria_dashboard/utils/app_images.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../sidemenu/sidemenu.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SideMenu(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customHeader("Settings"),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 120,
                      ),
                      color: kWhiteShade2Color,
                      child: Padding(
                        padding: EdgeInsets.only(top: 32.h,bottom: 32.h,left: 32.w,right: 44.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: kBlackColor.withOpacity(0.1)
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(40),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 20.w,
                                      children: [
                                        Container(
                                          height: 53,
                                          width: 53,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.asset(kPersonImage,fit: BoxFit.cover,)),
                                        ),
                                        CustomButton(title: "Update", onTap: (){},height: 40.h,width: 100,color: kWhiteColor,borderRadius: 12,showGradient: false,textSize: 15,fontWeight: FontWeight.w500,textColor: kPrimaryColor,),
                                      ],
                                    ),
                                    SizedBox(height: 16.h,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            spacing: 10,
                                            children: [
                                              Text(
                                                "Name",
                                                style: AppStyles.blackTextStyle().copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(
                                                width: 480.w,
                                                decoration: BoxDecoration(
                                                  color: kWhiteColor,
                                                  borderRadius: BorderRadius.circular(12)
                                                ),
                                                // height: 60,
                                                child: CustomTextField(
                                                  hintText: "Andrew",
                                                  fillColor: kWhiteColor,
                                                  borderColor: kWhiteShade3Color,
                                                  borderRadius: 12,
                                                  isFilled: true,
                                                  // contentPaddong: EdgeInsets.symmetric(vertical: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Row(
                                            spacing: 10,
                                            children: [
                                              Text(
                                                "Email",
                                                style: AppStyles.blackTextStyle().copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(
                                                width: 480.w,
                                                decoration: BoxDecoration(
                                                    color: kWhiteColor,
                                                    borderRadius: BorderRadius.circular(12)
                                                ),
                                                // height: 60,
                                                child: CustomTextField(
                                                  hintText: "Andrew@gmail,com",
                                                  fillColor: kWhiteColor,
                                                  borderColor: kWhiteShade3Color,
                                                  borderRadius: 12,
                                                  isFilled: true,
                                                  // contentPaddong: EdgeInsets.symmetric(vertical: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Row(
                                            spacing: 22,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              CustomButton(title: "Forgot Password?", onTap: (){},width: 169,textSize: 14,fontWeight: FontWeight.w700,),
                                              CustomButton(title: "Save Changes", onTap: (){},width: 169,textSize: 14,fontWeight: FontWeight.w700,),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
