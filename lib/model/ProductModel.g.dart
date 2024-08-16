// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    idMaintenance: json['idMaintenance'] as String,
    sallerName: json['sallerName'] as String,
    image: json['image'] as String,
    buyingPrice: (json['buyingPrice'] as num)?.toDouble(),
    sellingPrice: (json['sellingPrice'] as num)?.toDouble(),
    totalProduct: (json['totalProduct'] as num)?.toDouble(),
    productId: json['productId'] as int,
    productGuid: json['productGuid'] as String,
    productCode: json['productCode'] as String,
    productName: json['productName'] as String,
    shortDecsription: json['shortDecsription'] as String,
    longDescription: json['longDescription'] as String,
    productUom: json['productUom'] as String,
    status: json['status'] as int,
    isDeleted: json['isDeleted'] as bool,
    insertedBy: json['insertedBy'] as String,
    insertedDate: json['insertedDate'] == null
        ? null
        : DateTime.parse(json['insertedDate'] as String),
    modifiedBy: json['modifiedBy'] as String,
    modifiedDate: json['modifiedDate'] == null
        ? null
        : DateTime.parse(json['modifiedDate'] as String),
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productGuid': instance.productGuid,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'shortDecsription': instance.shortDecsription,
      'longDescription': instance.longDescription,
      'productUom': instance.productUom,
      'status': instance.status,
      'isDeleted': instance.isDeleted,
      'insertedBy': instance.insertedBy,
      'insertedDate': instance.insertedDate?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
      'buyingPrice': instance.buyingPrice,
      'sellingPrice': instance.sellingPrice,
      'totalProduct': instance.totalProduct,
      'image': instance.image,
      'sallerName': instance.sallerName,
      'idMaintenance': instance.idMaintenance,
    };
