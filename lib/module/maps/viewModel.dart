import 'package:enerren/component/customeGoogleMap/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsValue.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  GoogleMapsControllers mapsControllers =
      new GoogleMapsControllers(GoogleMapValue(
    primaryIcon: "assets/live_track_truck.png",
    secondaryIcon: "assets/live_track_truck.png",
    // polyLineSetting: [
    //   false,
    // ],
  )
          // ..polyLineSetting[0] = false,
          );

  List<VtsPositionModel> positions = [];
  List<VtsPositionModel> filteredPositions = [];
  VtsPositionModel selected;

  bool isTrafic = false;

  void commit() {
    notifyListeners();
  }
}
