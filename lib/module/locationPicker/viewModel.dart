import 'package:flutter/material.dart';
import 'package:enerren/model/LocationModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewModel extends ChangeNotifier {
  TextEditingController searchBoxController = new TextEditingController();
  bool openSearchResult = false;
  LocationModel selectedLocation = new LocationModel();

  List<LocationModel> locationHistory = [];
  LatLng selectedLatlong;
  String placeId;

  void commit() {
    notifyListeners();
  }
}
