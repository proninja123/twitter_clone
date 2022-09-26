class Validations {
  static bool emailValidation({required String email}) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  static bool passwordValidation({required String password}) {
    if (password.length > 6) {
      return true;
    } else {
      return false;
    }
  }

  static bool confirmPasswordValidation(
      {required String password, required String confirmPassword}) {
    if (password == confirmPassword && confirmPassword.length > 6) {
      return true;
    } else {
      return false;
    }
  }

  static bool nameValidation({required String name}) {
    if (name.length > 3) {
      return true;
    } else {
      return false;
    }
  }
}
