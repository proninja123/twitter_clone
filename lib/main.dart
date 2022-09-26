import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitterclone/bloc/observer.dart';
import 'package:twitterclone/firebase_options.dart';
import 'package:twitterclone/utils/helper/shared_preferences_helper.dart';
import 'package:twitterclone/view/authetication/login_screen.dart';
import 'package:twitterclone/view/home/homepage_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferenceHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: LoggingBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final SharedPreferenceHelper _preferenceHelper = SharedPreferenceHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _preferenceHelper.getLoginValue() ?? false
          ? const HomepageScreen()
          : LoginScreen(),
    );
  }
}
