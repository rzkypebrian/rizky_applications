// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AngkutShipmentDescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AngkutShipmentDescription _$AngkutShipmentDescriptionFromJson(
    Map<String, dynamic> json) {
  return AngkutShipmentDescription(
    itemId: json['itemId'] as int,
    detailshipmentId: json['detailshipmentId'] as int,
    item: json['item'] as String,
    itemDescription: json['itemDescription'] as String,
    qty: json['qty'] as int,
    remarks: json['remarks'] as String,
  );
}

Map<String, dynamic> _$AngkutShipmentDescriptionToJson(
        AngkutShipmentDescription instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'detailshipmentId': instance.detailshipmentId,
      'item': instance.item,
      'itemDescription': instance.itemDescription,
      'qty': instance.qty,
      'remarks': instance.remarks,
    };
