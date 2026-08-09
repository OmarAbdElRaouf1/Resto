import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/helpers/extensions.dart';
import 'package:resto/core/routing/routes.dart';
import 'package:resto/core/theme/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigateToHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const Gap(280),
          SvgPicture.asset('assets/vectors/hungry_logo.svg'),
          const Spacer(),
          Image.asset('assets/images/splash_logo.png'),
        ],
      ),
    );
  }

  Future<void> navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    // Navigate to the home screen after the delay
    // ignore: use_build_context_synchronously
    context.pushReplacementNamed(Routes.loginView);
  }
}
