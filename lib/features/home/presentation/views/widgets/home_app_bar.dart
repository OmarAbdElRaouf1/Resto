import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/features/home/presentation/views/widgets/search_field.dart';
import 'package:resto/features/home/presentation/views/widgets/user_header.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.userName,
    required this.userImage,
    required this.searchController,
    this.onSearchChanged,
  });

  final String userName;
  final String userImage;
  final TextEditingController searchController;
  final Function(String)? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      floating: false,
      toolbarHeight: 170.h,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.primaryColor,
      automaticallyImplyLeading: false,
      flexibleSpace: _buildFlexibleSpace(),
    );
  }

  Widget _buildFlexibleSpace() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.only(top: 50.h, right: 20.w, left: 20.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.90),
          ),
          child: Column(
            children: [
              UserHeader(userName: userName, userImage: userImage),

              Gap(12.h),

              SearchField(
                controller: searchController,
                onChanged: onSearchChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
