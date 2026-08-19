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
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32.r),
            bottomRight: Radius.circular(32.r),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 18.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserHeader(userName: userName, userImage: userImage),
                Gap(16.h),
                SearchField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
