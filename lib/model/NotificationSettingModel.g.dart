// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationSettingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSettingModel _$NotificationSettingModelFromJson(
    Map<String, dynamic> json) {
  return NotificationSettingModel()
    ..titleColor = json['titleColor'] as int
    ..bodyColor = json['bodyColor'] as int;
}

Map<String, dynamic> _$NotificationSettingModelToJson(
        NotificationSettingModel instance) =>
    <String, dynamic>{
      'titleColor': instance.titleColor,
      'bodyColor': instance.bodyColor,
    };
