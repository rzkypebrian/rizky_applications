// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestTrackerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestTrackerModel _$RequestTrackerModelFromJson(Map<String, dynamic> json) {
  return RequestTrackerModel(
    processId: json['processId'] as int,
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
    functionType: json['functionType'] as String,
    urlRequest: json['urlRequest'] as String,
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$RequestTrackerModelToJson(
        RequestTrackerModel instance) =>
    <String, dynamic>{
      'processId': instance.processId,
      'dateTime': instance.dateTime?.toIso8601String(),
      'functionType': instance.functionType,
      'urlRequest': instance.urlRequest,
      'data': instance.data,
    };
