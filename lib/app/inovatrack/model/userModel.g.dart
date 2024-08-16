// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    userId: json['UserId'] as int,
    memberId: json['MemberId'] as int,
    userName: json['UserName'] as String,
    userFullName: json['UserFullName'] as String,
    memberName: json['MemberName'] as String,
    userType: json['UserType'] as int,
    token: json['Token'] as String,
    lastAndroidAppVersionCode: json['LastAndroidAppVersionCode'] as int,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'UserId': instance.userId,
      'MemberId': instance.memberId,
      'UserName': instance.userName,
      'UserFullName': instance.userFullName,
      'MemberName': instance.memberName,
      'UserType': instance.userType,
      'Token': instance.token,
      'LastAndroidAppVersionCode': instance.lastAndroidAppVersionCode,
    };
