import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';

void showAnimatedSnackbar(
  BuildContext context, {
  required String message,
  AnimatedSnackBarType type = AnimatedSnackBarType.success,
}) {
  final (backgroundColor, iconData) = switch (type) {
    AnimatedSnackBarType.success => (
      AppColors.success,
      Icons.check_circle_outline,
    ),
    AnimatedSnackBarType.error => (AppColors.error, Icons.error_outline),
    AnimatedSnackBarType.info => (AppColors.info, Icons.info_outline),
    AnimatedSnackBarType.warning => (
      AppColors.warning,
      Icons.warning_amber_rounded,
    ),
  };

  AnimatedSnackBar.removeAll();

  AnimatedSnackBar(
    duration: const Duration(seconds: 4),
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(iconData, color: AppColors.white, size: 22.w),
            Gap(12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    },
  ).show(context);
}
