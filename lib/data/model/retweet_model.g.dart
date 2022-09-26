// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retweet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetweetModel _$RetweetModelFromJson(Map<String, dynamic> json) => RetweetModel(
      isRetweeted: json['isRetweeted'] as bool?,
      retweetedId: json['retweetedId'] as String?,
    );

Map<String, dynamic> _$RetweetModelToJson(RetweetModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isRetweeted', instance.isRetweeted);
  writeNotNull('retweetedId', instance.retweetedId);
  return val;
}
