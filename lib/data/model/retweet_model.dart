
import 'package:json_annotation/json_annotation.dart';

part 'retweet_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class RetweetModel{

  bool? isRetweeted;
  String? retweetedId;


  RetweetModel({this.isRetweeted,this.retweetedId});

  factory RetweetModel.fromJson(Map<String, dynamic> json) => _$RetweetModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetweetModelToJson(this);
}