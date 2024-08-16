import 'GooglePosition.dart';
import 'package:json_annotation/json_annotation.dart';

import 'GoogleStepModel.dart';
import 'GoogleValueModel.dart';

part 'GoogleLegsModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleLegsModel {
  GoogleValueModel distance;
  GoogleValueModel duration;

  @JsonKey(name: "end_address")
  String endAddress;

  @JsonKey(name: "end_location")
  GooglePosition endLocation;

  @JsonKey(name: "start_address")
  String startAddress;

  @JsonKey(name: "start_location")
  GooglePosition startLocation;

  List<GoogleStepModel> steps;

  static GoogleLegsModel fromJson(Map<String, dynamic> json) =>
      _$GoogleLegsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLegsModelToJson(this);
}
