part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserEntity user;
  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String? errorMessage;
  RegisterFailure({this.errorMessage});
}
