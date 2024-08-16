import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsNotificationModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsNotificationModel {
  int notificationId;
  int memberId;
  String notificationType;
  String titleEN;
  String titleID;
  String messageEN;
  String messageID;
  String messageType;
  String sentTo;
  String messageSource;
  DateTime messageDate;
  bool isRead;
  String imageUrl;
  String settings;
  String type;
  String data;
  String dataUrl;
  int shipmentId;
  String appId;
  String playerId;
  String senderSourceId;
  String receiverSourceId;
  String authKey;
  String insertedBy;
  DateTime insertedDate;
  String modifiedBy;
  DateTime modifiedDate;

  TmsNotificationModel({
    this.notificationId,
    this.memberId,
    this.notificationType,
    this.titleEN,
    this.titleID,
    this.messageEN,
    this.messageID,
    this.messageType,
    this.sentTo,
    this.messageSource,
    this.messageDate,
    this.isRead,
    this.imageUrl,
    this.settings,
    this.type,
    this.data,
    this.dataUrl,
    this.shipmentId,
    this.appId,
    this.playerId,
    this.senderSourceId,
    this.receiverSourceId,
    this.authKey,
    this.insertedBy,
    this.insertedDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  factory TmsNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$TmsNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$TmsNotificationModelToJson(this);

  String get titie {
    switch (System.data.resource.lang) {
      case "id-ID":
        return this.titleID;
        break;

      case "EN-us":
        return this.titleEN;
        break;

      default:
        return this.titleID;
        break;
    }
  }

  String get message {
    switch (System.data.resource.lang) {
      case "id-ID":
        return this.messageID;
        break;

      case "en-US":
        return this.messageEN;
        break;

      default:
        return this.messageID;
        break;
    }
  }

  static Future<List<TmsNotificationModel>> get({
    String token,
    int notificationId,
    int datalimit,
    bool isLowerThanId,
  }) {
    return NetworkUtil().get(
        System.data.apiEndPointUtil.getAllNotification(
          dataLimit: datalimit,
          lowerThan: isLowerThanId,
          notificationId: notificationId,
        ),
        headers: {
          HttpHeaders.authorizationHeader: "bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
          "lang": "${System.data.resource.lang}",
        }).then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => TmsNotificationModel.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
