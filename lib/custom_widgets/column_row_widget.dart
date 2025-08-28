import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_images.dart';
import '../utils/app_styles.dart';

class ColumnRowWidget extends StatelessWidget {
  String title;
  ColumnRowWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 13,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style:
          AppStyles.nunitoTextStyle()
              .copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),
        ),
        SvgPicture.asset(kDropDownIcon,height: 7,width: 8,)
      ],
    );
  }
}
