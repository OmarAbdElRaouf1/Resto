import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto/core/di/di.dart';
import 'package:resto/core/routing/fade_page_route.dart';
import 'package:resto/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:resto/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:resto/features/auth/presentation/views/login_view.dart';
import 'package:resto/features/auth/presentation/views/register_view.dart';
import 'package:resto/features/cart/presentation/cart_view.dart';
import 'package:resto/features/cart/presentation/manager/cubit/cart_cubit.dart';
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
        return FadeSlidePageRoute(
          settings: settings,
          builder: (_) => const SplashView(),
        );
      case Routes.loginView:
        return FadeSlidePageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        );
      case Routes.registerView:
        return FadeSlidePageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterView(),
          ),
        );
      case Routes.homeView:
        return FadeSlidePageRoute(
          settings: settings,
          builder: (_) => const HomeView(),
        );
      case Routes.productDetailsView:
        final product = settings.arguments as ProductEntity;
        // CupertinoPageRoute (not our custom FadeSlidePageRoute) so the
        // native iOS edge-swipe-to-pop gesture works here.
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => getIt<CartCubit>(),
            child: ProductDetailsView(product: product),
          ),
        );
      case Routes.cartView:
        return FadeSlidePageRoute(
          settings: settings,
          builder: (_) => const CartView(),
        );
      case Routes.profileView:
        return FadeSlidePageRoute(
          settings: settings,
          builder: (_) => const ProfileView(),
        );
      case Routes.rootView:
        return FadeSlidePageRoute(
          settings: settings,
          builder: (_) => const RootView(),
        );

      default:
        return FadeSlidePageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for "${settings.name}"'),
            ),
          ),
        );
    }
  }
}
