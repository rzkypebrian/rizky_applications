import 'GoogleUtil.dart';

import 'GooglePosition.dart';
import 'package:json_annotation/json_annotation.dart';
import 'GoogleValueModel.dart';

part 'GoogleStepModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleStepModel {
  @JsonKey(name: "distance")
  GoogleValueModel distance;

  @JsonKey(name: "duration")
  GoogleValueModel duration;

  @JsonKey(name: "end_address")
  String endAddress;

  @JsonKey(name: "end_location")
  GooglePosition endLocation;

  @JsonKey(name: "start_address")
  String startAddress;

  @JsonKey(name: "start_location")
  GooglePosition startLocation;

  @JsonKey(name: "html_instructions")
  String htmlIntruction;

  @JsonKey(name: "polyline")
  dynamic polyLineObject;

  @JsonKey(name: "travel_mode")
  String travelMode;

  @JsonKey(name: "manuver")
  String manuver;

  List<GooglePosition> get polyline {
    return GoogleUtil.convertToLatLng(
        GoogleUtil.decodePoly(this.polyLineObject["points"]));
  }

  static GoogleStepModel fromJson(Map<String, dynamic> json) =>
      _$GoogleStepModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleStepModelToJson(this);
}
