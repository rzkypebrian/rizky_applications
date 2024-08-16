// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShipmentItemDescriptionViewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentItemDescriptionViewModel _$ShipmentItemDescriptionViewModelFromJson(
    Map<String, dynamic> json) {
  return ShipmentItemDescriptionViewModel(
    tmsShipmentId: json['tmsShipmentId'] as int,
    itemId: json['itemId'] as int,
    detailshipmentId: json['detailshipmentId'] as int,
    podDetailshipmentId: json['podDetailshipmentId'] as int,
    item: json['item'] as String,
    itemDescription: json['itemDescription'] as String,
    qty: json['qty'] as int,
    remarks: json['remarks'] as String,
    uomCode: json['uomCode'] as String,
    uomName: json['uomName'] as String,
    isChecked: json['isChecked'] as bool,
    insertedBy: json['insertedBy'] as String,
    modifiedBy: json['modifiedBy'] as String,
  );
}

Map<String, dynamic> _$ShipmentItemDescriptionViewModelToJson(
        ShipmentItemDescriptionViewModel instance) =>
    <String, dynamic>{
      'tmsShipmentId': instance.tmsShipmentId,
      'itemId': instance.itemId,
      'detailshipmentId': instance.detailshipmentId,
      'podDetailshipmentId': instance.podDetailshipmentId,
      'item': instance.item,
      'itemDescription': instance.itemDescription,
      'qty': instance.qty,
      'remarks': instance.remarks,
      'uomCode': instance.uomCode,
      'uomName': instance.uomName,
      'isChecked': instance.isChecked,
      'insertedBy': instance.insertedBy,
      'modifiedBy': instance.modifiedBy,
    };
