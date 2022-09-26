
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CommentModel{

  String? commentContent;
  String? userId;
  String? userName;
  String? userProfilePicture;

  CommentModel({this.commentContent, this.userId, this.userName, this.userProfilePicture});

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}