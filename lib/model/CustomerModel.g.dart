// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) {
  return CustomerModel(
    customerId: json["customerId"] as int,
    customerNo: json['customerNo'] as String,
    memberId: json['memberId'] as int,
    customerEmail: json['customerEmail'] as String,
    customerName: json['customerName'] as String,
    customerMobile: json['customerMobile'] as String,
    customerAddress: json['customerAddress'] as String,
    customerStatus: json['customerStatus'] as int,
    customerType: json['customerType'] as String,
    imageUrl: json['imageUrl'] as String,
    password: json['password'] as String,
    token: json['token'] as String,
    tokenExpiredTime: json['tokenExpiredTime'] == null
        ? null
        : DateTime.parse(json['tokenExpiredTime'] as String),
    registeredDate: json['registeredDate'] == null
        ? null
        : DateTime.parse(json['registeredDate'] as String),
    adminPhoneNumber: json['adminPhoneNumber'] as String,
    adminWhatsAppNumber: json['adminWhatsAppNumber'] as String,
    thirdPartyName: json["thirdPartyName"],
    thirdPartyUserId: json["thirdPartyUserId"],
  );
}

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'customerNo': instance.customerNo,
      'memberId': instance.memberId,
      'customerEmail': instance.customerEmail,
      'customerName': instance.customerName,
      'customerMobile': instance.customerMobile,
      'customerAddress': instance.customerAddress,
      'customerStatus': instance.customerStatus,
      'customerType': instance.customerType,
      'imageUrl': instance.imageUrl,
      'password': instance.password,
      'token': instance.token,
      'tokenExpiredTime': instance.tokenExpiredTime?.toIso8601String(),
      'registeredDate': instance.registeredDate?.toIso8601String(),
      'adminPhoneNumber': instance.adminPhoneNumber,
      'adminWhatsAppNumber': instance.adminWhatsAppNumber,
      'thirdPartyName': instance.thirdPartyName,
      'thirdPartyUserId': instance.thirdPartyUserId,
    };
