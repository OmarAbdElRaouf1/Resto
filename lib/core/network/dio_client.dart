import 'package:dio/dio.dart';
import 'package:resto/core/helpers/shared_prefs.dart';
import 'package:resto/core/routing/navigator_key.dart';
import 'package:resto/core/routing/routes.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://burger-house-api-83wd.onrender.com/api/',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefs.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await SharedPrefs.removeToken();
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              Routes.loginView,
              (route) => false,
            );
          }

          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
