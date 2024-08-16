// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TmsVoucherModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsVoucherModel _$TmsVoucherModelFromJson(Map<String, dynamic> json) {
  return TmsVoucherModel(
    discountId: json['discountId'] as int,
    discountCode: json['discountCode'] as String,
    discountPercentage: (json['discountPercentage'] as num)?.toDouble(),
    discountAmount: (json['discountAmount'] as num)?.toDouble(),
    minAmountToGetDiscount: (json['minAmountToGetDiscount'] as num)?.toDouble(),
    maxAmountToGetDiscount: (json['maxAmountToGetDiscount'] as num)?.toDouble(),
    maxDiscountAmount: (json['maxDiscountAmount'] as num)?.toDouble(),
    isUsingAmount: json['isUsingAmount'] as bool,
    isActive: json['isActive'] as bool,
    starDate: json['starDate'] == null
        ? null
        : DateTime.parse(json['starDate'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
    summaryTermCondition: json['summaryTermCondition'] as String,
    detailTermCondition: json['detailTermCondition'] as String,
    shortSescription: json['shortSescription'] as String,
    isPublic: json['isPublic'] as bool,
    maxClaimed: json['maxClaimed'] as int,
    minShipmentToGetDiscount: json['minShipmentToGetDiscount'] as int,
    paymentMethodDetailId: json['paymentMethodDetailId'] as int,
    minDistanceToGetDiscount: json['minDistanceToGetDiscount'] as int,
    maxDistanceToGetDiscount: json['maxDistanceToGetDiscount'] as int,
    urlImageIdId: json['urlImageIdId'] as String,
    urlImageEnUs: json['urlImageEnUs'] as String,
  );
}

Map<String, dynamic> _$TmsVoucherModelToJson(TmsVoucherModel instance) =>
    <String, dynamic>{
      'discountId': instance.discountId,
      'discountCode': instance.discountCode,
      'discountPercentage': instance.discountPercentage,
      'discountAmount': instance.discountAmount,
      'minAmountToGetDiscount': instance.minAmountToGetDiscount,
      'maxAmountToGetDiscount': instance.maxAmountToGetDiscount,
      'maxDiscountAmount': instance.maxDiscountAmount,
      'isUsingAmount': instance.isUsingAmount,
      'isActive': instance.isActive,
      'starDate': instance.starDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'summaryTermCondition': instance.summaryTermCondition,
      'detailTermCondition': instance.detailTermCondition,
      'shortSescription': instance.shortSescription,
      'isPublic': instance.isPublic,
      'maxClaimed': instance.maxClaimed,
      'minShipmentToGetDiscount': instance.minShipmentToGetDiscount,
      'paymentMethodDetailId': instance.paymentMethodDetailId,
      'minDistanceToGetDiscount': instance.minDistanceToGetDiscount,
      'maxDistanceToGetDiscount': instance.maxDistanceToGetDiscount,
      'urlImageIdId': instance.urlImageIdId,
      'urlImageEnUs': instance.urlImageEnUs,
    };
