import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitterclone/bloc/login/login_bloc.dart';
import 'package:twitterclone/bloc/register/register_event.dart';
import 'package:twitterclone/bloc/register/register_state.dart';
import 'package:twitterclone/utils/helper/validation_helper.dart';

enum RegisterValidationStatusType { empty, valid, invalid }

class RegisterFormValidationStatus {
  ValidationStatusType type;
  String? message;

  RegisterFormValidationStatus({required this.type, this.message});

  RegisterFormValidationStatus copyWith(
      {ValidationStatusType? type, String? message}) {
    return RegisterFormValidationStatus(
        type: type ?? this.type, message: message ?? this.message);
  }
}

class RegisterationBloc extends Bloc<RegisterationEvent, RegisterationState> {
  RegisterationBloc() : super(InitialRegisterState()) {
    on<RegisterCredentialsEvent>((event, emit) {
      RegisterFormValidationStatus nameValidationStatus =
          RegisterFormValidationStatus(type: ValidationStatusType.empty);
      RegisterFormValidationStatus emailValidationStatus =
          RegisterFormValidationStatus(type: ValidationStatusType.empty);
      RegisterFormValidationStatus passwordValidationStatus =
          RegisterFormValidationStatus(type: ValidationStatusType.empty);
      RegisterFormValidationStatus confirmPasswordValidationStatus =
          RegisterFormValidationStatus(type: ValidationStatusType.empty);

      //Name
      if (event.name == null || event.name == "") {
        nameValidationStatus =
            nameValidationStatus.copyWith(message: "Name is Required");
      } else if (Validations.nameValidation(name: event.name!)) {
        nameValidationStatus =
            nameValidationStatus.copyWith(type: ValidationStatusType.valid);
      } else {
        nameValidationStatus =
            nameValidationStatus.copyWith(type: ValidationStatusType.invalid);
      }

      //Email
      if (event.email == null || event.email == "") {
        emailValidationStatus =
            emailValidationStatus.copyWith(message: "Email is Required");
      } else if (Validations.emailValidation(email: event.email!)) {
        emailValidationStatus =
            emailValidationStatus.copyWith(type: ValidationStatusType.valid);
      } else {
        emailValidationStatus =
            emailValidationStatus.copyWith(type: ValidationStatusType.invalid);
      }

      //Password
      if (event.password == null || event.password == "") {
        passwordValidationStatus =
            passwordValidationStatus.copyWith(message: "Password is Required");
      } else if (Validations.passwordValidation(password: event.password!)) {
        passwordValidationStatus =
            passwordValidationStatus.copyWith(type: ValidationStatusType.valid);
      } else {
        passwordValidationStatus = passwordValidationStatus.copyWith(
            type: ValidationStatusType.invalid);
      }

      //Confirm Password
      if (event.confirmPassword == null || event.confirmPassword == "") {
        confirmPasswordValidationStatus = confirmPasswordValidationStatus
            .copyWith(message: "Email is Required");
      } else if (Validations.confirmPasswordValidation(
          password: event.password!, confirmPassword: event.confirmPassword!)) {
        confirmPasswordValidationStatus = confirmPasswordValidationStatus
            .copyWith(type: ValidationStatusType.valid);
      } else {
        confirmPasswordValidationStatus = confirmPasswordValidationStatus
            .copyWith(type: ValidationStatusType.invalid);
      }

      //emit final output
      emit(RegisterFormValidationState(
          nameValidationStatus: nameValidationStatus,
          emailValidationStatus: emailValidationStatus,
          passwordValidationStatus: passwordValidationStatus,
          confirmPasswordValidationStatus: confirmPasswordValidationStatus));
    });

    on<RegisterErrorEvent>(
        (event, emit) => emit(RegisterErrorState(event.error)));

    on<RegisterSuccessfulEvent>(
        (event, emit) => emit(RegisterSuccessfulState()));
  }
}
