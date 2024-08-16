import 'package:enerren/app/angkut/model/AngkutShipmentDescription.dart';
import 'package:enerren/model/tmsDbGeometryModel.dart';
import 'package:enerren/model/tmsRouteModel.dart';
import 'package:enerren/model/tmsShipmentHistory.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AngkutShipmentDestination.g.dart';

@JsonSerializable(explicitToJson: true)
class AngkutShipmentDestination {
  int detailshipmentId;
  int tmsShipmentId;
  String detailBarcode;
  String transporterCode;
  String transporterName;
  int vehicleId;
  int vehicleIdVts;
  String vehicleRegNumber;
  String vehicleNo;
  String vehicleType;
  String vehicleSensor;
  int driverId;
  String driverName;
  String driverImageUrl;
  int coDriverId;
  String coDriverName;
  String coDriverImageUrl;
  DbGeometryModel originGeom;
  double originLat;
  double originLong;
  int routeId;
  DbGeometryModel destinationGeom;
  double destinationLat;
  double destinationLong;
  int cycleType;
  int detailStatus;
  String detailStatusName;
  int detailStatusOrder;
  String remarks;
  String originAddress;
  String originPropinsi;
  String originKecamatan;
  String originKabupaten;
  String originContactPerson;
  String originContactNumber;
  String originAdditionalInfo;
  String destinationAddress;
  String destinationPropinsi;
  String destinationKecamatan;
  String destinationKabupaten;
  String destinationContactPerson;
  String destinationContactNumber;
  String destinationAdditionalInfo;
  double vehicleStartLat;
  double vehicleStartLon;
  int vehicleStartOdometer;
  List<TmsRouteModel> routeList;
  AngkutShipmentDescription shipmentDetailData;
  List<TmsShipmentHistory> tmsShipmentDetailHistoryList;
  DateTime arrivalETAToDestination;
  double distanceOriginToDestination;

  AngkutShipmentDestination({
    this.detailshipmentId,
    this.tmsShipmentId,
    this.detailBarcode,
    this.transporterCode,
    this.transporterName,
    this.vehicleId,
    this.vehicleIdVts,
    this.vehicleRegNumber,
    this.vehicleNo,
    this.vehicleType,
    this.vehicleSensor,
    this.driverId,
    this.driverName,
    this.driverImageUrl,
    this.coDriverId,
    this.coDriverName,
    this.coDriverImageUrl,
    this.originGeom, //originGeom
    this.originLat,
    this.originLong,
    this.routeId,
    this.destinationGeom, //destinationGeom
    this.destinationLat,
    this.destinationLong,
    this.cycleType,
    this.detailStatus,
    this.detailStatusName,
    this.detailStatusOrder,
    this.remarks,
    this.originAddress,
    this.originPropinsi,
    this.originKecamatan,
    this.originKabupaten,
    this.originContactPerson,
    this.originContactNumber,
    this.originAdditionalInfo,
    this.destinationAddress,
    this.destinationPropinsi,
    this.destinationKecamatan,
    this.destinationKabupaten,
    this.destinationContactPerson,
    this.destinationContactNumber,
    this.destinationAdditionalInfo,
    this.vehicleStartLat,
    this.vehicleStartLon,
    this.vehicleStartOdometer,
    this.routeList,
    this.shipmentDetailData,
    this.arrivalETAToDestination,
    this.distanceOriginToDestination,
    this.tmsShipmentDetailHistoryList, //tmsShipmentDetailHistoryList
  });

  factory AngkutShipmentDestination.fromJson(Map<String, dynamic> json) =>
      _$AngkutShipmentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AngkutShipmentDetailToJson(this);
}
