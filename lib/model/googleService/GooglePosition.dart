import 'package:json_annotation/json_annotation.dart';
part 'GooglePosition.g.dart';

@JsonSerializable(explicitToJson: true)
class GooglePosition {
  @JsonKey(name: "lat")
  double lat;
  @JsonKey(name: "lng")
  double lon;

  GooglePosition({
    this.lat,
    this.lon,
  });

  static GooglePosition fromJson(Map<String, dynamic> json) =>
      _$GooglePositionFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePositionToJson(this);
}
