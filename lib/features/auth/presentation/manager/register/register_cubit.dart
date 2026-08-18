import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:resto/features/auth/domain/entities/user_entity.dart';
import 'package:resto/features/auth/domain/repositories/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  final AuthRepo authRepo;

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final user = await authRepo.register(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
