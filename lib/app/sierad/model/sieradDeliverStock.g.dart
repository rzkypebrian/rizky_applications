// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sieradDeliverStock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SieradDeliverStock _$SieradDeliverStockFromJson(Map<String, dynamic> json) {
  return SieradDeliverStock(
    poultryShipmentId: json['poultryShipmentId'] as int,
    driverId: json['driverId'] as int,
    driverName: json['driverName'] as String,
    qtyReceived: json['qtyReceived'] as int,
    qtyBonusReceived: json['qtyBonusReceived'] as int,
    qtyBrokenReceived: json['qtyBrokenReceived'] as int,
    qtyBasketReceived: json['qtyBasketReceived'] as int,
    qtyLiveBirdReceived: json['qtyLiveBirdReceived'] as int,
    qtyLiveBirdDead: json['qtyLiveBirdDead'] as int,
  );
}

Map<String, dynamic> _$SieradDeliverStockToJson(SieradDeliverStock instance) =>
    <String, dynamic>{
      'poultryShipmentId': instance.poultryShipmentId ?? 0,
      'driverId': instance.driverId ?? 0,
      'driverName': instance.driverName,
      'qtyReceived': instance.qtyReceived ?? 0,
      'qtyBonusReceived': instance.qtyBonusReceived ?? 0,
      'qtyBrokenReceived': instance.qtyBrokenReceived ?? 0,
      'qtyBasketReceived': instance.qtyBasketReceived ?? 0,
      'qtyLiveBirdReceived': instance.qtyLiveBirdReceived ?? 0,
      'qtyLiveBirdDead': instance.qtyLiveBirdDead ?? 0,
    };
