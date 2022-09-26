import 'package:twitterclone/bloc/register/register_bloc.dart';

abstract class RegisterationState {}

class InitialRegisterState extends RegisterationState {}

class RegisterFormValidationState extends RegisterationState {
  RegisterFormValidationStatus nameValidationStatus;
  RegisterFormValidationStatus emailValidationStatus;
  RegisterFormValidationStatus passwordValidationStatus;
  RegisterFormValidationStatus confirmPasswordValidationStatus;

  RegisterFormValidationState(
      {required this.nameValidationStatus,
      required this.emailValidationStatus,
      required this.passwordValidationStatus,
      required this.confirmPasswordValidationStatus});
}

class RegisterErrorState extends RegisterationState {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterSuccessfulState extends RegisterationState {}
