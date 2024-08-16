// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsShipmentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsShipmentModel<T> _$TmsShipmentModelFromJson<T>(Map<String, dynamic> json) {
  return TmsShipmentModel<T>(
    tmsShipmentId: json['tmsShipmentId'] as int,
    shipmentNumber: json['shipmentNumber'] as String,
    shipmentDate: json['shipmentDate'] == null
        ? null
        : DateTime.parse(json['shipmentDate'] as String),
    vtsShipmentId: json['vtsShipmentId'] as int,
    shipmentType: json['shipmentType'] as String,
    shipmentTypeName: json['shipmentTypeName'] as String,
    customerNo: json['customerNo'] as String,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    beginDatetime: json['beginDatetime'] == null
        ? null
        : DateTime.parse(json['beginDatetime'] as String),
    completeDatetime: json['completeDatetime'] == null
        ? null
        : DateTime.parse(json['completeDatetime'] as String),
    shipmentStatus: json['shipmentStatus'] as String,
    shipmentStatusName: json['shipmentStatusName'] as String,
    deliveryDescription: json['deliveryDescription'] as String,
    isDeleted: json['isDeleted'] as bool,
    memberId: json['memberId'] as int,
    customerImageUrl: json['customerImageUrl'] as String,
    iconUrl: json['icon_url'] as String,
    tmsShipmentDestinationList: (json['tmsShipmentDestinationList'] as List)
        ?.map((e) => e == null
            ? null
            : TmsShipmentDestinationModel.fromJson<T>(
                e as Map<String, dynamic>))
        ?.toList(),
    tmsShipmentHistoryList: (json['tmsShipmentHistoryList'] as List)
        ?.map((e) => e == null
            ? null
            : TmsShipmentHistory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    scheduledDate: json['beginDatetime'] == null
        ? null
        : DateTime.parse(json['beginDatetime'] as String),
    isInstant: json["isInstant"] as bool,
    extraHelper: json["extraHelper"] as bool,
    deliveryNo: json["deliveryNo"] as String,
    driverRating: json["driverRating"] == null
        ? null
        : DriverRatingModel.fromJson(json["driverRating"]),
  );
}

Map<String, dynamic> _$TmsShipmentModelToJson<T>(
        TmsShipmentModel<T> instance) =>
    <String, dynamic>{
      'tmsShipmentId': instance.tmsShipmentId,
      'shipmentNumber': instance.shipmentNumber,
      'shipmentDate': instance.shipmentDate?.toIso8601String(),
      'vtsShipmentId': instance.vtsShipmentId,
      'shipmentType': instance.shipmentType,
      'shipmentTypeName': instance.shipmentTypeName,
      'customerNo': instance.customerNo,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'beginDatetime': instance.beginDatetime?.toIso8601String(),
      'completeDatetime': instance.completeDatetime?.toIso8601String(),
      'shipmentStatus': instance.shipmentStatus,
      'shipmentStatusName': instance.shipmentStatusName,
      'deliveryDescription': instance.deliveryDescription,
      'isDeleted': instance.isDeleted,
      'memberId': instance.memberId,
      'customerImageUrl': instance.customerImageUrl,
      'icon_url': instance.iconUrl,
      'tmsShipmentDestinationList': instance.tmsShipmentDestinationList
          ?.map((e) => e?.toJson())
          ?.toList(),
      'tmsShipmentHistoryList':
          instance.tmsShipmentHistoryList?.map((e) => e?.toJson())?.toList(),
      "scheduledDate": instance.scheduledDate?.toIso8601String(),
      "isInstant": instance.isInstant,
      "extraHelper": instance.extraHelper,
      "deliveryNo": instance.deliveryNo,
      'driverRating': instance.driverRating?.toJson(),
    };
