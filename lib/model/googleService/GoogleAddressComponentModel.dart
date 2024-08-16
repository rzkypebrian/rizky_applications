import 'package:json_annotation/json_annotation.dart';
part 'GoogleAddressComponentModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleAddressComponentModel {
  @JsonKey(name: "long_name")
  String longName;

  @JsonKey(name: "short_name")
  String shortName;

  GoogleAddressComponentModel({
    this.longName,
    this.shortName,
  });

  factory GoogleAddressComponentModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleAddressComponentModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleAddressComponentModelToJson(this);
}
