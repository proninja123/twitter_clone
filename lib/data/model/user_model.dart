
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UserModel{

  int? followers;
  int? following;
  String? name;
  String? profilePicture;
  String? userId;
  String? email;


  UserModel({this.followers, this.following, this.name,
    this.profilePicture, this.userId, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}