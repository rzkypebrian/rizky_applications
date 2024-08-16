import 'package:json_annotation/json_annotation.dart';
part 'GoogleOpertingHourPeriodeModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleOpertingHourPeriodeModel {
  @JsonKey(name: "day")
  int day;

  @JsonKey(name: "time")
  int time;

  GoogleOpertingHourPeriodeModel({
    this.day,
    this.time,
  });

  factory GoogleOpertingHourPeriodeModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleOpertingHourPeriodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleOpertingHourPeriodeModelToJson(this);
}
