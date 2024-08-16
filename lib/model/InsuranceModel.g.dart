// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InsuranceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceModel _$InsuranceModelFromJson(Map<String, dynamic> json) {
  return InsuranceModel(
    insuranceId: json['insuranceId'] as int,
    insuranceCode: json['insuranceCode'] as String,
    insuranceName: json['insuranceName'] as String,
    insuranceDescription: json['insuranceDescription'] as String,
    insurancePremiList: (json['insurancePremiList'] as List)
        ?.map((e) => e == null
            ? null
            : InsurancePremiModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InsuranceModelToJson(InsuranceModel instance) =>
    <String, dynamic>{
      'insuranceId': instance.insuranceId,
      'insuranceCode': instance.insuranceCode,
      'insuranceName': instance.insuranceName,
      'insuranceDescription': instance.insuranceDescription,
      'insurancePremiList':
          instance.insurancePremiList?.map((e) => e?.toJson())?.toList(),
    };
