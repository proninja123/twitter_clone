// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      author: json['author'] == null
          ? null
          : UserModel.fromJson(json['author'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      postContent: json['postContent'] as String?,
      retweets: json['retweets'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      dateCreated: PostModel.convertToDateTime(json['dateCreated'] as int?),
      retweet: json['retweet'] == null
          ? null
          : RetweetModel.fromJson(json['retweet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('author', instance.author?.toJson());
  writeNotNull('comments', instance.comments?.map((e) => e.toJson()).toList());
  writeNotNull('likes', instance.likes);
  writeNotNull('postContent', instance.postContent);
  writeNotNull('retweets', instance.retweets);
  writeNotNull('tags', instance.tags);
  writeNotNull('dateCreated', PostModel.convertToUnix(instance.dateCreated));
  writeNotNull('retweet', instance.retweet?.toJson());
  return val;
}
