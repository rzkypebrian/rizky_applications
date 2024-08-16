import 'package:enerren/model/tmsDbGeometryModel.dart';
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:enerren/model/tmsRouteModel.dart';
import 'package:enerren/model/tmsShipmentHistory.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsShipmentDestinationModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsShipmentDestinationModel<T> {
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
  String vehicleTypeIconUrl;
  String vehicleTypeIconUrlTop;
  int vehicleTypeIconTopSize;
  String vehicleSensor;
  String vehicleBackDoorSensor;
  String vehicleFanSensor;
  String vehicleTemperatureSensor;
  int driverId;
  String driverName;
  String driverPhone;
  String driverImageUrl;
  double driverRating;
  int coDriverId;
  String coDriverName;
  String coDriverImageUrl;
  String receiverName;
  DbGeometryModel originGeom;
  double originLat;
  double originLong;
  String originAddress;
  String originAdditionalInfo;
  String originNoteForDriver;
  int routeId;
  DbGeometryModel destinationGeom;
  double destinationLat;
  double destinationLong;
  String destinationAddress;
  String destinationAddressNote;
  String destinationAdditionalInfo;
  String destinationNoteForDriver;
  int cycleType;
  dynamic detailStatus;
  String detailStatusName;
  int detailStatusOrder;
  String remarks;
  bool isDeleted;
  int memberId;
  DateTime arrivalETAToDestination;
  double distanceOriginToDestination;
  List<TmsRouteModel> routeList;
  dynamic shipmentDetailData;
  T shipmentDetailDataObject;
  List<TmsShipmentHistory> tmsShipmentDetailHistoryList;
  ChildReader<T> childReader;
  String originContactPerson;
  String destinationContactPerson;
  String originContactNumber;
  String destinationContactNumber;
  String deliveryName;
  String deliveryAddress;
  bool isDoLoading;
  List<TmsDeliveryEmergencyModel> emergencyData;

  TmsShipmentDestinationModel({
    this.transporterName,
    this.detailshipmentId,
    this.tmsShipmentId,
    this.detailBarcode,
    this.vehicleId,
    this.vehicleIdVts,
    this.vehicleRegNumber,
    this.vehicleNo,
    this.vehicleType,
    this.vehicleTypeIconUrl,
    this.vehicleTypeIconUrlTop,
    this.vehicleBackDoorSensor,
    this.vehicleFanSensor,
    this.vehicleTemperatureSensor,
    this.driverId,
    this.driverName,
    this.driverPhone,
    this.originGeom,
    this.originLat,
    this.originLong,
    this.originAddress,
    this.originAdditionalInfo,
    this.originNoteForDriver,
    this.routeId,
    this.destinationGeom,
    this.destinationLat,
    this.destinationLong,
    this.destinationAddress,
    this.destinationAdditionalInfo,
    this.destinationAddressNote,
    this.destinationNoteForDriver,
    this.cycleType,
    this.detailStatus,
    this.detailStatusName,
    this.detailStatusOrder,
    this.remarks,
    this.isDeleted,
    this.memberId,
    this.routeList,
    this.arrivalETAToDestination,
    this.distanceOriginToDestination,
    this.shipmentDetailData,
    this.tmsShipmentDetailHistoryList,
    this.shipmentDetailDataObject,
    this.driverImageUrl,
    this.driverRating,
    this.deliveryName,
    this.deliveryAddress,
    this.isDoLoading,
    this.emergencyData,
  });

  TmsDeliveryEmergencyModel get getCurrentEmergency {
    return this.emergencyData.length > 0 ? this.emergencyData.first : null;
  }

  Map<String, dynamic> toJson() => _$TmsShipmentDestinationModelToJson(this);

  static List<TmsShipmentDestinationModel<T>> fromJsonList<T>(
    dynamic data, {
    ChildReader<T> childReader,
  }) {
    try {
      return (data as List)
          .map((dataJson) => fromJson<T>(
                dataJson,
                childReader: childReader,
              ))
          .toList();
    } catch (e) {
      print("error read destination $e");
      return null;
    }
  }

  static TmsShipmentDestinationModel<T> fromJson<T>(
    Map<String, dynamic> json, {
    ChildReader<T> childReader,
  }) {
    TmsShipmentDestinationModel<T> data =
        _$TmsShipmentDestinationModelFromJson(json);

    try {
      data.shipmentDetailDataObject =
          childReader != null ? childReader(json["shipmentDetailData"]) : null;
    } catch (e) {
      data.shipmentDetailDataObject = null;
    }

    return data;
  }
}
