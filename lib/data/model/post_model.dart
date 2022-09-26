import 'package:json_annotation/json_annotation.dart';
import 'package:twitterclone/data/model/comment_model.dart';
import 'package:twitterclone/data/model/retweet_model.dart';
import 'package:twitterclone/data/model/user_model.dart';
part 'post_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PostModel {
  UserModel? author;
  List<CommentModel>? comments;
  List<String>? likes;
  String? postContent;
  int? retweets;
  List<String>? tags;
  @JsonKey(toJson: convertToUnix, fromJson: convertToDateTime)
  DateTime? dateCreated;
  RetweetModel? retweet;


  static int convertToUnix(DateTime? date) => (date?.millisecondsSinceEpoch ?? 0);
  static DateTime convertToDateTime(int? unixDate) => (unixDate != null ? DateTime.fromMillisecondsSinceEpoch(unixDate) : DateTime.now());

  PostModel(
      {this.author,
      this.comments,
      this.likes,
      this.postContent,
      this.retweets,
      this.tags,
      this.dateCreated,
      this.retweet
      });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
