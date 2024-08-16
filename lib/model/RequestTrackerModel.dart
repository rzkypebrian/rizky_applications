import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'RequestTrackerModel.g.dart';

@JsonSerializable(explicitToJson: true)
class RequestTrackerModel {
  int processId;
  DateTime dateTime;
  String functionType;
  String urlRequest;
  String data;

  RequestTrackerModel({
    this.processId,
    this.dateTime,
    this.functionType,
    this.urlRequest,
    this.data,
  });

  factory RequestTrackerModel.fromJson(Map<String, dynamic> json) =>
      _$RequestTrackerModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestTrackerModelToJson(this);

  static Future<RequestTrackerModel> saveLog({
    String token,
    RequestTrackerModel requestTrackerModel,
  }) {
    requestTrackerModel.processId = null;
    requestTrackerModel.dateTime = null;
    return NetworkUtil().post(
      System.data.apiEndPointUtil.saveServiceTrackerLog(),
      body: requestTrackerModel.toJson(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((value) {
      return RequestTrackerModel.fromJson(
        json.decode(value),
      );
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
