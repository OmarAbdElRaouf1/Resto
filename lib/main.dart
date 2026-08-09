import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:resto/core/routing/app_router.dart';
import 'package:resto/splash_view.dart';

void main() {
  runApp(const Resto());
}

class Resto extends StatelessWidget {
  const Resto({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(430, 932),
      ensureScreenSize: true,
      splitScreenMode: true,
      child: MaterialApp(
        onGenerateRoute: AppRouter().generateRoute,
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
