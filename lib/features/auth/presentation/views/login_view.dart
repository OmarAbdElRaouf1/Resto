import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/helpers/extensions.dart';
import 'package:resto/core/routing/routes.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_button.dart';
import 'package:resto/core/widgets/custom_text.dart';
import 'package:resto/core/widgets/custom_text_field.dart';
import 'package:resto/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:resto/features/auth/presentation/views/widgets/dont_have_account.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Login failed'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            } else if (state is LoginSuccess) {
              context.pushAndRemoveUntil(Routes.homeView);
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            final cubit = context.read<LoginCubit>();

            return Center(
              child: Form(
                key: cubit.formKey,
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
                      controller: cubit.emailController,
                    ),

                    Gap(20.h),

                    CustomTextfield(
                      hint: 'Password',
                      isPassword: true,
                      controller: cubit.passwordController,
                    ),

                    Gap(20.h),

                    CustomButton(
                      text: isLoading ? 'Logging in...' : 'Login',
                      onTap: isLoading ? null : _login,
                      textColor: Colors.white,
                      color: Colors.white.withValues(alpha: 0.40),
                    ),

                    Gap(20.h),

                    DontHaveAccount(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _login() async {
    final cubit = context.read<LoginCubit>();

    if (cubit.formKey.currentState!.validate()) {
      try {
        await cubit.login();
      } catch (e) {
        log('Login failed: $e');
      }
    }
  }
}
