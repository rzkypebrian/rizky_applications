// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) {
  return RegisterModel(
    userId: json['userId'] as int,
    userNik: json['userNik'] as String,
    phoneNum: json['phoneNum'] as String,
    email: json['email'] as String,
    fullName: json['fullName'] as String,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    address: json['address'] as String,
    confirmPassword: json['confirmPassword'] as String,
    password: json['password'] as String,
    imei: json['imei'] as String,
    os: json['os'] as String,
    deviceId: json['deviceId'] as String,
  );
}

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userNik': instance.userNik,
      'phoneNum': instance.phoneNum,
      'email': instance.email,
      'fullName': instance.fullName,
      'birthDate': instance.birthDate?.toIso8601String(),
      'address': instance.address,
      'confirmPassword': instance.confirmPassword,
      'password': instance.password,
      'imei': instance.imei,
      'os': instance.os,
      'deviceId': instance.deviceId,
    };
