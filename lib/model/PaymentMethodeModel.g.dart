// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentMethodeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodeModel _$PaymentMethodeModelFromJson(Map<String, dynamic> json) {
  print("payment id ${json['methodId']} ${json['paymentMethodDetails']}");
  return PaymentMethodeModel()
    ..methodId = json['methodId'] as int
    ..iconUrl = json['iconUrl'] as String
    ..methodCode = json['methodCode'] as String
    ..methodName = json['methodName'] as String
    ..apiGuid = json['apiGuid'] as String
    ..transactionFeeType = json['transactionFeeType'] as int
    ..transactionFeeAmount = (json['transactionFeeAmount'] as num)?.toDouble()
    ..transactionFeePersentage =
        (json['transactionFeePersentage'] as num)?.toDouble()
    ..remarks = json['remarks'] as String
    ..paymentMethodDetails = (json['paymentMethodDetails'] as List)
        ?.map((e) => e == null
            ? null
            : PaymentMethodeDetailModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PaymentMethodeModelToJson(
        PaymentMethodeModel instance) =>
    <String, dynamic>{
      'methodId': instance.methodId,
      'iconUrl': instance.iconUrl,
      'methodCode': instance.methodCode,
      'methodName': instance.methodName,
      'apiGuid': instance.apiGuid,
      'transactionFeeType': instance.transactionFeeType,
      'transactionFeeAmount': instance.transactionFeeAmount,
      'transactionFeePersentage': instance.transactionFeePersentage,
      'remarks': instance.remarks,
      'paymentMethodDetails':
          instance.paymentMethodDetails?.map((e) => e?.toJson())?.toList(),
    };
