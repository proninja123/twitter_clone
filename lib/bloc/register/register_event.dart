abstract class RegisterationEvent {}

class InitialRegisterPageEvent extends RegisterationEvent {}

class RegisterCredentialsEvent extends RegisterationEvent {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;

  RegisterCredentialsEvent(
      {this.name, this.email, this.password, this.confirmPassword});
}

class RegisterErrorEvent extends RegisterationEvent{
  final String error;
  RegisterErrorEvent(this.error);
}

class RegisterSuccessfulEvent extends RegisterationEvent {}
