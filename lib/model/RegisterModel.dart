import 'package:json_annotation/json_annotation.dart';
part 'RegisterModel.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterModel {
  int userId;
  String userNik;
  String phoneNum;
  String email;
  String fullName;
  DateTime birthDate;
  String address;
  String confirmPassword;
  String password;
  String imei;
  String os;
  String deviceId;

  RegisterModel({
    this.userId,
    this.userNik,
    this.phoneNum,
    this.email,
    this.fullName,
    this.birthDate,
    this.address,
    this.confirmPassword,
    this.password,
    this.imei,
    this.os,
    this.deviceId,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
