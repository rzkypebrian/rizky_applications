// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StockModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockModel _$PoModelFromJson(Map<String, dynamic> json) {
  return StockModel(
    prNumber: json['prNumber'] as String,
    balance: (json['balance'] as num)?.toDouble(),
    typeProcessIo: (json['typeProcessIo'] as num)?.toInt(),
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : ProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    // image: (json['image'] as List)?.map((e) => e as String)?.toList(),
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
  );
}

Map<String, dynamic> _$PoModelToJson(StockModel instance) => <String, dynamic>{
      'typeProcessIo': instance.typeProcessIo,
      'prNumber': instance.prNumber,
      'totalPrice': instance.totalPrice,
      'balance': instance.balance,
      'remainingBalance': instance.remainingBalance,
      'products': instance.products?.map((e) => e?.toJson())?.toList(),
      'image': instance.image,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
