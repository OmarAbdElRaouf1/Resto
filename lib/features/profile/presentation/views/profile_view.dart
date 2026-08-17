import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/helpers/shared_prefs.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/features/profile/presentation/views/widgets/logout_button.dart';
import 'package:resto/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:resto/features/profile/presentation/views/widgets/profile_menu_item.dart';
import 'package:resto/features/profile/presentation/views/widgets/profile_menu_section.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String userName = 'Guest';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final savedName = await SharedPrefs.getUserName();
    if (!mounted || savedName == null) return;
    setState(() => userName = savedName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        AppColors.primaryColor.withValues(alpha: 0.1),
        Colors.white,
      ),
      body: Column(
        children: [
          ProfileHeader(
            userName: userName,
            userImage:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvts5aHBstDkR8PigS4RmZkbZy78zpZoSuOw&s',
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 24.h,
                bottom: 120.h,
              ),
              children: [
                ProfileMenuSection(
                  title: 'ACCOUNT',
                  items: [
                    ProfileMenuItem(
                      icon: Icons.receipt_long_rounded,
                      label: 'My Orders',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.favorite_border_rounded,
                      label: 'Favorites',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.location_on_outlined,
                      label: 'Addresses',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.credit_card_outlined,
                      label: 'Payment Methods',
                      onTap: () {},
                    ),
                  ],
                ),
                Gap(20.h),
                ProfileMenuSection(
                  title: 'PREFERENCES',
                  items: [
                    ProfileMenuItem(
                      icon: Icons.notifications_none_rounded,
                      label: 'Notifications',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.language_rounded,
                      label: 'Language',
                      onTap: () {},
                    ),
                  ],
                ),
                Gap(20.h),
                ProfileMenuSection(
                  title: 'SUPPORT',
                  items: [
                    ProfileMenuItem(
                      icon: Icons.help_outline_rounded,
                      label: 'Help Center',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.info_outline_rounded,
                      label: 'About',
                      onTap: () {},
                    ),
                  ],
                ),
                Gap(28.h),
                const LogoutButton(),
                Gap(20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
