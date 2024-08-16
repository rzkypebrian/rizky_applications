import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerUtil {
  static List<ObjectData<dynamic>> readPointDestination({
    @required List<TmsShipmentDestinationModel> destinations,
    String markerOriginIcon,
    MarkerIconType markerOriginIconType,
    int markerOriginIconSize,
    String markerDestinationIcon,
    MarkerIconType markerDestinationIconType,
    int markerDestinationIconSize,
    bool showDestinationNumber = false,
  }) {
    List<ObjectData<dynamic>> points = [];
    if (destinations != null && destinations.length > 0) {
      points.addAll(List.generate(
        1,
        (i) {
          return ObjectData(
            markerIconType: markerOriginIconType ?? MarkerIconType.Asset,
            markerIcon: markerOriginIcon ?? "assets/track_destination.png",
            iconSize: markerOriginIconSize ?? 100,
            flat: false,
            name: destinations[i].originContactPerson,
            snipset: destinations[i].originAddress,
            latLng:
                LatLng(destinations[i].originLat, destinations[i].originLong),
          );
        },
      ));

      points.addAll(List.generate(
        destinations.length,
        (i) {
          return ObjectData(
            markerIconType: markerDestinationIconType ?? MarkerIconType.Asset,
            markerIcon: markerDestinationIcon ?? "assets/flag_regular.png",
            iconSize: markerDestinationIconSize ?? 100,
            name:
                "${showDestinationNumber && destinations.length > 1 ? "Tujuan " + (i + 1).toString() : ""} ${destinations[i].destinationContactPerson ?? ""}",
            snipset: destinations[i].destinationAddress,
            address: destinations[i].destinationAddress,
            flat: false,
            latLng: LatLng(destinations[i].destinationLat,
                destinations[i].destinationLong),
          );
        },
      ));
    }

    return points;
  }
}
