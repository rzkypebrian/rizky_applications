import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsValue.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  GoogleMapsControllers mapControllers =
      new GoogleMapsControllers(GoogleMapValue(
    primaryIcon: "assets/icon_cone.png",
    secondaryIcon: "assets/icon_cone.png",
  ));
  int layerForDrawing = 0;

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  void commit() {
    notifyListeners();
  }
}
