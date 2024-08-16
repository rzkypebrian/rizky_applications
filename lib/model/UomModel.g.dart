// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UomModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UomModel _$UomModelFromJson(Map<String, dynamic> json) {
  return UomModel(
    uomCode: json['uomCode'] as String,
    uomName: json['uomName'] as String,
  );
}

Map<String, dynamic> _$UomModelToJson(UomModel instance) => <String, dynamic>{
      'uomCode': instance.uomCode,
      'uomName': instance.uomName,
    };
