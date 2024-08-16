import 'dart:convert';
import 'dart:io';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'VehicleCategory.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleCategory {
  int vehicleSizeId;
  String vehicleSizeName;
  String remarks;
  String urlIcon;
  bool isAvailable;
  List<VehicleType> vehicleTypeList;

  VehicleCategory({
    this.vehicleSizeId,
    this.vehicleSizeName,
    this.remarks,
    this.urlIcon,
    this.isAvailable,
    this.vehicleTypeList,
  });

  factory VehicleCategory.fromJson(Map<String, dynamic> json) =>
      _$VehicleCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleCategoryToJson(this);

  static Future<List<VehicleCategory>> getAllVehicleType({String token}) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.get(
      System.data.apiEndPointUtil.getAllVehicleType(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return (json.decode(onValue) as List)
            .map((f) => VehicleCategory.fromJson(f))
            .toList();
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}

@JsonSerializable(explicitToJson: true)
class VehicleType {
  int vehicleTypeId;
  int memberId;
  String vehicleTypeName;
  String remarks;
  int maxPassenger;
  int sizeId;
  double configWaitingDuration;
  double configWaitingParameter;
  double configDistanceThreshold;
  double configWaitingAfterConfirm;
  String length;
  String width;
  String height;
  String weight;
  String volume;
  String iconUrl;
  String insertedBy;
  DateTime insertedDate;
  String modifiedBy;
  bool isAvailable;
  DateTime modifiedDate;

  VehicleType({
    this.vehicleTypeId,
    this.memberId,
    this.vehicleTypeName,
    this.remarks,
    this.maxPassenger,
    this.sizeId,
    this.configWaitingDuration,
    this.configWaitingParameter,
    this.configDistanceThreshold,
    this.configWaitingAfterConfirm,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.volume,
    this.iconUrl,
    this.insertedBy,
    this.insertedDate,
    this.modifiedBy,
    this.isAvailable,
    this.modifiedDate,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleTypeToJson(this);
}
