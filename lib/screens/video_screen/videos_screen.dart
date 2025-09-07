import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
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

  void _openVideoDialog(String videoUrl) {
    final videoCtrl = VideoPlayerController.network(videoUrl);

    showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FutureBuilder(
            future: videoCtrl.initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  width: Get.width * 0.7,
                  height: Get.height * 0.7,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return StatefulBuilder(
                builder: (context, setState) {
                  void listener() => setState(() {});
                  videoCtrl.addListener(listener);

                  return SizedBox(
                    width: Get.width * 0.7,
                    height: Get.height * 0.7,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.w, top: 10.h),
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: kPrimaryColor4,
                              ),
                              onPressed: () => Get.back(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: videoCtrl.value.aspectRatio,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: VideoPlayer(videoCtrl),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text(
                                _formatDuration(videoCtrl.value.position),
                                style: const TextStyle(fontSize: 12),
                              ),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  max:
                                      videoCtrl.value.duration.inSeconds
                                          .toDouble(),
                                  value:
                                      videoCtrl.value.position.inSeconds
                                          .clamp(
                                            0,
                                            videoCtrl.value.duration.inSeconds,
                                          )
                                          .toDouble(),
                                  onChanged: (value) {
                                    videoCtrl.seekTo(
                                      Duration(seconds: value.toInt()),
                                    );
                                  },
                                ),
                              ),
                              Text(
                                _formatDuration(videoCtrl.value.duration),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 16),
                          child: IconButton(
                            icon: Icon(
                              videoCtrl.value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                              size: 50,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                videoCtrl.value.isPlaying
                                    ? videoCtrl.pause()
                                    : videoCtrl.play();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    ).then((_) {
      videoCtrl.dispose();
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  uploadVideoDialog() {
    return CustomDialog(
      title: "Upload Video",
      widget: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 8.h),
            CustomTextField(
              hintText: "Title",
              isFilled: true,
              controller: controller.videoTitleController,
              fillColor: Colors.grey.shade400,
              borderColor: kWhiteShade2Color,
              borderRadius: 10,
              contentPaddong: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
            ),
            SizedBox(height: 14.h),
            Obx(() {
              final videoCtrl = controller.videoPlayerController.value;

              if (videoCtrl != null && videoCtrl.value.isInitialized) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 250.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: videoCtrl.value.size.width,
                            height: videoCtrl.value.size.height,
                            child: VideoPlayer(videoCtrl),
                          ),
                        ),
                      ),
                    ),

                    ValueListenableBuilder(
                      valueListenable: videoCtrl,
                      builder: (context, VideoPlayerValue value, _) {
                        return FloatingActionButton(
                          onPressed: () {
                            if (value.isPlaying) {
                              videoCtrl.pause();
                            } else {
                              videoCtrl.play();
                            }
                          },
                          backgroundColor: Colors.white54,
                          child: Icon(
                            value.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40,
                          ),
                        );
                      },
                    ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            videoCtrl.pause();
                            videoCtrl.dispose();
                            controller.videoPlayerController.value = null;
                            controller.selectedVideoBytes.value = null;
                            controller.update();
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }

              return DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(4),
                dashPattern: [8, 8],
                color: kWhiteShade4Color,
                strokeWidth: 0.6,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => controller.pickAndLoadVideo(),
                    child: Container(
                      height: 170,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              kVideosIcon,
                              height: 29,
                              width: 25,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Drag and drop video here, or click add video \nFormat supported: MOV, MKV and MP4",
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kDarkBlueColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            CustomButton(
                              title: "Add Video",
                              onTap: () => controller.pickAndLoadVideo(),
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
                    if (controller.isLoading.value) {
                      return;
                    } else {
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
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                            title: "Upload Video",
                            onTap: () async {
                              await controller.saveBackgroundVideo();
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
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchBackgroundVideos();
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
                                            Get.dialog(
                                              barrierDismissible: false,
                                              uploadVideoDialog(),
                                            );
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
                                      if (controller.isFetchingVideos.value) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      final validVideos =
                                          controller.backgroundVideos
                                              .where(
                                                (video) =>
                                                    video.thumbnail.isNotEmpty,
                                              )
                                              .toList();

                                      if (validVideos.isEmpty) {
                                        return const Text(
                                          "No background videos available",
                                        );
                                      }

                                      return Wrap(
                                        spacing: 15.w,
                                        runSpacing: 15.h,
                                        children:
                                            validVideos.map((video) {
                                              return videoContainer(
                                                thumbnail: video.thumbnail,
                                                id: video.videoId,
                                                title: video.title,
                                                width: video.width ?? 0,
                                                height: video.height ?? 0,
                                                onTap: () {
                                                  _openVideoDialog(video.link);
                                                },
                                              );
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

  Widget videoContainer({
    required String thumbnail,
    required String title,
    required int width,
    required int height,
    required VoidCallback onTap,
    required String id,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 350.h,
        width: 310,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Container(
              height: 350.h,
              width: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image),
                      ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 92.h,
                width: 310.w,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: kWhiteShade1Color,
                  border: Border(
                    bottom: BorderSide(color: kBlackColor.withOpacity(0.63)),
                    right: BorderSide(color: kBlackColor.withOpacity(0.63)),
                    left: BorderSide(color: kBlackColor.withOpacity(0.63)),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(9.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: kGreyColor2,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "$width x $height",
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kGreyColor3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          final confirmed = await Get.dialog(
                            AlertDialog(
                              title: const Text("Delete Video"),
                              content: const Text(
                                "Are you sure you want to delete this video?",
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () => Get.back(result: false),
                                ),
                                TextButton(
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () => Get.back(result: true),
                                ),
                              ],
                            ),
                          );

                          if (confirmed == true) {
                            await controller.deleteVideo(id);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
