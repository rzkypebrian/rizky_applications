// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InsurancePremiModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsurancePremiModel _$InsurancePremiModelFromJson(Map<String, dynamic> json) {
  return InsurancePremiModel(
    premiId: json['premiId'] as int,
    insuranceId: json['insuranceId'] as int,
    premiCode: json['premiCode'] as String,
    premiName: json['premiName'] as String,
    minThreshold: (json['minThreshold'] as num)?.toDouble(),
    maxThreshold: (json['maxThreshold'] as num)?.toDouble(),
    insurancePercentage: (json['insurancePercentage'] as num)?.toDouble(),
    insuranceAmount: (json['insuranceAmount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$InsurancePremiModelToJson(
        InsurancePremiModel instance) =>
    <String, dynamic>{
      'premiId': instance.premiId,
      'insuranceId': instance.insuranceId,
      'premiCode': instance.premiCode,
      'premiName': instance.premiName,
      'minThreshold': instance.minThreshold,
      'maxThreshold': instance.maxThreshold,
      'insurancePercentage': instance.insurancePercentage,
      'insuranceAmount': instance.insuranceAmount,
    };
