// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AngkutDestination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AngkutDestination _$AngkutDestinationFromJson(Map<String, dynamic> json) {
  return AngkutDestination(
    originAddress: json['originAddress'] as String,
    originPropinsi: json['originPropinsi'] as String,
    originKecamatan: json['originKecamatan'] as String,
    originKabupaten: json['originKabupaten'] as String,
    originContactPerson: json['originContactPerson'] as String,
    originContactNumber: json['originContactNumber'] as String,
    originAdditionalInfo: json['originAdditionalInfo'] as String,
    originNoteForDriver: json['originNoteForDriver'] as String,
    originLon: (json['originLon'] as num)?.toDouble(),
    originLat: (json['originLat'] as num)?.toDouble(),
    destinationAddress: json['destinationAddress'] as String,
    destinationPropinsi: json['destinationPropinsi'] as String,
    destinationKecamatan: json['destinationKecamatan'] as String,
    destinationKabupaten: json['destinationKabupaten'] as String,
    destinationContactPerson: json['destinationContactPerson'] as String,
    destinationContactNumber: json['destinationContactNumber'] as String,
    destinationAdditionalInfo: json['destinationAdditionalInfo'] as String,
    destinationNoteForDriver: json['destinationNoteForDriver'] as String,
    destinationLon: (json['destinationLon'] as num)?.toDouble(),
    destinationLat: (json['destinationLat'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AngkutDestinationToJson(AngkutDestination instance) =>
    <String, dynamic>{
      'originAddress': instance.originAddress,
      'originPropinsi': instance.originPropinsi,
      'originKecamatan': instance.originKecamatan,
      'originKabupaten': instance.originKabupaten,
      'originContactPerson': instance.originContactPerson,
      'originContactNumber': instance.originContactNumber,
      'originAdditionalInfo': instance.originAdditionalInfo,
      'originNoteForDriver': instance.originNoteForDriver,
      'originLon': instance.originLon,
      'originLat': instance.originLat,
      'destinationAddress': instance.destinationAddress,
      'destinationPropinsi': instance.destinationPropinsi,
      'destinationKecamatan': instance.destinationKecamatan,
      'destinationKabupaten': instance.destinationKabupaten,
      'destinationContactPerson': instance.destinationContactPerson,
      'destinationContactNumber': instance.destinationContactNumber,
      'destinationAdditionalInfo': instance.destinationAdditionalInfo,
      'destinationNoteForDriver': instance.destinationNoteForDriver,
      'destinationLon': instance.destinationLon,
      'destinationLat': instance.destinationLat,
    };
