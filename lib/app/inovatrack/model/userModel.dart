import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'userModel.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: "UserId")
  int userId;

  @JsonKey(name: "MemberId")
  int memberId;

  @JsonKey(name: "UserName")
  String userName;

  @JsonKey(name: "UserFullName")
  String userFullName;

  @JsonKey(name: "MemberName")
  String memberName;

  @JsonKey(name: "UserType")
  int userType;

  @JsonKey(name: "Token")
  String token;

  @JsonKey(name: "LastAndroidAppVersionCode")
  int lastAndroidAppVersionCode;

  UserModel({
    this.userId,
    this.memberId,
    this.userName,
    this.userFullName,
    this.memberName,
    this.userType,
    this.token,
    this.lastAndroidAppVersionCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static Future<UserModel> login({
    String memberCode,
    String userName,
    String password,
  }) {
    return NetworkUtil().get(
      System.data.apiEndPointUtil.loginInovaTrack(
        memberCode: memberCode,
        userName: userName,
        token: ApiEndPointUtil.encrypMd5("$userName|$password"),
      ),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      UserModel _result = UserModel.fromJson(json.decode(onValue));
      _result.token = ApiEndPointUtil.encrypMd5("$userName|$password");
      return _result;
    }).catchError((onError) {
      throw onError;
    });
  }
}
