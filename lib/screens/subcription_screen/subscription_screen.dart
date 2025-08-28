import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/screens/subcription_screen/controller/subscription_controller.dart';
import 'package:viria_dashboard/utils/app_images.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../sidemenu/sidemenu.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {
  const SubscriptionScreen({super.key});

  final double checkboxWidth = 40;
  final double idWidth = 100;
  final double nameWidth = 230;
  final double planWidth = 100;
  final double dateWidth = 150;
  final double endDateWidth = 150;
  final double statusWidth = 150;



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
                    customHeader("User"),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 120,
                      ),
                      color: kWhiteShade2Color,
                      child: Padding(
                        padding: EdgeInsets.all(26.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTableHeader(),
                            SizedBox(height: 25.h),
                            Obx(() => ListView.separated(
                              itemCount: controller.pagedUsers.length,
                              shrinkWrap: true,
                              separatorBuilder: (_, __) => SizedBox(height: 12.h),
                              itemBuilder: (context, index) {
                                final user = controller.pagedUsers[index];
                                final RxBool isChecked = user['isChecked'];

                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Obx(() => GestureDetector(
                                        onTap: () => isChecked.value = !isChecked.value,
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          margin: EdgeInsets.only(right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            border: Border.all(color: kGreyColor5, width: 1.3),
                                            color: isChecked.value ? kBlueColor6 : kWhiteColor,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.check,
                                              size: 14,
                                              color: isChecked.value ? kWhiteColor : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      )),
                                      SizedBox(
                                        width: idWidth.w,
                                        child: Text(
                                          "#${user['id']}",
                                          style: AppStyles.nunitoTextStyle().copyWith(fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: nameWidth.w,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: AssetImage(kUserImage),
                                              radius: 20,
                                            ),
                                            SizedBox(width: 13.w),
                                            Expanded(
                                              child: Text(
                                                user['name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyles.nunitoTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: planWidth.w,
                                        child: Text(
                                          user['plan'],
                                          overflow: TextOverflow.ellipsis,
                                          style: AppStyles.nunitoTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dateWidth.w,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(kCalenderIcon, height: 16),
                                            SizedBox(width: 13.w),
                                            Text(
                                              user['date'],
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyles.nunitoTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp),

                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: endDateWidth.w,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(kCalenderIcon, height: 16),
                                            SizedBox(width: 13.w),
                                            Text(
                                              user['endDate'],
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyles.nunitoTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp),

                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: statusWidth.w,
                                        child: Container(
                                          width: 170.w,
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                            color: user['status'] == kActive
                                                ? kGreenColor3.withOpacity(0.2)
                                                : user['status'] == kExpired ? kRedColor2.withOpacity(0.2) : kDarkPurpleColor1.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              user['status'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: user['status'] == kActive
                                                    ? kGreenColor3
                                                    : user['status'] == kExpired ? kRedColor2 : kDarkPurpleColor1
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                );
                              },
                            )),
                            SizedBox(height: 29.h,),
                            Obx(() => CustomPagination(
                              currentPage: controller.currentPage2.value,
                              visiblePages: controller.visiblePageNumbers,
                              onPrevious: controller.goToPreviousPage,
                              onNext: controller.goToNextPage,
                              onPageSelected: controller.goToPage,
                            )),
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


  Widget buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: checkboxWidth.w,
            child: Row(
              children: [
                Obx(() {
                  bool isAllChecked = controller.pagedUsers.every((u) => u['isChecked'].value == true);
                  return GestureDetector(
                    onTap: () {
                      controller.toggleSelectAll(!isAllChecked);
                    },
                    child: Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: kGreyColor5, width: 1.3),
                        color: isAllChecked ? kBlueColor6 : kWhiteColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          size: 14,
                          color: isAllChecked ? kWhiteColor : Colors.transparent,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            width: idWidth.w,
            child: Row(
              spacing: 8.w,
              children: [
                Text("Sub ID", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
          SizedBox(
            width: nameWidth.w,
            child: Row(
              spacing: 8.w,
              children: [
                Text("Name", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
          SizedBox(
            width: planWidth.w,
            child: Row(
              spacing: 8.w,
              children: [
                Text("Plan", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
          SizedBox(
            width: dateWidth.w,
            child: Row(
              spacing: 13.w,
              children: [
                Text("Start Date", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
          SizedBox(
            width: endDateWidth.w,
            child: Row(
              spacing: 8.w,
              children: [
                Text("End Date", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
          SizedBox(
            width: statusWidth.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                Text("Status", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
