abstract class LoginPageEvent{}

class LoginPageInitialLoginPageEvent extends LoginPageEvent{}

class LoginPageLoadingPageEvent extends LoginPageEvent{}

class LoginPageCredentialsEvent extends LoginPageEvent {
  String? email;
  String? password;
  LoginPageCredentialsEvent({this.email, this.password});
}

class LoginSuccessfulEvent extends LoginPageEvent{}

class LoginPageErrorEvent extends LoginPageEvent{
  final String error;
  LoginPageErrorEvent(this.error);
}