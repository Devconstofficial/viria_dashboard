import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/custom_widgets/custom_button.dart';
import 'package:viria_dashboard/custom_widgets/custom_dialog.dart';
import 'package:viria_dashboard/screens/settings_screen/controller/settings_controller.dart';
import 'package:viria_dashboard/utils/app_images.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../sidemenu/sidemenu.dart';

class SubtitleScreen extends GetView<SettingsController> {
  const SubtitleScreen({super.key});

  subtitleContainer(image) {
    return Container(
      height: 213,
      width: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBlackColor.withOpacity(0.6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: Center(child: Image.asset(image, fit: BoxFit.contain)),
      ),
    );
  }

  uploadSubtitleDialog() {
    return CustomDialog(
      title: "Upload Subtitle",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(4),
            dashPattern: [6, 8],
            color: kWhiteShade4Color,
            strokeWidth: 0.6,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {},
                child: Container(
                  height: 160,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(22.r),
                    child: Column(
                      children: [
                        SvgPicture.asset(kUploadIcon, height: 19, width: 25),
                        SizedBox(height: 12),
                        Text(
                          "Drag and drop subtitle thumbnail here, or \nclick upload ",
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: kDarkBlueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        CustomButton(
                          title: "Add Thumbnail",
                          onTap: () {},
                          height: 30.h,
                          width: 122,
                          color: kGreyColor4,
                          borderRadius: 8,
                          textSize: 13,
                          textColor: kDarkBlueColor,
                          fontWeight: FontWeight.w400,
                          showBorder: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h,),
          Text(
            "Subtitle File (.ass)",
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 14.h,),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(4),
            dashPattern: [6, 8],
            color: kWhiteShade4Color,
            strokeWidth: 0.6,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {},
                child: Container(
                  height: 165,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(22.r),
                    child: Column(
                      children: [
                        SvgPicture.asset(kFileIcon, height: 29, width: 25),
                        SizedBox(height: 8),
                        Text(
                          "Drag and drop .ass file here, or \nclick upload ",
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: kDarkBlueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        CustomButton(
                          title: "Attach File",
                          onTap: () {
                          },
                          height: 29.h,
                          width: 92,
                          color: kGreyColor4,
                          borderRadius: 8,
                          textSize: 13,
                          textColor: kDarkBlueColor,
                          fontWeight: FontWeight.w400,
                          showBorder: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h,),
          Text(
            "TTF / OTF File",
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 14.h,),

          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(4),
            dashPattern: [6, 8],
            color: kWhiteShade4Color,
            strokeWidth: 0.6,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {},
                child: Container(
                  height: 165,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(22.r),
                    child: Column(
                      children: [
                        SvgPicture.asset(kFileIcon, height: 29, width: 25),
                        SizedBox(height: 8),
                        Text(
                          "Drag and drop ttf or otf file here, or \nclick below ",
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: kDarkBlueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        CustomButton(
                          title: "Attach File",
                          onTap: () {
                          },
                          height: 29.h,
                          width: 92,
                          color: kGreyColor4,
                          borderRadius: 8,
                          textSize: 13,
                          textColor: kDarkBlueColor,
                          fontWeight: FontWeight.w400,
                          showBorder: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 20,
            children: [
              CustomButton(title: "Close", onTap: (){
                Get.back();
              },height: 40.h,width: 100,color: kWhiteColor,borderRadius: 12,showGradient: false,textSize: 15,fontWeight: FontWeight.w500,textColor: kPrimaryColor,),

              CustomButton(
                title: "Upload Subtitle",
                onTap: () {
                  Get.back();
                },
                height: 40.h,
                width: 125,
                borderRadius: 12,
                textSize: 13,
                fontWeight: FontWeight.w400,
                showBorder: false,
              ),
            ],
          )
        ],
      ),
    );
  }

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
                    customHeader("Subtitle"),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 120,
                      ),
                      color: kWhiteShade2Color,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 32.h,
                          bottom: 32.h,
                          left: 32.w,
                          right: 44.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: kWhiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Added Subtitles",
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                                color: kGreyColor3,
                                              ),
                                        ),
                                        Spacer(),
                                        CustomButton(
                                          title: "Download All",
                                          onTap: () {},
                                          height: 40.h,
                                          width: 130,
                                          color: kBlueColor,
                                          borderRadius: 12,
                                          textSize: 14,
                                          fontWeight: FontWeight.w400,
                                          showBorder: false,
                                        ),
                                        SizedBox(width: 24.w),
                                        CustomButton(
                                          title: "Upload Subtitle",
                                          onTap: () {
                                            Get.dialog(uploadSubtitleDialog());
                                          },
                                          height: 40.h,
                                          width: 130,
                                          borderRadius: 12,
                                          textSize: 14,
                                          fontWeight: FontWeight.w400,
                                          showBorder: false,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),
                                    Wrap(
                                      spacing: 15.w,
                                      runSpacing: 15.h,
                                      children: [
                                        subtitleContainer(kSubtitle1Image),
                                        subtitleContainer(kSubtitle2Image),
                                        subtitleContainer(kSubtitle3Image),
                                        subtitleContainer(kSubtitle4Image),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
