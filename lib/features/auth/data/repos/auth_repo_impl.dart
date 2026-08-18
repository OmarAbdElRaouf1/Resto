import 'package:resto/core/helpers/shared_prefs.dart';
import 'package:resto/core/network/api_endpoints.dart';
import 'package:resto/core/network/api_service.dart';
import 'package:resto/features/auth/data/models/user_model.dart';
import 'package:resto/features/auth/domain/entities/user_entity.dart';
import 'package:resto/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this.apiService);
  final ApiService apiService;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(ApiEndpoints.login, {
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
  Future<UserEntity> register({
    required String phone,
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(ApiEndpoints.register, {
      'phone': phone,
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

  @override
  Future<UserEntity> getMe() async {
    final response = await apiService.get(ApiEndpoints.getMe);
    return UserModel.fromJson(response);
  }

  @override
  Future<void> logout() => SharedPrefs.removeToken();
}
