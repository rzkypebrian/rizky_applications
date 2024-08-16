// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AttendanceItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceItemModel _$AttendanceItemModelFromJson(Map<String, dynamic> json) {
  return AttendanceItemModel(
    guid: json['guid'] as String,
    typeCode: json['typeCode'] as String,
    typeName: json['typeName'] as String,
    kindOfType: json['kindOfType'] as String,
    value: json['value'] as String,
    checkerValue: json['checkerValue'] as String,
    checkerReason: json['checkerReason'] as String,
  );
}

Map<String, dynamic> _$AttendanceItemModelToJson(
        AttendanceItemModel instance) =>
    <String, dynamic>{
      'guid': instance.guid,
      'typeCode': instance.typeCode,
      'typeName': instance.typeName,
      'kindOfType': instance.kindOfType,
      'value': instance.value,
      'checkerValue': instance.checkerValue,
      'checkerReason': instance.checkerReason,
    };
