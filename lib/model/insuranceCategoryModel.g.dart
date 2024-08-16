// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insuranceCategoryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuraceCategoryModel _$DriverRatingModelFromJson(Map<String, dynamic> json) {
  return InsuraceCategoryModel(
    insuranceTypeId: json['insuranceTypeId'] as int,
    insuranceTypeName: json['insuranceTypeName'] as String,
    insuranceId: json['insuranceId'] as int,
    insuranceName: json['insuranceName'] as String,
    isActive: json['isActive'] as bool,
  );
}

Map<String, dynamic> _$DriverRatingModelToJson(
        InsuraceCategoryModel instance) =>
    <String, dynamic>{
      'insuranceTypeId': instance.insuranceTypeId,
      'insuranceTypeName': instance.insuranceTypeName,
      'insuranceId': instance.insuranceId,
      'insuranceName': instance.insuranceName,
      'isActive': instance.isActive,
    };
