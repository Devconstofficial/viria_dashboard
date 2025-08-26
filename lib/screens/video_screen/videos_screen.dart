import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/custom_widgets/custom_button.dart';
import 'package:viria_dashboard/custom_widgets/custom_dialog.dart';
import 'package:viria_dashboard/screens/video_screen/controller/video_controller.dart';
import 'package:viria_dashboard/utils/app_images.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../sidemenu/sidemenu.dart';

class VideoScreen extends GetView<VideoController> {
  const VideoScreen({super.key});

  videoContainer(image,time,size,title) {
    return Container(
      height: 350.h,
      width: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Container(
              height: 350.h,
              width: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(image, fit: BoxFit.cover))),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 82.h,
              width: 310.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                ),
                color: kWhiteShade1Color,
                border: Border(
                  bottom: BorderSide(
                    color: kBlackColor.withOpacity(0.63)
                  ),
                  right: BorderSide(
                      color: kBlackColor.withOpacity(0.63)
                  ),
                  left: BorderSide(
                      color: kBlackColor.withOpacity(0.63)
                  )
                )
              ),
              child: Padding(
                padding: EdgeInsets.all(9.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      title,
                      style: AppStyles.blackTextStyle()
                          .copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: kGreyColor2,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "$time . $size MB",
                          style: AppStyles.blackTextStyle()
                              .copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: kGreyColor3,
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  uploadVideoDialog() {
    return CustomDialog(
      title: "Upload Video",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Video Title",
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: kBlackColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h,),
          CustomTextField(
            hintText: "Title",
            isFilled: true,
            fillColor: Colors.grey.shade400,
            borderColor: kWhiteShade2Color,
            borderRadius: 10,
            contentPaddong: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          ),
          SizedBox(height: 14.h,),

          Text(
            "Duration (min)",
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: kBlackColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h,),
          CustomTextField(
            hintText: "10 min",
            isFilled: true,
            fillColor: Colors.grey.shade400,
            borderColor: kWhiteShade2Color,
            borderRadius: 10,
            contentPaddong: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          ),
          SizedBox(height: 14.h,),

          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(4),
            dashPattern: [8, 8],
            color: kWhiteShade4Color,
            strokeWidth: 0.6,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {},
                child: Container(
                  height: 170,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        SvgPicture.asset(kVideosIcon, height: 29, width: 25),
                        SizedBox(height: 8),
                        Text(
                          "Drag and drop video here, or click add video \nFormat supported: MOV, MKV and MP4",
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: kDarkBlueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        CustomButton(
                          title: "Add Video",
                          onTap: () {},
                          height: 29,
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
                title: "Upload Video",
                onTap: (){
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
                    customHeader("Videos"),
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
                                          "My Video",
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
                                          title: "Upload Video",
                                          onTap: () {
                                            Get.dialog(uploadVideoDialog());
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
                                        videoContainer(kVideoImage,"2mins","327", "Subway Surfer"),
                                        videoContainer(kVideoImage,"2mins","327", "Subway Surfer"),
                                        videoContainer(kVideoImage,"2mins","327", "Subway Surfer"),
                                        videoContainer(kVideoImage,"2mins","327", "Subway Surfer"),
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
