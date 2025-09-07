import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/custom_widgets/custom_button.dart';
import 'package:viria_dashboard/screens/subtitle_screen/controller/subtitle_controller.dart';
import 'package:viria_dashboard/utils/app_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../custom_widgets/custom_header.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../sidemenu/sidemenu.dart';
import 'package:viria_dashboard/models/fonts_model.dart';

class SubtitleScreen extends GetView<SubtitleController> {
  const SubtitleScreen({super.key});

  Widget subtitleContainer(FontModel font) {
    return Container(
      height: 213,
      width: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBlackColor.withOpacity(0.6)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(11),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: font.image,
                fit: BoxFit.contain,
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Deletion"),
                      content: const Text(
                        "Are you sure you want to delete this font?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.deleteFont(font.fontId);
                            Get.back();
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.red.withOpacity(0.8),
                radius: 15,
                child: const FaIcon(
                  FontAwesomeIcons.solidTrashCan,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadSubtitleDialog() {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 29),
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 466,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upload Subtitle",
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: kDarkBlueColor,
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        if (!controller.isLoading.value) {
                          Get.back();
                        }
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: kRedColor1.withOpacity(0.04),
                        child: Center(
                          child: Icon(Icons.close, size: 12, color: kRedColor1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Obx(() {
                return controller.thumbnailBytes.value == null
                    ? _buildUploadContainer(
                      onTap: controller.pickThumbnail,
                      icon: kUploadIcon,
                      text:
                          "Drag and drop subtitle thumbnail here, or \nclick upload",
                      buttonText: "Add Thumbnail",
                    )
                    : Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            controller.thumbnailBytes.value!,
                            height: 160,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                if (!controller.isLoading.value) {
                                  controller.removeThumbnail();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    );
              }),
              SizedBox(height: 14.h),
              Text(
                "Subtitle File (.ass)",
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 14.h),
              Obx(() {
                return controller.assFileName.value == null
                    ? _buildUploadContainer(
                      onTap: controller.pickAssFile,
                      icon: kFileIcon,
                      text: "Drag and drop .ass file here, or \nclick upload",
                      buttonText: "Attach File",
                    )
                    : _buildFileChip(
                      controller.assFileName.value!,
                      () {
                                if (!controller.isLoading.value) {
                                  controller.removeAssFile();
                                }
                              },
                    );
              }),
              SizedBox(height: 14.h),
              Text(
                "TTF / OTF File",
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 14.h),
              Obx(() {
                return controller.ttfFileName.value == null
                    ? _buildUploadContainer(
                      onTap: controller.pickTtfFile,
                      icon: kFileIcon,
                      text:
                          "Drag and drop ttf or otf file here, or \nclick below",
                      buttonText: "Attach File",
                    )
                    : _buildFileChip(
                      controller.ttfFileName.value!,
                      () {
                                if (!controller.isLoading.value) {
                                  controller.removeTtfFile();
                                }
                              },
                    );
              }),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 20,
                children: [
                  CustomButton(
                    title: "Close",
                    onTap: () {
                      if (!controller.isLoading.value) {
                        Get.back();
                      }
                    },
                    height: 40.h,
                    width: 100,
                    color: kWhiteColor,
                    borderRadius: 12,
                    showGradient: false,
                    textSize: 15,
                    fontWeight: FontWeight.w500,
                    textColor: kPrimaryColor,
                  ),
                  Obx(
                    () =>
                        controller.isLoading.value
                            ? CircularProgressIndicator()
                            : CustomButton(
                              title: "Upload Subtitle",
                              onTap: () {
                                if (controller.thumbnailBytes.value == null ||
                                    controller.assFileName.value == null ||
                                    controller.ttfFileName.value == null) {
                                  Get.snackbar(
                                    "Error",
                                    "Please attach all required files before uploading.",
                                  );
                                  return;
                                } else {
                                  controller.saveFont();
                                }
                              },
                              height: 40.h,
                              width: 125,
                              borderRadius: 12,
                              textSize: 13,
                              fontWeight: FontWeight.w400,
                              showBorder: false,
                            ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadContainer({
    required VoidCallback onTap,
    required String icon,
    required String text,
    required String buttonText,
  }) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(4),
      dashPattern: [6, 8],
      color: kWhiteShade4Color,
      strokeWidth: 0.6,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 165,
          width: Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(22.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon, height: 29, width: 25),
              SizedBox(height: 8),
              Text(
                text,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kDarkBlueColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              CustomButton(
                title: buttonText,
                onTap: onTap,
                height: 29.h,
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
    );
  }

  Widget _buildFileChip(String fileName, VoidCallback onRemove) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: kGreyColor4.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              fileName,
              style: TextStyle(fontSize: 14, color: kDarkBlueColor),
            ),
          ),
          InkWell(
            onTap: onRemove,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: Icon(Icons.close, size: 16, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchFonts();
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
                                    Obx(() {
                                      if (controller.isFetchingFonts.value) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (controller.fonts.isEmpty) {
                                        return const Center(
                                          child: Text(
                                            "No fonts found.",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        );
                                      }

                                      return Wrap(
                                        spacing: 15.w,
                                        runSpacing: 15.h,
                                        children:
                                            controller.fonts.map((font) {
                                              return subtitleContainer(font);
                                            }).toList(),
                                      );
                                    }),
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
