import 'GooglePosition.dart';
import 'package:json_annotation/json_annotation.dart';
part 'GoogleBoundsModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleBoundsModel {
  @JsonKey(name: "northeast")
  GooglePosition northeast;

  @JsonKey(name: "southwest")
  GooglePosition southwest;

  static GoogleBoundsModel fromJson(Map<String, dynamic> json) =>
      _$GoogleBoundsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBoundsModelToJson(this);


}
