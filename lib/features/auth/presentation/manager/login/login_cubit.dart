import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:resto/features/auth/data/models/user_model.dart';
import 'package:resto/features/auth/data/repos/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login() async {
    emit(LoginLoading());

    try {
      final user = await authRepo.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();

    return super.close();
  }
}
