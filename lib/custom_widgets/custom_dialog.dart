import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class CustomDialog extends StatefulWidget {
  Widget widget;
  double intentPadding;
  double width;
  String title;
  CustomDialog({super.key,
    required this.widget,
    required this.title,
    this.intentPadding = 29,
    this.width = 466,
  });

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: widget.intentPadding),
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: widget.width,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: AppStyles.blackTextStyle()
                        .copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: kDarkBlueColor,
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: kRedColor1.withOpacity(0.04),
                        child: Center(child: Icon(Icons.close,size: 12,color: kRedColor1,)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              widget.widget
            ],
          ),
        ),
      ),
    );
  }
}
