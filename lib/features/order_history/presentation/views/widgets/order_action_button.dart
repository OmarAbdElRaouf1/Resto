import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_text.dart';

class OrderActionButton extends StatelessWidget {
  const OrderActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.filled,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final contentColor = filled ? Colors.white : AppColors.primaryColor;

    return Material(
      color: filled ? AppColors.primaryColor : Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: filled
                ? null
                : Border.all(color: AppColors.primaryColor, width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16.r, color: contentColor),
              Gap(6.w),
              CustomText(
                text: label,
                size: 13.sp,
                weight: FontWeight.w600,
                color: contentColor,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
