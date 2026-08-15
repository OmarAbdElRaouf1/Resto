import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:resto/features/auth/domain/entities/user_entity.dart';
import 'package:resto/features/auth/domain/repositories/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final user = await authRepo.login(email: email, password: password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
