// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AngkutShipmentTypeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripAllowanceModel _$ANgkutShipmentTypeModelFromJson(
    Map<String, dynamic> json) {
  return TripAllowanceModel(
    itemId: json['itemId'] as int,
    itemCode: json['itemCode'] as String,
    itemDescription: json['itemDescription'] as String,
    pricing: (json['pricing'] as num)?.toDouble(),
    qty: json['qty'] as int,
  );
}

Map<String, dynamic> _$ANgkutShipmentTypeModelToJson(
        TripAllowanceModel instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemCode': instance.itemCode,
      'itemDescription': instance.itemDescription,
      'pricing': instance.pricing,
      'qty': instance.qty,
    };
