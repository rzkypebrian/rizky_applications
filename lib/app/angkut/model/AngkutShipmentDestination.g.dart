// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AngkutShipmentDestination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AngkutShipmentDestination _$AngkutShipmentDetailFromJson(
    Map<String, dynamic> json) {
  return AngkutShipmentDestination(
      detailshipmentId: json['detailshipmentId'] as int,
      tmsShipmentId: json['tmsShipmentId'] as int,
      detailBarcode: json['detailBarcode'] as String,
      transporterCode: json['transporterCode'] as String,
      transporterName: json['transporterName'] as String,
      vehicleId: json['vehicleId'] as int,
      vehicleIdVts: json['vehicleIdVts'] as int,
      vehicleRegNumber: json['vehicleRegNumber'] as String,
      vehicleNo: json['vehicleNo'] as String,
      vehicleType: json['vehicleType'] as String,
      vehicleSensor: json['vehicleSensor'] as String,
      driverId: json['driverId'] as int,
      driverName: json['driverName'] as String,
      originGeom: json['originGeom'] == null
          ? null
          : DbGeometryModel.fromJson(json['originGeom']),
      driverImageUrl: json['driverImageUrl'] as String,
      coDriverId: json['coDriverId'] as int,
      coDriverName: json['coDriverName'] as String,
      coDriverImageUrl: json['coDriverImageUrl'] as String,
      originLat: (json['originLat'] as num)?.toDouble(),
      originLong: (json['originLong'] as num)?.toDouble(),
      routeId: json['routeId'] as int,
      destinationGeom: json['destinationGeom'] == null
          ? null
          : DbGeometryModel.fromJson(json['destinationGeom']),
      destinationLat: (json['destinationLat'] as num)?.toDouble(),
      destinationLong: (json['destinationLong'] as num)?.toDouble(),
      cycleType: json['cycleType'] as int,
      detailStatus: json['detailStatus'] as int,
      detailStatusName: json['detailStatusName'] as String,
      detailStatusOrder: json['detailStatusOrder'] as int,
      remarks: json['remarks'] as String,
      originAddress: json['originAddress'] as String,
      originPropinsi: json['originPropinsi'] as String,
      originKecamatan: json['originKecamatan'] as String,
      originKabupaten: json['originKabupaten'] as String,
      originContactPerson: json['originContactPerson'] as String,
      originContactNumber: json['originContactNumber'] as String,
      originAdditionalInfo: json['originAdditionalInfo'] as String,
      destinationAddress: json['destinationAddress'] as String,
      destinationPropinsi: json['destinationPropinsi'] as String,
      destinationKecamatan: json['destinationKecamatan'] as String,
      destinationKabupaten: json['destinationKabupaten'] as String,
      destinationContactPerson: json['destinationContactPerson'] as String,
      destinationContactNumber: json['destinationContactNumber'] as String,
      destinationAdditionalInfo: json['destinationAdditionalInfo'] as String,
      vehicleStartLat: (json['vehicleStartLat'] as num)?.toDouble(),
      vehicleStartLon: (json['vehicleStartLon'] as num)?.toDouble(),
      vehicleStartOdometer: json['vehicleStartOdometer'] as int,
      routeList: (json['routeList'] as List)
          ?.map((e) => e == null ? null : TmsRouteModel.fromJson(e))
          ?.toList(),
      shipmentDetailData: json['shipmentDetailData'] == null
          ? null
          : AngkutShipmentDescription.fromJson(
              json['shipmentDetailData'] as Map<String, dynamic>),
      tmsShipmentDetailHistoryList:
          (json['tmsShipmentDetailHistoryList'] as List)
              ?.map((e) => e == null ? null : TmsShipmentHistory.fromJson(e))
              ?.toList(),
      arrivalETAToDestination: json['arrivalETAToDestination'] == null
          ? null
          : DateTime.parse(json['arrivalETAToDestination'] as String),
      distanceOriginToDestination:
          (json['distanceOriginToDestination'] as num)?.toDouble());
}

Map<String, dynamic> _$AngkutShipmentDetailToJson(
        AngkutShipmentDestination instance) =>
    <String, dynamic>{
      'detailshipmentId': instance.detailshipmentId,
      'tmsShipmentId': instance.tmsShipmentId,
      'detailBarcode': instance.detailBarcode,
      'transporterCode': instance.transporterCode,
      'transporterName': instance.transporterName,
      'vehicleId': instance.vehicleId,
      'vehicleIdVts': instance.vehicleIdVts,
      'vehicleRegNumber': instance.vehicleRegNumber,
      'vehicleNo': instance.vehicleNo,
      'vehicleType': instance.vehicleType,
      'vehicleSensor': instance.vehicleSensor,
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      'driverImageUrl': instance.driverImageUrl,
      'originGeom': instance.originGeom?.toJson(),
      'coDriverId': instance.coDriverId,
      'coDriverName': instance.coDriverName,
      'coDriverImageUrl': instance.coDriverImageUrl,
      'originLat': instance.originLat,
      'originLong': instance.originLong,
      'routeId': instance.routeId,
      'destinationGeom': instance.destinationGeom?.toJson(),
      'destinationLat': instance.destinationLat,
      'destinationLong': instance.destinationLong,
      'cycleType': instance.cycleType,
      'detailStatus': instance.detailStatus,
      'detailStatusName': instance.detailStatusName,
      'detailStatusOrder': instance.detailStatusOrder,
      'remarks': instance.remarks,
      'originAddress': instance.originAddress,
      'originPropinsi': instance.originPropinsi,
      'originKecamatan': instance.originKecamatan,
      'originKabupaten': instance.originKabupaten,
      'originContactPerson': instance.originContactPerson,
      'originContactNumber': instance.originContactNumber,
      'originAdditionalInfo': instance.originAdditionalInfo,
      'destinationAddress': instance.destinationAddress,
      'destinationPropinsi': instance.destinationPropinsi,
      'destinationKecamatan': instance.destinationKecamatan,
      'destinationKabupaten': instance.destinationKabupaten,
      'destinationContactPerson': instance.destinationContactPerson,
      'destinationContactNumber': instance.destinationContactNumber,
      'destinationAdditionalInfo': instance.destinationAdditionalInfo,
      'vehicleStartLat': instance.vehicleStartLat,
      'vehicleStartLon': instance.vehicleStartLon,
      'vehicleStartOdometer': instance.vehicleStartOdometer,
      'routeList': instance.routeList?.map((e) => e?.toJson())?.toList(),
      'shipmentDetailData': instance.shipmentDetailData?.toJson(),
      'tmsShipmentDetailHistoryList': instance.tmsShipmentDetailHistoryList
          ?.map((e) => e?.toJson())
          ?.toList(),
      'arrivalETAToDestination': instance.arrivalETAToDestination,
      'distanceOriginToDestination': instance.distanceOriginToDestination,
    };
