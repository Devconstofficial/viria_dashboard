import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double borderRadius;
  final String title;
  final Color textColor;
  final Color color;
  final double width;
  final double height;
  final double textSize;
  final Function()? onTap;
  final bool showShadow;
  final bool showGradient;
  final bool showBorder;
  final Color? borderColor;
  final String? icon;
  final FontWeight fontWeight;
  final Color? iconColor;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor = kWhiteColor,
    this.color = kPrimaryColor,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 16,
    this.textSize = 16,
    this.showShadow = false,
    this.showGradient = false,
    this.showBorder = true,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: showBorder == true ? LinearGradient(
              colors: [
                kPrimaryColor1,
                kPrimaryColor4,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ) : null,
            boxShadow: showShadow == true ? [
              BoxShadow(
                color: kPrimaryColor5.withOpacity(0.32),
                spreadRadius: 0,
                blurRadius: 24,
                offset: Offset(0, 0)
              ),
              BoxShadow(
                  color: kBlackColor,
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(0, 3)
              )
            ] : [],
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius - 1),
                gradient: showGradient == true
                    ? LinearGradient(
                    colors: [
                      kPrimaryColor.withOpacity(0.8),
                      kPrimaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight
                )
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Image.asset(
                      icon!,
                      height: 20.h,
                      width: 20.w,
                      color: iconColor,
                    ),
                    SizedBox(width: 6.w),
                  ],
                  CustomText(
                    text: title,
                    fontSize: textSize,
                    color: textColor,
                    fontWeight: fontWeight,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
