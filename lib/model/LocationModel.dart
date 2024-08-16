import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'LocationModel.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationModel {
  int locHistoryId;
  int customerId;
  String addressLabel;
  String address;
  String kecamatan;
  String kabupaten;
  String propinsi;
  String placeId;
  double lon;
  double lat;

  LocationModel({
    this.locHistoryId,
    this.customerId,
    this.addressLabel,
    this.address,
    this.kecamatan,
    this.kabupaten,
    this.propinsi,
    this.placeId,
    this.lon,
    this.lat,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  static Future<List<LocationModel>> getHistory({
    int customerId,
    String token,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.getLocationHistory(
        customerId: customerId,
      ),
      headers: {
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      on401: (response) {
        throw response;
      },
    ).then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => LocationModel.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<LocationModel> addHistory({
    LocationModel locationModel,
    String token,
  }) {
    return NetworkUtil()
        .post(
      System.data.apiEndPointUtil.addLocationHistory(),
      headers: {
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: locationModel.toJson(),
      encoding: Encoding.getByName("apliaction/json"),
    )
        .then((onValue) {
      return LocationModel.fromJson(json.decode(onValue));
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<LocationModel>> deleteLocationHistory({
    int customerId,
    int historyId,
    String token,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.deleteLocationHistory(
        customerId: customerId,
        historyId: historyId,
      ),
      headers: {
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => LocationModel.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
