import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/routing/routes.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_button.dart';
import 'package:resto/core/widgets/custom_text.dart';
import 'package:resto/core/widgets/custom_text_field.dart';
import 'package:resto/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:resto/features/auth/presentation/views/widgets/have_account.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Registration failed'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            } else if (state is RegisterSuccess) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Registration Successful'),
                    content: const Text('You have successfully registered.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();

                          Navigator.of(
                            context,
                          ).pushReplacementNamed(Routes.loginView);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<RegisterCubit>();
            final isLoading = state is RegisterLoading;

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
                      hint: 'Name',
                      isPassword: false,
                      controller: cubit.nameController,
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

                    CustomTextfield(
                      hint: 'Confirm Password',
                      isPassword: true,
                      controller: cubit.confirmPasswordController,
                    ),

                    Gap(20.h),

                    CustomButton(
                      text: isLoading ? 'Registering...' : 'Register',
                      onTap: isLoading ? null : register,
                      textColor: Colors.white,
                      color: Colors.white.withValues(alpha: 0.40),
                    ),

                    Gap(20.h),

                    HaveAccount(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> register() async {
    final cubit = context.read<RegisterCubit>();

    if (cubit.formKey.currentState!.validate()) {
      try {
        await cubit.register();
      } catch (e) {
        log('Register failed: $e');
      }
    }
  }
}
