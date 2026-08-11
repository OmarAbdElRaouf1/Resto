import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:resto/features/auth/data/models/user_model.dart';
import 'package:resto/features/auth/data/repos/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  final AuthRepo authRepo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> register() async {
    emit(RegisterLoading());
    try {
      final user = await authRepo.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
