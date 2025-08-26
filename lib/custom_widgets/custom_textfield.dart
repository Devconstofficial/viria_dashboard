import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isObscure;
  final Color borderColor;
  final Color hintColor;
  final bool isStyle;
  final TextInputType textInputType;
  final bool readOnly;
  final Widget? suffix;
  final String? prefixIcon;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final bool isFilled;
  final Color fillColor;
  final bool isCustomFilled;
  final bool? isImagePng;
  final Color? iconColor;
  final EdgeInsets? contentPaddong;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.isObscure = false,
    this.borderColor = kBlackShade7Color,
    this.fillColor = kWhiteShade2Color,
    this.isFilled = false,
    this.hintColor = kGreyColor,
    this.isStyle = false,
    this.textInputType = TextInputType.text,
    this.readOnly = false,
    this.isImagePng = false,
    this.suffix,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
    this.borderRadius = 16,
    this.isCustomFilled = false,
    this.iconColor,
    this.contentPaddong,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: isObscure,
      readOnly: readOnly,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onTap: onTap,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: hintColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400
        ),
        suffixIcon: suffix,
        prefixIcon: prefixIcon != null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: isImagePng == true ?Image.asset(
            prefixIcon!,
            height: 24,
            width: 24,
          ) : SvgPicture.asset(
            prefixIcon!,
            height: 24,
            width: 24,
            color: iconColor ?? kBlackColor.withOpacity(0.6),
          ),
        )
            : null,
        contentPadding: contentPaddong ?? EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
        filled: isFilled || isCustomFilled,
        fillColor: isCustomFilled ? fillColor : fillColor.withOpacity(0.07),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor.withOpacity(0.5),
          ),
        ),
      ),
      style: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: kBlackColor,
      ),
    );
  }
}

