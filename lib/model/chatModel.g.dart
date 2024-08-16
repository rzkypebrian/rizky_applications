// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return ChatModel(
    messageId: json['messageId'] as int,
    userTypeId: json['userTypeId'] as int,
    userTypeName: json['userTypeName'] as String,
    subjectId: json['subjectId'] as int,
    subjectTitle: json['subjectTitle'] as String,
    subjectDesc: json['subjectDesc'] as String,
    tmsShipmentId: json['tmsShipmentId'] as int,
    userId: json['userId'] as int,
    userName: json['userName'] as String,
    messageContent: json['messageContent'] as String,
    readStatus: json['readStatus'] as int,
    readDatetime: json['readDatetime'] == null
        ? null
        : DateTime.parse(json['readDatetime'] as String),
    insertedBy: json['insertedBy'] as String,
    insertedDate: json['insertedDate'] == null
        ? null
        : DateTime.parse((json['insertedDate'] as String).split("+")[0]),
    modifiedBy: json['modifiedBy'] as String,
    modifiedDate: json['modifiedDate'] == null
        ? null
        : DateTime.parse(json['modifiedDate'] as String),
  );
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'userTypeId': instance.userTypeId,
      'userTypeName': instance.userTypeName,
      'subjectId': instance.subjectId,
      'subjectTitle': instance.subjectTitle,
      'subjectDesc': instance.subjectDesc,
      'tmsShipmentId': instance.tmsShipmentId,
      'userId': instance.userId,
      'userName': instance.userName,
      'messageContent': instance.messageContent,
      'readStatus': instance.readStatus,
      'readDatetime': instance.readDatetime?.toIso8601String(),
      'insertedBy': instance.insertedBy,
      'insertedDate': instance.insertedDate?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
    };
