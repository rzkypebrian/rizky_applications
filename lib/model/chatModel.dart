import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chatModel.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatModel {
  int messageId;
  int userTypeId;
  String userTypeName;
  int subjectId;
  String subjectTitle;
  String subjectDesc;
  int tmsShipmentId;
  int userId;
  String userName;
  String messageContent;
  int readStatus;
  DateTime readDatetime;
  String insertedBy;
  DateTime insertedDate;
  String modifiedBy;
  DateTime modifiedDate;

  ChatModel({
    this.messageId = 0,
    this.userTypeId = 0,
    this.userTypeName,
    this.subjectId = 0,
    this.subjectTitle,
    this.subjectDesc,
    this.tmsShipmentId = 0,
    this.userId = 0,
    this.userName,
    this.messageContent,
    this.readStatus = 0,
    this.readDatetime,
    this.insertedBy,
    this.insertedDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  static Future<List<ChatModel>> get({
    String token,
    int tmsShipmentId,
  }) {
    return NetworkUtil().post(
        System.data.apiEndPointUtil.getChatList(
          tmsShipmentId: tmsShipmentId,
        ),
        headers: {
          "lang": "${System.data.resource.lang}",
          HttpHeaders.authorizationHeader: "bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((value) {
      print("result from get");
      print("${(json.decode(value) as List).last}");
      return (json.decode(value) as List)
          .map((e) => ChatModel.fromJson(e))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<ChatModel> send({
    String token,
    ChatModel chatModel,
  }) {
    return NetworkUtil().post(System.data.apiEndPointUtil.sendChat(),
        body: chatModel.toJson(),
        headers: {
          "lang": "${System.data.resource.lang}",
          HttpHeaders.authorizationHeader: "bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((value) {
      print("result from send");
      print("$value");
      return ChatModel.fromJson(json.decode(value));
    }).catchError((onError) {
      throw onError;
    });
  }
}
