import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitterclone/bloc/login/login_bloc.dart';
import 'package:twitterclone/bloc/login/login_event.dart';
import 'package:twitterclone/bloc/register/register_bloc.dart';
import 'package:twitterclone/bloc/register/register_event.dart';
import 'package:twitterclone/data/model/user_model.dart';
import 'package:twitterclone/utils/helper/shared_preferences_helper.dart';

class AuthenticationServices {
  Future<void> signInWithUserAndEmail(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          UserModel userModel = UserModel(
            email: value.user?.email,
            userId: value.user?.uid,
            profilePicture: value.user?.photoURL,
          );

          final sharedPrefHelper = SharedPreferenceHelper();

          sharedPrefHelper.saveUserModel(userModel);
          sharedPrefHelper.saveLoginValue(true);

          context.read<LoginPageBloc>().add(LoginSuccessfulEvent());
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        context.read<LoginPageBloc>().add(LoginPageErrorEvent(e.code));
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        context.read<LoginPageBloc>().add(LoginPageErrorEvent(e.code));
        debugPrint('Wrong password provided for that user.');
      } else {
        context.read<LoginPageBloc>().add(LoginPageErrorEvent(e.code));
      }
    }
  }

  Future<void> signUpSuccessfully(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        UserModel userModel = UserModel(
          email: value.user?.email,
          name: name,
          userId: value.user?.uid,
          profilePicture: value.user?.photoURL,
        );

        final sharedPrefHelper = SharedPreferenceHelper();
        sharedPrefHelper.saveUserModel(userModel);
        sharedPrefHelper.saveLoginValue(true);

        final db = FirebaseFirestore.instance;

        final model = UserModel(
          userId: value.user?.uid,
          name: name,
          profilePicture: "https://picsum.photos/200",
          following: 0,
          followers: 0,
        );

        db.collection("users").doc(model.userId).set(model.toJson()).then(
          (value) {
            context.read<RegisterationBloc>().add(RegisterSuccessfulEvent());
          },
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        context.read<RegisterationBloc>().add(RegisterErrorEvent(e.code));
      } else if (e.code == 'email-already-in-use') {
        context.read<RegisterationBloc>().add(RegisterErrorEvent(e.code));
      } else {
        context.read<RegisterationBloc>().add(RegisterErrorEvent(e.code));
      }
    }
  }
}
