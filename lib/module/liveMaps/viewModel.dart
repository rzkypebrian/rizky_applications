import 'package:enerren/component/customeGoogleMap/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsValue.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/googleService/GoogleGeocoderModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  VtsPositionModel currentPoition = VtsPositionModel();
  GoogleMapsControllers googleMapsControllers = GoogleMapsControllers(
    GoogleMapValue(
      primaryIcon: "assets/live_track_truck.png",
      secondaryIcon: "assets/live_track_truck.png",
      zoom: 13,
    ),
  );
  bool isTrafic = false;
  bool isFollowVehicle = true;
  GoogleGeocoderModel googleGeocoderModel = new GoogleGeocoderModel();
  List<ObjectData> destination = [];

  ViewModel();

  void commit() {
    notifyListeners();
  }

  void dummy() {}
}
