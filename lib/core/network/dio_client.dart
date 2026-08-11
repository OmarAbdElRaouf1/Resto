import 'package:dio/dio.dart';
import 'package:resto/core/helpers/shared_prefs.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:5001/api',
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
      ),
    );
  }

  Dio get dio => _dio;
}
