import 'package:json_annotation/json_annotation.dart';
import 'GoogleBoundsModel.dart';
import 'GooglePosition.dart';
part 'GoogleGeometryModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleGeometryModel {
  @JsonKey(name: "location")
  GooglePosition location;

  @JsonKey(name: "viewport")
  GoogleBoundsModel viewport;

  @JsonKey(name: "icon")
  String icon;

  @JsonKey(name: "international_phone_number")
  String internationalhoneNumber;

  @JsonKey(name: "name")
  String name;

  GoogleGeometryModel();

  factory GoogleGeometryModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleGeometryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleGeometryModelToJson(this);
}
