import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_text.dart';
import 'package:resto/core/widgets/fade_slide_in.dart';
import 'package:resto/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:resto/features/auth/presentation/views/widgets/have_account.dart';
import 'package:resto/features/auth/presentation/views/widgets/register_form.dart';
import 'package:resto/features/auth/presentation/views/widgets/register_success_dialog.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
              showRegisterSuccessDialog(context);
            }
          },
          builder: (context, state) {
            final isLoading = state is RegisterLoading;

            return Center(
              child: FadeSlideIn(
                duration: const Duration(milliseconds: 450),
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

                    RegisterForm(
                      isLoading: isLoading,
                      onSubmit: (name, email, password) => context
                          .read<RegisterCubit>()
                          .register(
                            name: name,
                            email: email,
                            password: password,
                          ),
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
}
