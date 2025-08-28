import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomDropdown extends StatelessWidget {
  final RxString selected;
  final List<String> items;
  final String hint;
  final double height;

  const CustomDropdown({
    super.key,
    required this.selected,
    required this.items,
    required this.hint,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: Obx(() {
        final value = selected.value.isEmpty ? null : selected.value;
        return DropdownButtonFormField2<String>(
          value: value,
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            maxHeight: 230,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          hint: Text(
            hint,
            style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp,color: kDarkBlueColor),
          ),
          style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w400,color: kDarkBlueColor),

          decoration: InputDecoration(
            hintStyle: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w400,color: kDarkBlueColor),
            filled: true,

            fillColor: kWhiteShade5Color,
            contentPadding: EdgeInsets.only(right: 12.w,top: 10.h,bottom: 10.h,left: 12.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: kWhiteShade5Color),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: kWhiteShade5Color),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: kWhiteShade5Color),
            ),
          ),
          items: items
              .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e, style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
          ))
              .toList(),
          onChanged: (v) => selected.value = v ?? '',
        );
      }),
    );
  }
}
