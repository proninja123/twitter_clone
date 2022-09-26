import 'dart:convert';
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitterclone/data/model/user_model.dart';

class SharedPreferenceHelper {
  static late SharedPreferences _prefsInstance;
  late SharedPreferences? _prefs;

  static const String _userModel = "userModel";
  static const String _fcmToken = "fcmToken";
  static const String _isUserLogin = "isUserLogin";

  static const JsonDecoder _decoder = JsonDecoder();
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  void clearAll() {
    _prefsInstance.clear();
  }

  static final SharedPreferenceHelper _singleton =
      SharedPreferenceHelper._internal();

  SharedPreferenceHelper._internal() {
    Future.microtask(
        () async => _prefs ??= (await SharedPreferences.getInstance()));
  }

  factory SharedPreferenceHelper() {
    return _singleton;
  }

  ///Helper method to get value for any given key from preferences
  T _getPref<T>(String key) {
    return _prefsInstance.get(key) as T;
  }

  ///Helper method to save data to preferences
  Future<bool> _savePref(String key, Object? value) async {
    var prefs = _prefsInstance;
    if (prefs.containsKey(key)) {
      prefs.remove(key);
    }
    if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is String) {
      return prefs.setString(key, value);
    } else if (value is Double || value is Float) {
      return prefs.setDouble(key, value as double);
    }
    return false;
  }

  String getFcmToken() {
    return _getPref(_fcmToken);
  }

  bool? getLoginValue() {
    return _prefsInstance.getBool(_isUserLogin);
  }

  void saveLoginValue(bool value) {
    _savePref(_isUserLogin, value);
  }

  void saveFcmToken(String? token) {
    _savePref(_fcmToken, token);
  }

  void saveUserModel(UserModel? userModel) {
    if (userModel != null) {
      String value = _encoder.convert(userModel);
      _savePref(_userModel, value);
    } else {
      _savePref(_userModel, null);
    }
  }

  UserModel? getUserModel() {
    String? user = _getPref(_userModel);
    if (user != null) {
      Map<String, dynamic> userMap = _decoder.convert(user);
      return UserModel.fromJson(userMap);
    } else {
      return null;
    }
  }
}
