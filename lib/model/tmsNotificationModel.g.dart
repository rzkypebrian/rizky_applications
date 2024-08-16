// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsNotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsNotificationModel _$TmsNotificationModelFromJson(Map<String, dynamic> json) {
  return TmsNotificationModel(
    notificationId: json['notificationId'] as int,
    memberId: json['memberId'] as int,
    notificationType: json['notificationType'] as String,
    titleEN: json['titleEN'] as String,
    titleID: json['titleID'] as String,
    messageEN: json['messageEN'] as String,
    messageID: json['messageID'] as String,
    messageType: json['messageType'] as String,
    sentTo: json['sentTo'] as String,
    messageSource: json['messageSource'] as String,
    messageDate: json['messageDate'] == null
        ? null
        : DateTime.parse(json['messageDate'] as String),
    isRead: json['isRead'] as bool,
    imageUrl: json['imageUrl'] as String,
    settings: json['settings'] as String,
    type: json['type'] as String,
    data: json['data'] as String,
    dataUrl: json['dataUrl'] as String,
    shipmentId: json['shipmentId'] as int,
    appId: json['appId'] as String,
    playerId: json['playerId'] as String,
    senderSourceId: json['senderSourceId'] as String,
    receiverSourceId: json['receiverSourceId'] as String,
    authKey: json['authKey'] as String,
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

Map<String, dynamic> _$TmsNotificationModelToJson(
        TmsNotificationModel instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'memberId': instance.memberId,
      'notificationType': instance.notificationType,
      'titleEN': instance.titleEN,
      'titleID': instance.titleID,
      'messageEN': instance.messageEN,
      'messageID': instance.messageID,
      'messageType': instance.messageType,
      'sentTo': instance.sentTo,
      'messageSource': instance.messageSource,
      'messageDate': instance.messageDate?.toIso8601String(),
      'isRead': instance.isRead,
      'imageUrl': instance.imageUrl,
      'settings': instance.settings,
      'type': instance.type,
      'data': instance.data,
      'dataUrl': instance.dataUrl,
      'shipmentId': instance.shipmentId,
      'appId': instance.appId,
      'playerId': instance.playerId,
      'senderSourceId': instance.senderSourceId,
      'receiverSourceId': instance.receiverSourceId,
      'authKey': instance.authKey,
      'insertedBy': instance.insertedBy,
      'insertedDate': instance.insertedDate?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
    };
