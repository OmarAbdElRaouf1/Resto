import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:resto/core/di/di.dart';
import 'package:resto/core/routing/app_router.dart';
import 'package:resto/core/routing/routes.dart';
import 'package:resto/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
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
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          onGenerateRoute: AppRouter().generateRoute,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.initial,
        );
      },
    );
  }
}
