// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsShipmentDestinationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsShipmentDestinationModel<T> _$TmsShipmentDestinationModelFromJson<T>(
    Map<String, dynamic> json) {
  return TmsShipmentDestinationModel<T>(
    detailshipmentId: json['detailshipmentId'] as int,
    tmsShipmentId: json['tmsShipmentId'] as int,
    detailBarcode: json['detailBarcode'] as String,
    vehicleId: json['vehicleId'] as int,
    vehicleIdVts: json['vehicleIdVts'] as int,
    vehicleRegNumber: json['vehicleRegNumber'] as String,
    vehicleNo: json['vehicleNo'] as String,
    vehicleType: json['vehicleType'] as String,
    vehicleTypeIconUrl: json['vehicleTypeIconUrl'] as String,
    vehicleTypeIconUrlTop: json['vehicleTypeIconUrlTop'] as String,
    vehicleBackDoorSensor: json["vehicleBackDoorSensor"] as String,
    vehicleFanSensor: json["vehicleFanSensor"] as String,
    vehicleTemperatureSensor: json["vehicleTemperatureSensor"] as String,
    driverId: json['driverId'] as int,
    driverName: json['driverName'] as String,
    driverRating: (json['driverRating'] as num)?.toDouble(),
    driverPhone: json['driverPhone'] as String,
    originGeom: json['originGeom'] == null
        ? null
        : DbGeometryModel.fromJson(json['originGeom']),
    originLat: (json['originLat'] as num)?.toDouble(),
    originLong: (json['originLong'] as num)?.toDouble(),
    originAddress: json['originAddress'] as String,
    originAdditionalInfo: json['originAdditionalInfo'] as String,
    routeId: json['routeId'] as int,
    destinationGeom: json['destinationGeom'] == null
        ? null
        : DbGeometryModel.fromJson(json['destinationGeom']),
    destinationLat: (json['destinationLat'] as num)?.toDouble(),
    destinationLong: (json['destinationLong'] as num)?.toDouble(),
    destinationAddress: json['destinationAddress'] as String,
    destinationAdditionalInfo: json['destinationAdditionalInfo'] as String,
    destinationAddressNote: json['destinationAddressNote'] as String,
    cycleType: json['cycleType'] as int,
    detailStatus: json['detailStatus'] as dynamic,
    detailStatusName: json['detailStatusName'] as String,
    detailStatusOrder: json['detailStatusOrder'] as int,
    remarks: json['remarks'] as String,
    isDeleted: json['isDeleted'] as bool,
    memberId: json['memberId'] as int,
    routeList: (json['routeList'] as List)
        ?.map((e) => e == null ? null : TmsRouteModel.fromJson(e))
        ?.toList(),
    shipmentDetailData: json['shipmentDetailData'],
    tmsShipmentDetailHistoryList: (json['tmsShipmentDetailHistoryList'] as List)
        ?.map((e) => e == null ? null : TmsShipmentHistory.fromJson(e))
        ?.toList(),
  )
    ..transporterCode = json['transporterCode'] as String
    ..transporterName = json['transporterName'] as String
    ..vehicleSensor = json['vehicleSensor'] as String
    ..driverImageUrl = json['driverImageUrl'] as String
    ..coDriverId = json['coDriverId'] as int
    ..vehicleTypeIconTopSize = json['vehicleTypeIconTopSize'] as int
    ..receiverName = json['receiverName'] as String
    ..coDriverName = json['coDriverName'] as String
    ..coDriverImageUrl = json['coDriverImageUrl'] as String
    ..arrivalETAToDestination = json['arrivalETAToDestination'] == null
        ? null
        : DateTime.parse(json['arrivalETAToDestination'] as String)
    ..distanceOriginToDestination =
        (json['distanceOriginToDestination'] as num)?.toDouble()
    ..originContactPerson = json['originContactPerson'] as String
    ..originContactNumber = json['originContactNumber'] as String
    ..originNoteForDriver = json['originNoteForDriver'] as String
    ..destinationContactNumber = json['destinationContactNumber'] as String
    ..destinationContactPerson = json['destinationContactPerson'] as String
    ..destinationNoteForDriver = json['destinationNoteForDriver'] as String
    ..deliveryName = json['deliveryName'] as String
    ..deliveryAddress = json['deliveryAddress'] as String
    ..isDoLoading = json['isDoLoading'] as bool
    ..emergencyData = (json['emergencyData'] as List)
            ?.map(
                (e) => e == null ? null : TmsDeliveryEmergencyModel.fromJson(e))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$TmsShipmentDestinationModelToJson<T>(
        TmsShipmentDestinationModel<T> instance) =>
    <String, dynamic>{
      'detailshipmentId': instance.detailshipmentId,
      'tmsShipmentId': instance.tmsShipmentId,
      'detailBarcode': instance.detailBarcode,
      'transporterCode': instance.transporterCode,
      'transporterName': instance.transporterName,
      'vehicleBackDoorSensor': instance.vehicleBackDoorSensor,
      'vehicleFanSensor': instance.vehicleFanSensor,
      'vehicleTemperatureSensor': instance.vehicleTemperatureSensor,
      'vehicleId': instance.vehicleId,
      'vehicleIdVts': instance.vehicleIdVts,
      'vehicleRegNumber': instance.vehicleRegNumber,
      'vehicleNo': instance.vehicleNo,
      'vehicleType': instance.vehicleType,
      'vehicleTypeIconUrl': instance.vehicleTypeIconUrl,
      'vehicleTypeIconUrlTop': instance.vehicleTypeIconUrlTop,
      'vehicleSensor': instance.vehicleSensor,
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      'driverPhone': instance.driverPhone,
      'driverImageUrl': instance.driverImageUrl,
      'coDriverId': instance.coDriverId,
      'coDriverName': instance.coDriverName,
      'coDriverImageUrl': instance.coDriverImageUrl,
      'receiverName': instance.coDriverImageUrl,
      'originGeom': instance.originGeom?.toJson(),
      'originLat': instance.originLat,
      'originLong': instance.originLong,
      'originAddress': instance.originAddress,
      'originAdditionalInfo': instance.originAdditionalInfo,
      'originNoteForDriver': instance.originNoteForDriver,
      'routeId': instance.routeId,
      'destinationGeom': instance.destinationGeom?.toJson(),
      'destinationLat': instance.destinationLat,
      'destinationLong': instance.destinationLong,
      'destinationAddress': instance.destinationAddress,
      'destinationAddressNote': instance.destinationAddressNote,
      'destinationAdditionalInfo': instance.destinationAdditionalInfo,
      'destinationNoteForDriver': instance.destinationNoteForDriver,
      'cycleType': instance.cycleType,
      'detailStatus': instance.detailStatus,
      'detailStatusName': instance.detailStatusName,
      'detailStatusOrder': instance.detailStatusOrder,
      'remarks': instance.remarks,
      'isDeleted': instance.isDeleted,
      'memberId': instance.memberId,
      'routeList': instance.routeList?.map((e) => e?.toJson())?.toList(),
      'shipmentDetailData': instance.shipmentDetailData,
      'tmsShipmentDetailHistoryList': instance.tmsShipmentDetailHistoryList
          ?.map((e) => e?.toJson())
          ?.toList(),
      'arrivalETAToDestination': instance.arrivalETAToDestination,
      'distanceOriginToDestination': instance.distanceOriginToDestination,
      'originContactNumber': instance.originContactNumber,
      'originContactPerson': instance.originContactPerson,
      'destinationContactNumber': instance.destinationContactNumber,
      'destinationContactPerson': instance.destinationContactPerson,
      'deliveryName': instance.deliveryName,
      'deliveryAddress': instance.deliveryAddress,
      'emergencyData':
          instance.emergencyData?.map((e) => e?.toJson())?.toList(),
      'vehicleTypeIconTopSize': instance.vehicleTypeIconTopSize,
    };
