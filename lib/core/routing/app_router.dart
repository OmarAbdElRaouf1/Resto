import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto/core/di/di.dart';
import 'package:resto/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:resto/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:resto/features/auth/presentation/views/login_view.dart';
import 'package:resto/features/auth/presentation/views/register_view.dart';
import 'package:resto/features/cart/cart_view.dart';
import 'package:resto/features/home/domain/entities/product_entity.dart';
import 'package:resto/features/home/presentation/views/home_view.dart';
import 'package:resto/features/home/presentation/views/product_details_view.dart';
import 'package:resto/features/profile/profile_view.dart';
import 'package:resto/root_view.dart';
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
            create: (context) => getIt<LoginCubit>(),
            child: LoginView(),
          ),
        );
      case Routes.registerView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: RegisterView(),
          ),
        );
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.productDetailsView:
        final product = settings.arguments as ProductEntity;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(product: product),
        );
      case Routes.cartView:
        return MaterialPageRoute(builder: (_) => const CartView());
      case Routes.profileView:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.rootView:
        return MaterialPageRoute(builder: (_) => const RootView());

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
