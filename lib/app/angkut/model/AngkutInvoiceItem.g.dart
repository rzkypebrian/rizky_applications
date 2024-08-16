// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AngkutInvoiceItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AngkutInvoiceItem _$AngkutInvoiceItemFromJson(Map<String, dynamic> json) {
  return AngkutInvoiceItem(
    detailId: json['detailId'] as int,
    paymentId: json['paymentId'] as int,
    invoiceId: json['invoiceId'] as int,
    itemId: json['itemId'] as int,
    itemCode: json['itemCode'] as String,
    itemName: json['itemName'] as String,
    qty: json['qty'] as int,
    pricing: json['pricing']?.toDouble(),
    itemDiscountPercentage: (json['itemDiscountPercentage'] as num)?.toDouble(),
    itemAmtDiscount: json['itemAmtDiscount'] as int,
    totalPricing: json['totalPricing']?.toDouble(),
    remarks: json['remarks'] as String,
  );
}

Map<String, dynamic> _$AngkutInvoiceItemToJson(AngkutInvoiceItem instance) =>
    <String, dynamic>{
      'detailId': instance.detailId,
      'paymentId': instance.paymentId,
      'invoiceId': instance.invoiceId,
      'itemId': instance.itemId,
      'itemCode': instance.itemCode,
      'itemName': instance.itemName,
      'qty': instance.qty,
      'pricing': instance.pricing,
      'itemDiscountPercentage': instance.itemDiscountPercentage,
      'itemAmtDiscount': instance.itemAmtDiscount,
      'totalPricing': instance.totalPricing,
      'remarks': instance.remarks,
    };
