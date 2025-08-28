import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viria_dashboard/utils/app_styles.dart';

class LegendDot extends StatelessWidget {
  final Color color;
  final String text;

  const LegendDot({required this.color, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        SizedBox(width: 4),
        Text(text, style: AppStyles.nunitoTextStyle().copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500)),
      ],
    );
  }
}