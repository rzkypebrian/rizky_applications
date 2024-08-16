// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return LocationModel(
    locHistoryId: json['locHistoryId'] as int,
    customerId: json['customerId'] as int,
    addressLabel: json['addressLabel'] as String,
    address: json['address'] as String,
    kecamatan: json['kecamatan'] as String,
    kabupaten: json['kabupaten'] as String,
    propinsi: json['propinsi'] as String,
    lon: (json['lon'] as num)?.toDouble(),
    lat: (json['lat'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'locHistoryId': instance.locHistoryId,
      'customerId': instance.customerId,
      'addressLabel': instance.addressLabel,
      'address': instance.address,
      'kecamatan': instance.kecamatan,
      'kabupaten': instance.kabupaten,
      'propinsi': instance.propinsi,
      'lon': instance.lon,
      'lat': instance.lat,
    };
