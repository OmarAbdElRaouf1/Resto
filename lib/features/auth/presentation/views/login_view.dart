import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/helpers/extensions.dart';
import 'package:resto/core/routing/routes.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/fade_slide_in.dart';
import 'package:resto/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:resto/features/auth/presentation/views/widgets/dont_have_account.dart';
import 'package:resto/features/auth/presentation/views/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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

            return Center(
              child: FadeSlideIn(
                duration: const Duration(milliseconds: 450),
                child: Column(
                  children: [
                    Gap(100.h),

                    SvgPicture.asset('assets/vectors/resto_logo.svg'),

                    Gap(20.h),

                    LoginForm(
                      isLoading: isLoading,
                      onSubmit: (email, password) => context
                          .read<LoginCubit>()
                          .login(email: email, password: password),
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
}
