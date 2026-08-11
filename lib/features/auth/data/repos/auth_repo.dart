import 'package:resto/core/helpers/shared_prefs.dart';
import 'package:resto/core/network/api_edpoints.dart';
import 'package:resto/core/network/api_service.dart';
import 'package:resto/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRepoimpl implements AuthRepo {
  ApiService apiService = ApiService();
  //login
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(ApiEdpoints.login, {
      'email': email,
      'password': password,
    });
    final user = UserModel.fromJson(response);
    if (user.token != null) {
      await SharedPrefs.saveToken(user.token!);
    }
    return user;
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(ApiEdpoints.register, {
      'name': name,
      'email': email,
      'password': password,
    });
    final user = UserModel.fromJson(response);
    if (user.token != null) {
      await SharedPrefs.saveToken(user.token!);
    }
    return user;
  }
  //register

  //get user data
}
