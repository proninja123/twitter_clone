import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitterclone/bloc/login/login_bloc.dart';
import 'package:twitterclone/bloc/login/login_event.dart';
import 'package:twitterclone/bloc/login/login_state.dart';
import 'package:twitterclone/data/service/authetication_services.dart';
import 'package:twitterclone/utils/constants/paths.dart';
import 'package:twitterclone/utils/helper/validation_helper.dart';
import 'package:twitterclone/utils/widgets/custom_text_field.dart';
import 'package:twitterclone/utils/widgets/debounce.dart';
import 'package:twitterclone/view/authetication/registeration_screen.dart';
import 'package:twitterclone/view/home/homepage_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode loginEmailFocusNode = FocusNode();
  final FocusNode loginPasswordFocusNode = FocusNode();
  final FocusNode registerNameFocusNode = FocusNode();
  final FocusNode registerEmailFocusNode = FocusNode();
  final FocusNode registerPasswordFocusNode = FocusNode();
  final FocusNode registerConfirmPasswordFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> _loginScaffoldKey = GlobalKey<ScaffoldState>();
  final _debouncer = Debouncer(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider<LoginPageBloc>(
      create: (context) => LoginPageBloc(),
      child: BlocConsumer<LoginPageBloc, LoginPageState>(
        builder: (context, state) {
          return Scaffold(
            key: _loginScaffoldKey,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 0,
              title: const Text('LoginScreen'),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Image.asset(
                    AppPaths.twitterLogo,
                    height: 20,
                  )),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "See what's happening in the world right Now.",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        focusNode: loginEmailFocusNode,
                        controller: _emailController,
                        onChanged: (email) {
                          _debouncer.run(() {
                            validate(context);
                          });
                        },
                        icon: (state is FormValidationStatus)
                            ? state.emailValidationStatus.type ==
                                    ValidationStatusType.valid
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : state.emailValidationStatus.type ==
                                        ValidationStatusType.invalid
                                    ? const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.red,
                                      )
                                    : const SizedBox.shrink()
                            : const SizedBox.shrink(),
                        textInputAction: TextInputAction.next,
                        labelText: "Email",
                        hintText: "Enter Email",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        focusNode: loginPasswordFocusNode,
                        controller: _passwordController,
                        onChanged: (password) {
                          _debouncer.run(() {
                            validate(context);
                          });
                        },
                        icon: (state is FormValidationStatus)
                            ? state.passwordValidationStatus.type ==
                                    ValidationStatusType.valid
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : state.passwordValidationStatus.type ==
                                        ValidationStatusType.invalid
                                    ? const Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.red,
                                      )
                                    : const SizedBox.shrink()
                            : const SizedBox.shrink(),
                        textInputAction: TextInputAction.done,
                        labelText: "Password",
                        hintText: "Enter Password",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      if (Validations.emailValidation(
                              email: _emailController.text) &&
                          Validations.passwordValidation(
                              password: _passwordController.text)) {
                        AuthenticationServices().signInWithUserAndEmail(context,
                            _emailController.text, _passwordController.text);
                      } else if (Validations.emailValidation(
                              email: _emailController.text) ==
                          false) {
                        loginEmailFocusNode.requestFocus();
                      } else if (Validations.passwordValidation(
                              password: _passwordController.text) ==
                          false) {
                        loginPasswordFocusNode.requestFocus();
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegistrationScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      primary: Colors.black54,
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is LoginPageErrorState) {
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(milliseconds: 700),
              content: Text(state.message),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is SuccessfulLoginState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomepageScreen()));
          }
        },
      ),
    );
  }

  void validate(BuildContext context) {
    context.read<LoginPageBloc>().add(
          LoginPageCredentialsEvent(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }
}
