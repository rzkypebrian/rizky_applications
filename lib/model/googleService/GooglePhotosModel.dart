import 'package:json_annotation/json_annotation.dart';
part 'GooglePhotosModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GooglePhotosModel {
  @JsonKey(name: "height")
  int height;

  @JsonKey(name: "html_attributions")
  List<String> htmlAttributions;

  @JsonKey(name: "photo_reference")
  String photoReference;

  @JsonKey(name: "width")
  int width;

  GooglePhotosModel({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  factory GooglePhotosModel.fromJson(Map<String, dynamic> json) =>
      _$GooglePhotosModelFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePhotosModelToJson(this);
}
