import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_text.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userImage,
  });

  final String userName;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 28.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Gap(12.h),
            CircleAvatar(
              radius: 44.r,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200.r),
                child: Image.network(
                  userImage,
                  width: 84.r,
                  height: 84.r,
                  fit: BoxFit.cover,
                  cacheWidth: 168,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                    size: 44.r,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            Gap(12.h),
            CustomText(
              text: userName,
              size: 20.sp,
              weight: FontWeight.w600,
              color: Colors.white,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
