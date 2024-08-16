import 'package:enerren/component/customeGoogleMapUpdate/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMapUpdate/googleMapsValue.dart';
import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart"; 

class ViewModel extends ChangeNotifier {
  LatLng center;
  bool polygon;
  bool polyline;
  bool marker;
  bool circle;

  CameraPosition get getEndCameraPosition =>
      googleMapControllers.getEndCameraPosition;

  CameraPosition endPosition;
  CameraPosition startPosition;

  CameraPosition get getEndPosition => endPosition;
  CameraPosition get getStartPosition => startPosition;

  set setStartPositoin(CameraPosition position) {
    this.startPosition = position;
    commit();
  }

  set setEndPositoin(CameraPosition position) {
    this.endPosition = position;
    commit();
  }

  GoogleMapsControllers googleMapControllers = GoogleMapsControllers(
    GoogleMapValue(
      primaryIcon: "assets/marker_red.png",
      secondaryIcon: "assets/marker_dot_blue.png",
      isPolygon: true,
    ),
  );

  bool get getStatusPolygon {
    return googleMapControllers.getStatusPolygon;
  }

  bool get getStatusPolyline {
    return googleMapControllers.getStatusPolyline;
  }

  bool get getStatusPolymaker {
    return googleMapControllers.getStatusMarker;
  }
  bool get getStatusCircle {
    return googleMapControllers.getStatusCircle;
  }

  Future<void> setStatusPolygonv() async {
    googleMapControllers.changeIsPolygon();
    polygon = googleMapControllers.getStatusPolygon;
    if (!polygon)
      googleMapControllers.removePolygon();
    else {
      await googleMapControllers.generatePolygons();
    }
    commit();
  }

  Future<void> setStatusPolylinev() async {
    googleMapControllers.changeIsPolyline();
    polyline = googleMapControllers.getStatusPolyline;
    if (!polyline)
      googleMapControllers.removePolylines();
    else {
      await googleMapControllers.generatePolyLines();
    }
    commit();
  }

  Future<void> setStatusMarker() async {
    googleMapControllers.changeIsMarker();
    marker = googleMapControllers.getStatusMarker;
    if (!marker)
      googleMapControllers.removeMarkerByLayer();
    else
      await googleMapControllers.generateAllMarker();
    commit();
  }
  
  Future<void> setStatusCircle() async {
    googleMapControllers.changeIsCircle();
    circle = googleMapControllers.getStatusCircle;
    if (!circle)
      googleMapControllers.removeCricleByLayer();
    else
      await googleMapControllers.generateAllCircle();
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
