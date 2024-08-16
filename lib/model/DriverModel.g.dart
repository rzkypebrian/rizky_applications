// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriverModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  return DriverModel(
    simType: json['simType'] as String,
    driverId: json['driverId'] as int,
    driverNik: json['driverNik'] as String,
    driverName: json['driverName'] as String,
    driverCode: json['driverCode'] as String,
    memberId: json['memberId'] as int,
    username: json['username'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    confirmPassword: json['confirmPassword'] as String,
    simNumber: json['simNumber'] as String,
    gsmNumber: json['gsmNumber'] as String,
    phoneNumber: json['phoneNumber'] as String,
    phoneNumberConfirmed: json['phoneNumberConfirmed'] as bool,
    status: json['status'] as int,
    lastLoginTime: json['lastLoginTime'] == null
        ? null
        : DateTime.parse(json['lastLoginTime'] as String),
    udid: json['udid'] as String,
    registrationCode: json['registrationCode'] as String,
    pinHash: json['pinHash'] as String,
    insertedBy: json['insertedBy'] as String,
    insertedDate: json['insertedDate'] == null
        ? null
        : DateTime.parse(json['insertedDate'] as String),
    modifiedBy: json['modifiedBy'] as String,
    modifiedDate: json['modifiedDate'] == null
        ? null
        : DateTime.parse(json['modifiedDate'] as String),
    token: json['token'] as String,
    tokenExpiredTime: json['tokenExpiredTime'] == null
        ? null
        : DateTime.parse(json['tokenExpiredTime'] as String),
    urlProfileImage: json['urlProfileImage'] as String,
    score: (json['score'] as num)?.toDouble(),
    isReadyToWork: json['isReadyToWork'] as bool,
    adminPhoneNumber: json['adminPhoneNumber'] as String,
    adminWhatsAppNumber: json['adminWhatsAppNumber'] as String,
    transporterPhoneNumber: json['transporterPhoneNumber'] as String,
    transporterWhatsAppNumber: json['transporterWhatsAppNumber'] as String,
    vehicleIdVts: json['vehicleIdVts'] as int,
  );
}

Map<String, dynamic> _$DriverModelToJson(DriverModel instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'driverNik': instance.driverNik,
      'driverName': instance.driverName,
      'driverCode': instance.driverCode,
      'memberId': instance.memberId,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'simNumber': instance.simNumber,
      'gsmNumber': instance.gsmNumber,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberConfirmed': instance.phoneNumberConfirmed,
      'status': instance.status,
      'lastLoginTime': instance.lastLoginTime?.toIso8601String(),
      'udid': instance.udid,
      'registrationCode': instance.registrationCode,
      'pinHash': instance.pinHash,
      'insertedBy': instance.insertedBy,
      'insertedDate': instance.insertedDate?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
      'token': instance.token,
      'tokenExpiredTime': instance.tokenExpiredTime?.toIso8601String(),
      'urlProfileImage': instance.urlProfileImage,
      'score': instance.score,
      'simType': instance.simType,
      'isReadyToWork': instance.isReadyToWork,
      'adminPhoneNumber': instance.adminPhoneNumber,
      'adminWhatsAppNumber': instance.adminWhatsAppNumber,
      'transporterPhoneNumber': instance.transporterPhoneNumber,
      'transporterWhatsAppNumber': instance.transporterWhatsAppNumber,
      'vehicleIdVts': instance.vehicleIdVts,
    };
