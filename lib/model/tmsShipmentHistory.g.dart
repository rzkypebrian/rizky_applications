// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsShipmentHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsShipmentHistory _$TmsShipmentHistoryFromJson(Map<String, dynamic> json) {
  return TmsShipmentHistory(
    trackingId: json['trackingId'] as int,
    trackingGuid: json['trackingGuid'] as String,
    memberId: json['memberId'] as int,
    detailShipmentId: json['detailShipmentId'] as int,
    trackingDate: json['trackingDate'] == null
        ? null
        : DateTime.parse(json['trackingDate'] as String),
    trackingEta: json['trackingEta'] == null
        ? null
        : DateTime.parse(json['trackingEta'] as String),
    shipmentStatus: json['shipmentStatus'] as String,
    messageEn: json['messageEn'] as String,
    messageId: json['messageId'] as String,
    remarks: json['remarks'] as String,
  );
}

Map<String, dynamic> _$TmsShipmentHistoryToJson(TmsShipmentHistory instance) =>
    <String, dynamic>{
      'trackingId': instance.trackingId,
      'trackingGuid': instance.trackingGuid,
      'memberId': instance.memberId,
      'detailShipmentId': instance.detailShipmentId,
      'trackingDate': instance.trackingDate?.toIso8601String(),
      'trackingEta': instance.trackingEta?.toIso8601String(),
      'shipmentStatus': instance.shipmentStatus,
      'messageEn': instance.messageEn,
      'messageId': instance.messageId,
      'remarks': instance.remarks,
    };
