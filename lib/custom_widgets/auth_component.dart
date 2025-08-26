import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:viria_dashboard/custom_widgets/custom_text.dart';
import '../screens/auth_screens/controller/auth_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';

class AuthComponent extends StatelessWidget {
  Widget content;
  String image;
  bool isAuth;
  AuthComponent({super.key,required this.content,required this.image,this.isAuth = false});

  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: Get.height,
        child: Row(
          children: [

            Expanded(
              child: SizedBox(
                height: height,
                width: width,
                child: Center(
                  child: SizedBox(
                    width: 444.w,
                    child: content,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: Get.height,
                    child: Stack(
                      children: [
                        SizedBox(
                            height: Get.height,
                            child: Image.asset(image,fit: BoxFit.contain,)),
                        isAuth == true
                            ? Positioned(
                          left: 40.w,
                          bottom: 40.h,
                          right: 90.w,
                          child: Column(
                            spacing: 16,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Manage, \nMonitor, \nand Grow.",fontWeight: FontWeight.bold,fontSize: 60.sp,color: kWhiteColor,lineHeight: 1.2,),
                              CustomText(text: "Access your dashboard to manage users, track performance, and keep everything ",fontWeight: FontWeight.w400,fontSize: 20.sp,color: kWhiteColor,),
                            ],
                          ),
                        )
                            : SizedBox.shrink()
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
