import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomPagination extends StatelessWidget {
  final int currentPage;
  final List<int> visiblePages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Function(int) onPageSelected;

  const CustomPagination({
    super.key,
    required this.currentPage,
    required this.visiblePages,
    required this.onPrevious,
    required this.onNext,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPrevious,
          child: Container(
            height: 43,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: kBlackColor.withOpacity(0.08)),
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: kPrimaryColor,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: const Icon(Icons.arrow_right_alt, size: 15,color: kWhiteColor,),
                  ),
                ),
                Text("Previous", style: AppStyles.blackTextStyle().copyWith(fontSize: 12)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),

        ...visiblePages.map((page) {
          final isSelected = currentPage == page;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () => onPageSelected(page),
              child: Container(
                height: 43,
                width: 49,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected ? kPrimaryColor.withOpacity(0.1) : kWhiteColor,
                  border: Border.all(
                    color: isSelected ? kPrimaryColor : kBlackColor.withOpacity(0.08),
                  ),
                ),
                child: Center(
                  child: Text(
                    page.toString(),
                    style: AppStyles.nunitoTextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kBlackColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),

        const SizedBox(width: 18),

        GestureDetector(
          onTap: onNext,
          child: Container(
            height: 43,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: kBlackColor.withOpacity(0.08)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Next", style: AppStyles.blackTextStyle().copyWith(fontSize: 12)),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: kPrimaryColor,
                  child: const Icon(Icons.arrow_right_alt, size: 15,color: kWhiteColor,),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
