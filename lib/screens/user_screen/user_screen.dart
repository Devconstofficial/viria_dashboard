import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/custom_widgets/custom_dialog.dart';
import 'package:viria_dashboard/custom_widgets/custom_text.dart';
import 'package:viria_dashboard/screens/user_screen/controller/user_controller.dart';
import 'package:viria_dashboard/utils/app_images.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_dropdown.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../sidemenu/sidemenu.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  final double checkboxWidth = 40;
  final double idWidth = 100;
  final double nameWidth = 190;
  final double emailWidth = 230;
  final double dateWidth = 150;
  final double statusWidth = 150;
  final double actionWidth = 60;


  updateDialog(){
    return CustomDialog(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: "User Status",fontSize: 16.sp,fontWeight: FontWeight.w400,),
            SizedBox(height: 8.h),
            CustomDropdown(
              selected: controller.selectedStatus,
              items: [kActive, kExpired, kSuspended],
              hint: kActive,
            ),
            SizedBox(height: 44.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 20,
              children: [

                CustomButton(title: "Close", onTap: (){
                  Get.back();
                },height: 40.h,width: 93,color: kWhiteColor,borderRadius: 12,showGradient: false,textSize: 15,fontWeight: FontWeight.w500,textColor: kPrimaryColor,),

                CustomButton(
                  title: "Save",
                  onTap: () {
                    Get.back();
                  },
                  height: 40.h,
                  width: 93,
                  borderRadius: 12,
                  textSize: 13,
                  fontWeight: FontWeight.w400,
                  showBorder: false,
                ),
              ],
            )

          ],
        ),
        title: "Update User Status"
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
                                        width: emailWidth.w,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(kMailIcon, height: 18),
                                            SizedBox(width: 13.w),
                                            Expanded(
                                              child: Text(
                                                user['email'],
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyles.nunitoTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp),
                                              ),
                                            ),
                                          ],
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
                                        width: statusWidth.w,
                                        child: Container(
                                          width: 170.w,
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                            color: user['status'] == 'Active'
                                                ? kGreenColor3.withOpacity(0.2)
                                                : kRedColor2.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              user['status'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: user['status'] == kActive
                                                    ? kGreenColor3
                                                    : kRedColor2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: actionWidth.w,
                                        child: PopupMenuButton<int>(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(Icons.more_horiz_outlined, color: kGreyColor5),
                                          offset: const Offset(0, 40),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                          color: kWhiteColor,

                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 1,
                                              child: Container(
                                                height: 36.h,
                                                  // width: 160.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(7),
                                                    color: kLightBlueColor.withOpacity(0.1)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        SvgPicture.asset(kEditIcon,height: 10,width: 10,color: kLightBlueColor,),
                                                        SizedBox(width: 8.w,),
                                                        Text("Edit",style: AppStyles.nunitoTextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.w400,color: kLightBlueColor),),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            PopupMenuItem(
                                              value: 2,
                                              child: Container(
                                                  height: 36.h,
                                                  // width: 120.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(7),
                                                      color: kRedColor1.withOpacity(0.1)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(kDeleteIcon,height: 10,width: 10,color: kRedColor1,),
                                                        SizedBox(width: 8.w,),
                                                        Text("Delete",style: AppStyles.nunitoTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w400,color: kRedColor1),),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == 1) {
                                              Get.dialog(updateDialog());
                                            } else if (value == 2) {

                                            }
                                          },
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
              spacing: 13.w,
              children: [
                Text("User ID", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
          SizedBox(
            width: nameWidth.w,
            child: Row(
              spacing: 13.w,
              children: [
                Text("Name", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)

              ],
            ),
          ),
          SizedBox(
            width: emailWidth.w,
            child: Row(
              spacing: 13.w,
              children: [
                Text("Email", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
          SizedBox(
            width: dateWidth.w,
            child: Row(
              spacing: 13.w,
              children: [
                Text("Join Date", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)

              ],
            ),
          ),
          SizedBox(
            width: statusWidth.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 13.w,
              children: [
                Text("Status", style: AppStyles.nunitoTextStyle()),
                SvgPicture.asset(kDropDownIcon,width: 8,height: 8,)
              ],
            ),
          ),
          SizedBox(
            width: actionWidth.w,
            child: Center(child: SvgPicture.asset(kDeleteIcon,height: 26.h,width: 24.w,)),
          ),
        ],
      ),
    );
  }
}
