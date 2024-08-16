import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleApiEndPointUtil {
  String baseUrl = "https://maps.googleapis.com/maps/api/";
  String baseUrlDebug = "https://maps.googleapis.com/maps/api/";

  String get url {
    String endPoint;
    var x = ModeUtil.debugMode;
    if (x == true) {
      endPoint = baseUrlDebug;
    } else {
      endPoint = baseUrl;
    }
    print(endPoint);
    return endPoint;
  }

  String getDirection({
    @required String origin,
    @required String destination,
    List<LatLng> wayPoint,
    @required String apiKey,
  }) {
    List<String> _wayPointList = [];
    String _wayPoint;

    if (wayPoint != null) {
      wayPoint.forEach((e) {
        _wayPointList.add("${e.latitude},${e.longitude}");
      });

      _wayPoint = _wayPointList.join("|");
    }

    String _url = this.url +
        "directions/json?origin=${origin ?? ""}&destination=${destination ?? ""}&waypoints=${_wayPoint ?? ""}&key=${apiKey ?? ""}&language=id";

    print(_url);

    return _url;
  }

  String getMatrix({
    @required LatLng origin,
    @required List<LatLng> destinations,
    @required String apiKey,
  }) {
    List<String> _wayPointList = [];
    String _destination;

    if (destinations != null) {
      destinations.forEach((e) {
        _wayPointList.add("${e.latitude},${e.longitude}");
      });

      _destination = _wayPointList.join("|");
    }

    String _url = this.url +
        "distancematrix/json?units=imperial&origins=${origin != null ? origin.latitude.toString() + "," + origin.longitude.toString() : ""}&destinations=${_destination ?? ""}&key=${apiKey ?? ""}";

    return _url;
  }

  String getPlace({
    @required String placeid,
    @required String apiKey,
  }) {
    return this.url + "place/details/json?placeid=$placeid&key=$apiKey";
  }
}
