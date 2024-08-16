// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel()
    ..id = json['id'] as int
    ..userId = json['userId'] as String
    ..title = json['title'] as String
    ..body = json['body'] as String
    ..smallIcon = json['smallIcon'] as String
    ..dataType = json['dataType'] as String
    ..setting = json['setting'] as Map<String, dynamic>
    ..data = json['data'] as Map<String, dynamic>;
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
      'smallIcon': instance.smallIcon,
      'dataType': instance.dataType,
      'setting': instance.setting,
      'data': instance.data,
    };
