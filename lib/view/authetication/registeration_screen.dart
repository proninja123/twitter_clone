import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitterclone/bloc/login/login_bloc.dart';
import 'package:twitterclone/bloc/register/register_bloc.dart';
import 'package:twitterclone/bloc/register/register_event.dart';
import 'package:twitterclone/bloc/register/register_state.dart';
import 'package:twitterclone/data/service/authetication_services.dart';
import 'package:twitterclone/utils/constants/colors.dart';
import 'package:twitterclone/utils/constants/paths.dart';
import 'package:twitterclone/utils/helper/validation_helper.dart';
import 'package:twitterclone/utils/widgets/custom_text_field.dart';
import 'package:twitterclone/utils/widgets/debounce.dart';
import 'package:twitterclone/view/home/homepage_screen.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode loginEmailFocusNode = FocusNode();
  final FocusNode loginPasswordFocusNode = FocusNode();
  final FocusNode registerNameFocusNode = FocusNode();
  final FocusNode registerEmailFocusNode = FocusNode();
  final FocusNode registerPasswordFocusNode = FocusNode();
  final FocusNode registerConfirmPasswordFocusNode = FocusNode();

  final _debouncer = Debouncer(milliseconds: 700);

  final GlobalKey<ScaffoldState> _registerScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterationBloc>(
      create: (context) => RegisterationBloc(),
      child: Scaffold(
        key: _registerScaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          leadingWidth: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  )),
              const Spacer(),
              Image.asset(
                AppPaths.twitterLogo,
                height: 20,
              ),
              const Spacer(),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ),
        body: BlocConsumer<RegisterationBloc, RegisterationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Create your account.",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlocBuilder<RegisterationBloc, RegisterationState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextField(
                              focusNode: registerNameFocusNode,
                              controller: _nameController,
                              onChanged: (registerName) {
                                _debouncer.run(() {
                                  validate(context);
                                });
                              },
                              hintText: "Enter Name",
                              labelText: "Name",
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              icon: (state is RegisterFormValidationState)
                                  ? state.nameValidationStatus.type ==
                                          ValidationStatusType.valid
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        )
                                      : state.nameValidationStatus.type ==
                                              ValidationStatusType.invalid
                                          ? const Icon(
                                              Icons.cancel_rounded,
                                              color: Colors.red,
                                            )
                                          : const SizedBox.shrink()
                                  : const SizedBox.shrink(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              focusNode: registerEmailFocusNode,
                              controller: _emailController,
                              onChanged: (registerEmail) {
                                _debouncer.run(() {
                                  validate(context);
                                });
                              },
                              hintText: "Enter Email",
                              labelText: "Email",
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              icon: (state is RegisterFormValidationState)
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
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              focusNode: registerPasswordFocusNode,
                              controller: _passwordController,
                              onChanged: (password) {
                                _debouncer.run(() {
                                  validate(context);
                                });
                              },
                              hintText: "Enter Password",
                              labelText: "Password",
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              icon: (state is RegisterFormValidationState)
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
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              focusNode: registerConfirmPasswordFocusNode,
                              controller: _confirmPasswordController,
                              onChanged: (registerEmail) {
                                _debouncer.run(() {
                                  validate(context);
                                });
                              },
                              hintText: "Enter Confirm Password",
                              labelText: "Confirm Password",
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              icon: (state is RegisterFormValidationState)
                                  ? state.confirmPasswordValidationStatus
                                              .type ==
                                          ValidationStatusType.valid
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        )
                                      : state.confirmPasswordValidationStatus
                                                  .type ==
                                              ValidationStatusType.invalid
                                          ? const Icon(
                                              Icons.cancel_rounded,
                                              color: Colors.red,
                                            )
                                          : const SizedBox.shrink()
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        if (Validations.nameValidation(
                                name: _nameController.text) &&
                            Validations.emailValidation(
                                email: _emailController.text) &&
                            Validations.passwordValidation(
                                password: _passwordController.text) &&
                            Validations.confirmPasswordValidation(
                                password: _passwordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text)) {
                          AuthenticationServices().signUpSuccessfully(
                              context,
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text);
                        } else if (!Validations.nameValidation(
                            name: _nameController.text)) {
                          registerNameFocusNode.requestFocus();
                        } else if (!Validations.emailValidation(
                            email: _emailController.text)) {
                          registerEmailFocusNode.requestFocus();
                        } else if (!Validations.passwordValidation(
                            password: _passwordController.text)) {
                          registerPasswordFocusNode.requestFocus();
                        } else if (!Validations.confirmPasswordValidation(
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text)) {
                          registerConfirmPasswordFocusNode.requestFocus();
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(width: 4),
                      Text(
                        "Log In",
                        style: TextStyle(
                            color: themeColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is RegisterErrorState) {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 700),
                content: Text(state.error),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state is RegisterSuccessfulState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomepageScreen()),
              );
            }
          },
        ),
      ),
    );
  }

  void validate(BuildContext context) {
    context.read<RegisterationBloc>().add(RegisterCredentialsEvent(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text));
  }
}
