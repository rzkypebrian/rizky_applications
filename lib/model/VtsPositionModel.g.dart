// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VtsPositionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VtsPositionModel _$VtsPositionModelFromJson(Map<String, dynamic> json) {
  VtsPositionModel data = VtsPositionModel()
    ..positionId = json['position_id'] as int
    ..vehicleId = json['vehicle_id'] as int
    ..vehicleName = json['vehicle_name'] as String
    ..vehicleNumber = json['vehicle_number'] as String
    ..vehicleType = json['vehicle_type'] as String
    ..gsmNumber = json['gsm_number'] as String
    ..gpsValid = json['gps_valid'] as bool
    ..dateTime = json['date_time'] == null
        ? null
        : DateTime.parse(json['date_time'] as String)
    ..x = (json['x'] as num)?.toDouble()
    ..y = (json['y'] as num)?.toDouble()
    ..speed = (json['speed'] as num)?.toDouble()
    ..course = (json['course'] as num)?.toDouble()
    ..tripOdometer = (json['trip_odometer'] as num)?.toDouble()
    ..odometer = (json['odometer'] as num)?.toDouble()
    ..engineHourMeter = (json['engine_hour_meter'] as num)?.toDouble()
    // ..engine = json['engine'] as int
    ..emergency = json['emergency'] as bool
    ..status1 = json['status_1'] as bool
    ..status1Label = json['status_1_label'] as String
    ..status2 = json['status_2'] as bool
    ..status2Label = json['status_2_label'] as String
    ..status3 = json['status_3'] as bool
    ..status3Label = json['status_3_label'] as String
    ..fuelLevel = json['fuel_level'] as int
    ..streetName = json['street_name'] as String
    ..kecamatan = json['kecamatan'] as String
    ..kabupaten = json['kabupaten'] as String
    ..geofenceName = json['geofence_name'] as String
    ..driverName = json['driver_name'] as String
    ..overspeed = json['overspeed'] as bool
    ..idling = json['idling'] as bool
    ..mainPower = json['main_power'] as bool
    ..fuelLevelLiter = (json['fuel_level_liter'] as num)?.toDouble()
    ..temp1 = (json['temp_1'] as num)?.toDouble()
    ..imageIconUrl = json['image_icon_url'] as String;

  //for anormalize data
  try {
    data.engine = json['engine'] as int;
    data.x = data.x == null ? null : data.x * 1E7;
    data.y = data.y == null ? null : data.y * 1E7;
  } catch (e) {
    bool engine = json['engine'] as bool;
    data.engine = engine == null ? null : engine == true ? 1 : 0;
  }
  return data;
}

Map<String, dynamic> _$VtsPositionModelToJson(VtsPositionModel instance) =>
    <String, dynamic>{
      'position_id': instance.positionId,
      'vehicle_id': instance.vehicleId,
      'vehicle_name': instance.vehicleName,
      'vehicle_number': instance.vehicleNumber,
      'vehicle_type': instance.vehicleType,
      'gsm_number': instance.gsmNumber,
      'gps_valid': instance.gpsValid,
      'date_time': instance.dateTime?.toIso8601String(),
      'x': instance.x,
      'y': instance.y,
      'speed': instance.speed,
      'course': instance.course,
      'trip_odometer': instance.tripOdometer,
      'odometer': instance.odometer,
      'engine_hour_meter': instance.engineHourMeter,
      'engine': instance.engine,
      'emergency': instance.emergency,
      'status_1': instance.status1,
      'status_1_label': instance.status1Label,
      'status_2': instance.status2,
      'status_2_label': instance.status2Label,
      'status_3': instance.status3,
      'status_3_label': instance.status3Label,
      'fuel_level': instance.fuelLevel,
      'street_name': instance.streetName,
      'kecamatan': instance.kecamatan,
      'kabupaten': instance.kabupaten,
      'geofence_name': instance.geofenceName,
      'driver_name': instance.driverName,
      'overspeed': instance.overspeed,
      'idling': instance.idling,
      'main_power': instance.mainPower,
      'fuel_level_liter': instance.fuelLevelLiter,
      'temp_1': instance.temp1,
      'image_icon_url': instance.imageIconUrl,
    };

VtsPositionModel fromJsonMode2(Map<String, dynamic> json) {
  VtsPositionModel data = VtsPositionModel()
    ..vehicleId = json['VehicleId'] as int
    ..vehicleNumber = json['VehicleNumber'] as String
    ..vehicleName = json['vehicleName'] as String
    ..vehicleType = json['VehicleType'] as String
    ..odometer = (json['Odometer'] as num)?.toDouble()
    ..tripOdometer = (json['TripOdometer'] as num)?.toDouble()
    ..engine = (json['Engine'] as String) == "ON" ? 1 : 0
    ..speed = (json['Speed'] as num)?.toDouble()
    ..speed = (json['Course'] as num)?.toDouble()
    ..streetName = json['Location'] as String
    ..x = (json['Latitude'] as num)?.toDouble()
    ..y = (json['Longitude'] as num)?.toDouble()
    ..dateTime = json['LastReportTime'] == null
        ? null
        : DateTime.parse(json['LastReportTime'] as String);

  data.x = data.x == null ? null : data.x * 1E7;
  data.y = data.y == null ? null : data.y * 1E7;

  return data;
}
