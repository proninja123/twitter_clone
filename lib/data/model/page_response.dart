import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

@JsonSerializable(
    genericArgumentFactories: true, includeIfNull: false, explicitToJson: true)
class PageResponse<TModel> {

  List<TModel>? body;

  PageResponse({this.body});

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    TModel Function(Object? json) fromJsonT,
  ) =>
      _$PageResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(TModel value) toJsonT) =>
      _$PageResponseToJson(this, toJsonT);
}
