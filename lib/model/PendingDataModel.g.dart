// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PendingDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingDataModel _$PandingDataModelFromJson(Map<String, dynamic> json) {
  return PendingDataModel()
    ..id = json['id'] as int
    ..key = json['key'] as String
    ..dataType = json['data_type'] as String
    ..rawData = json['raw_data'] as String
    ..status = json['status'] as String;
}

Map<String, dynamic> _$PandingDataModelToJson(PendingDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'data_type': instance.dataType,
      'raw_data': instance.rawData,
      'status': instance.status,
    };
