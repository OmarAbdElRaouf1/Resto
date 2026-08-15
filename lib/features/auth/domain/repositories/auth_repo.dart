import 'package:resto/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });
}
