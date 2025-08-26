import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final double? lineHeight; // NEW: Optional line height

  const CustomText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 15,
    this.color = kBlackColor,
    this.textAlign = TextAlign.left,
    this.lineHeight, // NEW
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Stoshi',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight,
      ),
    );
  }
}
