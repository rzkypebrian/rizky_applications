// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsDeliveryPodModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsDeliveryPodModel _$TmsDeliveryPodModelFromJson(Map<String, dynamic> json) {
  return TmsDeliveryPodModel(
    destinationId: json['destinationId'] as int,
    driverId: json['driverId'] as int,
    memberId: json['memberId'] as int,
    driverName: json['driverName'] as String,
    receiverName: json['receiverName'] as String,
    barcode: json['barcode'] as String,
    receiverPhoto: json['receiverPhoto'] as String,
    ePODSign: json['ePODSign'] as String,
    isShipmentFinish: json['isShipmentFinish'] as bool,
    productPhoto:
        (json['productPhoto'] as List)?.map((e) => e as String)?.toList(),
    productPhotoDetail: (json['productPhotoDetail'] as List)
        ?.map((e) => ImageModel.fromJson(e))
        ?.toList(),
    podLat: (json['podLat'] as num)?.toDouble(),
    podLon: (json['podLon'] as num)?.toDouble(),
    podTime: json['podTime'] == null || json['podTime'] == ""
        ? null
        : DateTime.parse(json['podTime'] as String),
  );
}

Map<String, dynamic> _$TmsDeliveryPodModelToJson(
        TmsDeliveryPodModel instance) =>
    <String, dynamic>{
      'destinationId': instance.destinationId,
      'driverId': instance.driverId,
      'memberId': instance.memberId,
      'driverName': instance.driverName,
      'receiverName': instance.receiverName,
      'barcode': instance.barcode,
      'isShipmentFinish': instance.isShipmentFinish,
      'podLat': instance.podLat,
      'podLon': instance.podLon,
      'podTime': instance.podTime?.toIso8601String(),
      'ePODSign': instance.ePODSign,
      'productPhoto': instance.productPhoto,
      'productPhotoDetail': instance.productPhotoDetail,
      'receiverPhoto': instance.receiverPhoto,
      // 'ePODSign': "", // instance.ePODSign,
      // 'productPhoto': "", //instance.productPhoto,
      // 'receiverPhoto': "", // instance.receiverPhoto,
    };
