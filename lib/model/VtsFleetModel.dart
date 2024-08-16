import 'dart:convert';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'VtsFleetModel.g.dart';

@JsonSerializable(explicitToJson: true)
class VtsFleetModel {
  @JsonKey(name: "fleet_id")
  int fleetId;

  @JsonKey(name: "fleet_name")
  String fleetName;

  @JsonKey(name: "vehicles")
  List<int> vehicles;

  VtsFleetModel({
    this.fleetId,
    this.fleetName,
    this.vehicles,
  });

  factory VtsFleetModel.fromJson(Map<String, dynamic> json) =>
      _$VtsFleetModelFromJson(json);

  Map<String, dynamic> toJson() => _$VtsFleetModelToJson(this);

  static Future<List<VtsFleetModel>> getAllFleets({
    @required int userId,
    @required String token,
  }) {
    return NetworkUtil()
        .get(System.data.apiEndPointUtil.getVtsAllFleets(
      userId: userId,
      token: token,
    ))
        .then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => VtsFleetModel.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
