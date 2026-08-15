import 'package:resto/core/helpers/shared_prefs.dart';
import 'package:resto/core/network/api_edpoints.dart';
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
    final response = await apiService.post(ApiEdpoints.login, {
      'email': email,
      'password': password,
    });
    final user = UserModel.fromJson(response);
    if (user.token != null) {
      await SharedPrefs.saveToken(user.token!);
    }
    await SharedPrefs.saveUserName(user.name);
    return user;
  }

  @override
  Future<UserEntity> register({
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
    await SharedPrefs.saveUserName(user.name);
    return user;
  }
}
