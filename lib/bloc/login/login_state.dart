import 'login_bloc.dart';

abstract class LoginPageState {}

class InitialLoginPageState extends LoginPageState{}

class FormValidationStatus extends LoginPageState {
  FieldValidationStatus emailValidationStatus ;
  FieldValidationStatus passwordValidationStatus;

  FormValidationStatus(
      {required this.emailValidationStatus, required this.passwordValidationStatus});
}

class LoginPageLoadingState extends LoginPageState {}

class LoginPagePressState extends LoginPageState {}

class LoginPageErrorState extends LoginPageState {
  final String message;

  LoginPageErrorState(this.message);
}

class SuccessfulLoginState extends LoginPageState{}