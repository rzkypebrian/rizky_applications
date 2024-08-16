// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransporterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransporterModel _$TransporterModelFromJson(Map<String, dynamic> json) {
  return TransporterModel(
    transporterId: json['transporterId'] as int,
    transporterCode: json['transporterCode'] as String,
    memberId: json['memberId'] as int,
    transporterName: json['transporterName'] as String,
    transporterGeofenceId: json['transporterGeofenceId'] as int,
    transporterContact: json['transporterContact'] as String,
    transporterMobile: json['transporterMobile'] as String,
    transporterIdVts: json['transporterIdVts'] as int,
    transporterTokenVts: json['transporterTokenVts'] as String,
    status: json['status'] as int,
    transporterType: json['transporterType'] as String,
    transporterEmail: json['transporterEmail'] as String,
    password: json['password'] as String,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    imageUrl: json['imageUrl'] as String,
    address: json['address'] as String,
    token: json['token'] as String,
    tokenExpiredTime: json['tokenExpiredTime'] == null
        ? null
        : DateTime.parse(json['tokenExpiredTime'] as String),
    registeredDate: json['registeredDate'] == null
        ? null
        : DateTime.parse(json['registeredDate'] as String),
    imei: json['imei'] as String,
    os: json['os'] as String,
    adminPhoneNumber: json['adminPhoneNumber'] as String,
    adminWhatsAppNumber: json['adminWhatsAppNumber'] as String,
  );
}

Map<String, dynamic> _$TransporterModelToJson(TransporterModel instance) =>
    <String, dynamic>{
      'transporterId': instance.transporterId,
      'transporterCode': instance.transporterCode,
      'memberId': instance.memberId,
      'transporterName': instance.transporterName,
      'transporterGeofenceId': instance.transporterGeofenceId,
      'transporterContact': instance.transporterContact,
      'transporterMobile': instance.transporterMobile,
      'transporterIdVts': instance.transporterIdVts,
      'transporterTokenVts': instance.transporterTokenVts,
      'status': instance.status,
      'transporterType': instance.transporterType,
      'transporterEmail': instance.transporterEmail,
      'password': instance.password,
      'birthDate': instance.birthDate?.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'token': instance.token,
      'tokenExpiredTime': instance.tokenExpiredTime?.toIso8601String(),
      'registeredDate': instance.registeredDate?.toIso8601String(),
      'imei': instance.imei,
      'os': instance.os,
      'adminPhoneNumber': instance.adminPhoneNumber,
      'adminWhatsAppNumber': instance.adminWhatsAppNumber,
    };
