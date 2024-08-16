// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AngkutCreateOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AngkutCreateOrderModel _$AngkutCreateOrderModelFromJson(
    Map<String, dynamic> json) {
  return AngkutCreateOrderModel(
    customerId: json['customerId'] as int,
    vehicleTypeId: json['vehicleTypeId'] as int,
    scheduledDate: json['scheduledDate'] == null
        ? null
        : DateTime.parse(json['shipmentDate'] as String),
    isInstant: json['isInstant'] as bool,
    extraHelper: json['extraHelper'] as bool,
    extraHelperCount: json['extraHelperCount'] as int,
    deliveryNo: json['deliveryNo'] as String,
    itemDescription: json['itemDescription'] as String,
    shipmentFee: (json['shipmentFee'] as num)?.toDouble(),
    insuranceId: json['insuranceId'] as int,
    premiId: json['premiId'] as int,
    estimateGoodsPrice: (json['estimateGoodsPrice'] as num)?.toDouble(),
    voucherCode: json['voucherCode'] as String,
    detailDestinationList: (json['detailDestinationList'] as List)
        ?.map((e) => e == null ? null : AngkutDestination.fromJson(e))
        ?.toList(),
    shipmentItemTypeList: (json['shipmentItemTypeList'] as List)
        ?.map((e) => e == null ? null : TripAllowanceModel.fromJson(e))
        ?.toList(),
  );
}

Map<String, dynamic> _$AngkutCreateOrderModelToJson(
        AngkutCreateOrderModel instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'vehicleTypeId': instance.vehicleTypeId,
      'scheduledDate': instance.scheduledDate?.toIso8601String(),
      'isInstant': instance.isInstant,
      'extraHelper': instance.extraHelper,
      'extraHelperCount': instance.extraHelperCount,
      'deliveryNo': instance.deliveryNo,
      'itemDescription': instance.itemDescription,
      'shipmentFee': instance.shipmentFee,
      'insuranceId': instance.insuranceId,
      'premiId': instance.premiId,
      'estimateGoodsPrice': instance.estimateGoodsPrice,
      'voucherCode': instance.voucherCode,
      'detailDestinationList':
          instance.detailDestinationList?.map((e) => e?.toJson())?.toList(),
      'shipmentItemTypeList':
          instance.shipmentItemTypeList?.map((e) => e?.toJson())?.toList(),
    };
