import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitterclone/bloc/login/login_event.dart';
import 'package:twitterclone/bloc/login/login_state.dart';
import 'package:twitterclone/utils/helper/validation_helper.dart';

enum ValidationStatusType { empty, valid, invalid }

class FieldValidationStatus {
  final ValidationStatusType type;
  final String? message;

  FieldValidationStatus({required this.type, this.message});

  FieldValidationStatus copyWith({
    ValidationStatusType? type,
    String? message,
  }) {
    return FieldValidationStatus(
        type: type ?? this.type, message: message ?? this.message);
  }
}

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(InitialLoginPageState()) {
    on<LoginPageCredentialsEvent>((event, emit) async {
      FieldValidationStatus emailValidationStatus =
          FieldValidationStatus(type: ValidationStatusType.empty);
      FieldValidationStatus passwordValidationStatus =
          FieldValidationStatus(type: ValidationStatusType.empty);

      //email
      if (event.email == null || event.email == "") {
        emailValidationStatus =
            emailValidationStatus.copyWith(message: "This field is required");
      } else if (Validations.emailValidation(email: event.email!)) {
        emailValidationStatus = emailValidationStatus.copyWith(
            type: ValidationStatusType.valid, message: "");
      } else {
        emailValidationStatus = emailValidationStatus.copyWith(
            type: ValidationStatusType.invalid,
            message: "Please enter a valid email");
      }

      //password
      if (event.password == null || event.password == "") {
        passwordValidationStatus = passwordValidationStatus.copyWith(
            message: "This field is required");
      } else if (Validations.passwordValidation(password: event.password!)) {
        passwordValidationStatus = passwordValidationStatus.copyWith(
            type: ValidationStatusType.valid, message: "");
      } else {
        passwordValidationStatus = passwordValidationStatus.copyWith(
            type: ValidationStatusType.invalid,
            message: "Password length must be at least 6 characters.");
      }

      return emit(FormValidationStatus(
          emailValidationStatus: emailValidationStatus,
          passwordValidationStatus: passwordValidationStatus));
    }, transformer: droppable());

    on<LoginPageErrorEvent>(
        (event, emit) => emit(LoginPageErrorState(event.error)));

    on<LoginSuccessfulEvent>((event, emit) => emit(SuccessfulLoginState()));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
