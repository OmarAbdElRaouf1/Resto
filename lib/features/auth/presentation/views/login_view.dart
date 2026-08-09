import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_button.dart';
import 'package:resto/core/widgets/custom_text.dart';
import 'package:resto/core/widgets/custom_text_field.dart';
import 'package:resto/features/auth/presentation/views/widgets/dont_have_account.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(100.h),
                SvgPicture.asset('assets/vectors/hungry_logo.svg'),
                Gap(10.h),
                CustomText(
                  text: 'Welcome to Resto',
                  size: 24.sp,
                  color: Colors.white,
                  weight: FontWeight.w400,
                ),
                Gap(20.h),
                CustomTextfield(
                  hint: 'Email',
                  isPassword: false,
                  controller: emailController,
                ),
                Gap(20.h),
                CustomTextfield(
                  hint: 'Password',
                  isPassword: true,
                  controller: passwordController,
                ),
                Gap(20.h),
                CustomButton(
                  text: 'Login',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      log(
                        'Email: ${emailController.text}, Password: ${passwordController.text}',
                      );
                    }
                  },
                  textColor: Colors.white60,
                  color: Colors.white.withOpacity(0.10),
                ),
                Gap(20.h),
                DontHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
