// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      commentContent: json['commentContent'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userProfilePicture: json['userProfilePicture'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commentContent', instance.commentContent);
  writeNotNull('userId', instance.userId);
  writeNotNull('userName', instance.userName);
  writeNotNull('userProfilePicture', instance.userProfilePicture);
  return val;
}
