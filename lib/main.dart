import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:resto/core/di/di.dart';
import 'package:resto/core/helpers/shared_prefs.dart';
import 'package:resto/core/routing/app_router.dart';
import 'package:resto/core/routing/routes.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupServiceLocator();

  final token = await SharedPrefs.getToken();
  final initialRoute = token != null && token.isNotEmpty
      ? Routes.rootView
      : Routes.loginView;

  runApp(Resto(initialRoute: initialRoute));

  FlutterNativeSplash.remove();
}

class Resto extends StatelessWidget {
  const Resto({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(430, 932),
      ensureScreenSize: true,
      splitScreenMode: true,
      child: MaterialApp(
        onGenerateRoute: AppRouter().generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
      ),
    );
  }
}
