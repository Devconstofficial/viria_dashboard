import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viria_dashboard/custom_widgets/custom_textfield.dart';
import 'package:viria_dashboard/utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_styles.dart';

Widget customHeader(String title) {
  return SizedBox(
    height: 120,
    child: Padding(
      padding: EdgeInsets.only(left: 40.w, right: 44.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 36.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 450.w,
            // height: 60,
            child: CustomTextField(
              hintText: "Search here...",
              isFilled: true,
              fillColor: Colors.grey.shade400,
              borderColor: kWhiteShade2Color,
              borderRadius: 16,
              prefixIcon: kSearchIcon,
              isImagePng: true,
              contentPaddong: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: kOrangeLightColor,
                ),
                child: Center(
                  child: SvgPicture.asset(kNotiIcon, height: 24, width: 24),
                ),
              ),
              SizedBox(width: 19.w),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(kPersonImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 13.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    "Musfiq",
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Admin",
                    style: AppStyles.greyTextStyle().copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
