import 'package:json_annotation/json_annotation.dart';

import 'GoogleOpertingHourPeriodeModel.dart';
part 'GoogleOpeningHourModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleOpeningHourModel {
  @JsonKey(name: "open_now")
  bool openNow;

  @JsonKey(name: "periods")
  List<GoogleOpertingHourPeriodeModel> periods;

  @JsonKey(name: "weekday_text")
  List<String> weekdayText;

  GoogleOpeningHourModel({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  factory GoogleOpeningHourModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleOpeningHourModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleOpeningHourModelToJson(this);
}
