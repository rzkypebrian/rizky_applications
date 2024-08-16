// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentMethodeDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodeDetailModel _$PaymentMethodeDetailModelFromJson(
    Map<String, dynamic> json) {
  return PaymentMethodeDetailModel()
    ..methoDetailId = json['methoDetailId'] as int
    ..methodId = json['methodId'] as int
    ..iconUrl = json['iconUrl'] as String
    ..methodDetailCode = json['methodDetailCode'] as String
    ..methodDetailName = json['methodDetailName'] as String
    ..apiGuid = json['apiGuid'] as String
    ..transactionFeeType = json['transactionFeeType'] as int
    ..transactionFeeAmount = (json['transactionFeeAmount'] as num)?.toDouble()
    ..transactionFeePersentage =
        (json['transactionFeePersentage'] as num)?.toDouble()
    ..remarks = json['remarks'] as String
    ..ipay88Id = json['ipay88Id'] as int;
}

Map<String, dynamic> _$PaymentMethodeDetailModelToJson(
        PaymentMethodeDetailModel instance) =>
    <String, dynamic>{
      'methoDetailId': instance.methoDetailId,
      'methodId': instance.methodId,
      'iconUrl': instance.iconUrl,
      'methodDetailCode': instance.methodDetailCode,
      'methodDetailName': instance.methodDetailName,
      'apiGuid': instance.apiGuid,
      'transactionFeeType': instance.transactionFeeType,
      'transactionFeeAmount': instance.transactionFeeAmount,
      'transactionFeePersentage': instance.transactionFeePersentage,
      'remarks': instance.remarks,
      'ipay88Id': instance.ipay88Id,
    };
