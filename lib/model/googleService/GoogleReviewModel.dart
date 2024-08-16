import 'package:json_annotation/json_annotation.dart';
part 'GoogleReviewModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleReviewModel {
  @JsonKey(name: "author_name")
  String authorName;

  @JsonKey(name: "author_url")
  String authorUrl;

  @JsonKey(name: "language")
  String language;

  @JsonKey(name: "profile_photo_url")
  String profilePhotoUrl;

  @JsonKey(name: "rating")
  int rating;

  @JsonKey(name: "relative_time_description")
  String relativeTimeDescription;

  @JsonKey(name: "text")
  String text;

  @JsonKey(name: "time")
  double time;

  GoogleReviewModel({
    this.authorName,
    this.authorUrl,
    this.language,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
  });

  factory GoogleReviewModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleReviewModelToJson(this);
}
