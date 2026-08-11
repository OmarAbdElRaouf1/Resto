import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto/core/di/di.dart';
import 'package:resto/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:resto/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:resto/features/auth/presentation/views/login_view.dart';
import 'package:resto/features/auth/presentation/views/register_view.dart';
import 'package:resto/features/home/presentation/views/home_view.dart';
import 'package:resto/splash_view.dart';

import 'routes.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: LoginView(),
          ),
        );
      case Routes.registerView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<RegisterCubit>(),
            child: RegisterView(),
          ),
        );
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for "${settings.name}"'),
            ),
          ),
        );
    }
  }
}
