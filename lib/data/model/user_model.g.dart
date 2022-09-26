// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      followers: json['followers'] as int?,
      following: json['following'] as int?,
      name: json['name'] as String?,
      profilePicture: json['profilePicture'] as String?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('followers', instance.followers);
  writeNotNull('following', instance.following);
  writeNotNull('name', instance.name);
  writeNotNull('profilePicture', instance.profilePicture);
  writeNotNull('userId', instance.userId);
  writeNotNull('email', instance.email);
  return val;
}
