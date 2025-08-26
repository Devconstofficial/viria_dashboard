import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import 'controller/sidemenu_controller.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}


class _SideMenuState extends State<SideMenu> {
  final menuController = Get.put(SideMenuController());

  @override
  Widget build(BuildContext context) {
    // bool isTablet = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    double width = MediaQuery.of(context).size.width;

    return Drawer(
      shape: OutlineInputBorder(
        borderSide: BorderSide.none
      ),
      backgroundColor: kWhiteColor,
      width: 290.w,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                SizedBox(
                  height: 150,
                  child: DrawerHeader(
                    child: Image.asset(
                      height: 56,
                      width: 151,
                      kLogoImage,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            menuController.onItemTapped(0);
                            Get.toNamed(kDashboardScreenRoute);
                          },
                          child: Container(
                              height: 64,
                              width: 255.w,
                              decoration: BoxDecoration(
                                color: menuController.selectedIndex.value == 0 ? kPrimaryColor : kWhiteColor,
                                borderRadius: BorderRadius.circular(12),
                                gradient: menuController.selectedIndex.value == 0
                                    ? LinearGradient(
                                  colors: [
                                    kPrimaryColor.withOpacity(0.8),
                                    kPrimaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                    : null,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 24.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      kDashboardIcon,
                                      height: 32,
                                      width: 32,
                                        color: menuController.selectedIndex.value == 0 ? kWhiteColor : kGreyColor2,
                                      ),
                                    SizedBox(width: 24.w,),
                                    Text(
                                      "Dashboard",
                                      style: AppStyles.blackTextStyle().copyWith(
                                          color: menuController.selectedIndex.value == 0
                                              ? kWhiteColor : kGreyColor2,
                                          fontSize: 18,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24,),
                    Obx(() {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            menuController.onItemTapped(1);
                            // Get.toNamed(kDashboardScreenRoute);
                          },
                          child: Container(
                              height: 64,
                              width: 255.w,
                              decoration: BoxDecoration(
                                  color: menuController.selectedIndex.value == 1 ? kPrimaryColor : kWhiteColor,
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: menuController.selectedIndex.value == 1 ? LinearGradient(
                                      colors: [
                                        kPrimaryColor.withOpacity(0.8),
                                        kPrimaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight
                                  ) : null
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 24.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      kGroupUsersIcon,
                                      height: 32,
                                      width: 32,
                                      color: menuController.selectedIndex.value == 1 ? kWhiteColor : kGreyColor2,
                                    ),
                                    SizedBox(width: 24.w,),
                                    Text(
                                      "User",
                                      style: AppStyles.blackTextStyle().copyWith(
                                          color: menuController.selectedIndex.value == 1
                                              ? kWhiteColor : kGreyColor2,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24,),
                    Obx(() {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            menuController.onItemTapped(2);
                            Get.toNamed(kSubtitleScreenRouteRoute);
                          },
                          child: Container(
                              height: 64,
                              width: 255.w,
                              decoration: BoxDecoration(
                                  color: menuController.selectedIndex.value == 2 ? kPrimaryColor : kWhiteColor,
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: menuController.selectedIndex.value == 2 ? LinearGradient(
                                      colors: [
                                        kPrimaryColor.withOpacity(0.8),
                                        kPrimaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight
                                  ) : null

                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 24.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      kSubtitleIcon,
                                      height: 32,
                                      width: 32,
                                      color: menuController.selectedIndex.value == 2 ? kWhiteColor : kGreyColor2,
                                    ),
                                    SizedBox(width: 24.w,),
                                    Text(
                                      "Subtitle",
                                      style: AppStyles.blackTextStyle().copyWith(
                                          color: menuController.selectedIndex.value == 2
                                              ? kWhiteColor : kGreyColor2,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24,),
                    Obx(() {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            menuController.onItemTapped(3);
                            Get.toNamed(kVideoScreenRoute);
                          },
                          child: Container(
                              height: 64,
                              width: 255.w,
                              decoration: BoxDecoration(
                                  color: menuController.selectedIndex.value == 3 ? kPrimaryColor : kWhiteColor,
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: menuController.selectedIndex.value == 3 ? LinearGradient(
                                      colors: [
                                        kPrimaryColor.withOpacity(0.8),
                                        kPrimaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight
                                  ) : null
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 24.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      kVideosIcon,
                                      height: 32,
                                      width: 32,
                                      color: menuController.selectedIndex.value == 3 ? kWhiteColor : kGreyColor2,
                                    ),
                                    SizedBox(width: 24.w,),
                                    Text(
                                      "Videos",
                                      style: AppStyles.blackTextStyle().copyWith(
                                          color: menuController.selectedIndex.value == 3
                                              ? kWhiteColor : kGreyColor2,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24,),
                    Obx(() {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            menuController.onItemTapped(4);
                            // Get.toNamed(kDashboardScreenRoute);
                          },
                          child: Container(
                              height: 64,
                              width: 255.w,
                              decoration: BoxDecoration(
                                  color: menuController.selectedIndex.value == 4 ? kPrimaryColor : kWhiteColor,
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: menuController.selectedIndex.value == 4 ? LinearGradient(
                                      colors: [
                                        kPrimaryColor.withOpacity(0.8),
                                        kPrimaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight
                                  ) : null
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 24.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      kInsightIcon,
                                      height: 32,
                                      width: 32,
                                      color: menuController.selectedIndex.value == 4 ? kWhiteColor : kGreyColor2,
                                    ),
                                    SizedBox(width: 24.w,),
                                    Text(
                                      "Subscriptions",
                                      style: AppStyles.blackTextStyle().copyWith(
                                          color: menuController.selectedIndex.value == 4
                                              ? kWhiteColor : kGreyColor2,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24,),
                    Obx(() {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            menuController.onItemTapped(5);
                            Get.toNamed(kSettingsScreenRouteRoute);
                          },
                          child: Container(
                              height: 64,
                              width: 255.w,
                              decoration: BoxDecoration(
                                  color: menuController.selectedIndex.value == 5 ? kPrimaryColor : kWhiteColor,
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: menuController.selectedIndex.value == 5 ? LinearGradient(
                                      colors: [
                                        kPrimaryColor.withOpacity(0.8),
                                        kPrimaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight
                                  ) : null
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 24.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      kGroupUsersIcon,
                                      height: 32,
                                      width: 32,
                                      color: menuController.selectedIndex.value == 5 ? kWhiteColor : kGreyColor2,
                                    ),
                                    SizedBox(width: 24.w,),
                                    Text(
                                      "Settings",
                                      style: AppStyles.blackTextStyle().copyWith(
                                          color: menuController.selectedIndex.value == 5
                                              ? kWhiteColor : kGreyColor2,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 52.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(kAuthScreenRoute);
                  },
                  child: SizedBox(
                      height: 64,
                      width: 255.w,
                      child: Padding(
                        padding: const EdgeInsets.only( left: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              kLogoutIcon,
                              height: 32,
                              width: 32,
                              color: kRedColor,
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                            Text(
                              "Logout",
                              style: AppStyles.blackTextStyle().copyWith(
                                  color: kRedColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              )
            ),

          ],
        ),
      ),
    );
  }
}