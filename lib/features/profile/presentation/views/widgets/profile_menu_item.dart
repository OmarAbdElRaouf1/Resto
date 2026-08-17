import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_text.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primaryColor).withValues(
                  alpha: 0.1,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18.r,
                color: iconColor ?? AppColors.primaryColor,
              ),
            ),
            Gap(14.w),
            Expanded(
              child: CustomText(
                text: label,
                size: 14.sp,
                weight: FontWeight.w500,
                color: labelColor ?? Colors.grey.shade800,
                maxLines: 1,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.r,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
