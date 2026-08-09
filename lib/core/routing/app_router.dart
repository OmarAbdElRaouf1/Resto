import 'package:flutter/material.dart';
import 'package:resto/features/auth/presentation/views/login_view.dart';
import 'package:resto/features/auth/presentation/views/register_view.dart';
import 'package:resto/splash_view.dart';

import 'routes.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerView:
        return MaterialPageRoute(builder: (_) => const RegisterView());

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
