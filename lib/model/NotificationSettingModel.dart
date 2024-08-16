import 'package:json_annotation/json_annotation.dart';
part 'NotificationSettingModel.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationSettingModel {
  int titleColor;
  int bodyColor;

  NotificationSettingModel({
    this.titleColor,
    this.bodyColor,
  });

  factory NotificationSettingModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSettingModelToJson(this);
}
