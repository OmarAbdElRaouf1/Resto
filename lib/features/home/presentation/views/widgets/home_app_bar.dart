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
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,

      pinned: true,
      floating: false,

      toolbarHeight: 170.h,

      automaticallyImplyLeading: false,

      clipBehavior: Clip.antiAlias,

      flexibleSpace: _buildFlexibleSpace(),
    );
  }

  Widget _buildFlexibleSpace() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(32.r),
        bottomRight: Radius.circular(32.r),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Column(
          children: [
            UserHeader(userName: userName, userImage: userImage),

            Gap(33.h),

            SearchField(
              controller: searchController,
              onChanged: onSearchChanged,
            ),
          ],
        ),
      ),
    );
  }
}
