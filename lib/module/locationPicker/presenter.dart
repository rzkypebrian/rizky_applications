import 'dart:async';

import 'package:enerren/component/customeGoogleMap/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsValue.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/main.dart';
import 'package:enerren/model/LocationModel.dart';
import 'package:enerren/model/googleService/GooglePlaceModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
// import 'package:geolocator/geolocator.dart';

import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final bool showCneterGuidPoint;
  final LatLng center;
  final ValueChanged<LocationModel> onPickLocation;
  final bool useCurrentLocation;

  Presenter({
    this.view,
    this.center,
    this.showCneterGuidPoint = false,
    this.onPickLocation,
    this.useCurrentLocation,
  });

  @override
  State<StatefulWidget> createState() {
    if (this.view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();
  LatLng center;
  GoogleMapsControllers googleMapControllers = GoogleMapsControllers(
    GoogleMapValue(
      primaryIcon: "assets/angkut/marker_red.png",
      secondaryIcon: "assets/angkut/marker_dot_blue.png",
    ),
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (t) {
      if (googleMapControllers.isMapReady) {
        if (widget.useCurrentLocation == true && widget.center == null) {
          GeolocatorUtil.myLocation().then((onValue) {
            print("mylocation ${onValue.latitude}, ${onValue.longitude}");
            googleMapControllers.newCameraPosition(
              latLng: LatLng(
                onValue.latitude,
                onValue.longitude,
              ),
              zoom: 12,
            );
          }).catchError((onError) {
            print(onError);
          });
        }
        t.cancel();
      }
    });
  }

  void closeSearchHistory() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      model.openSearchResult = false;
      model.commit();
    });
  }

  void openSearchHistory() {
    setState(() {
      model.openSearchResult = true;
      model.commit();
    });
  }

  void onUpdateMap(LatLng latLng) {
    GeolocatorUtil.getLocation(latLng.latitude, latLng.longitude).then(
      (onValue) {
        model.selectedLocation = LocationModel(
          address: GeolocatorUtil.changeToAddress(onValue),
          addressLabel: "",
          propinsi: onValue.administrativeArea.trim(),
          kecamatan: onValue.locality.trim(),
          kabupaten: onValue.subLocality.trim(),
          lat: onValue.position.latitude,
          lon: onValue.position.longitude,
        );
        model.searchBoxController.text =
            "${GeolocatorUtil.changeToAddress(onValue)}";
        model.commit();
      },
    ).catchError((onError) {});
  }

  void gotoPosition() {
    closeSearchHistory();
    // Geolocator()
    //     .placemarkFromAddress(model.searchBoxController.text)
    //     .then((onValue) {
    //   model.selectedLatlong = LatLng(
    //       onValue.first.position.latitude, onValue.first.position.longitude);
    model.commit();
    onUpdateMap(model.selectedLatlong);
    googleMapControllers.newCameraPosition(
      latLng: model.selectedLatlong,
      zoom: 15,
    );
    // }).catchError((onError) {
    //   ModeUtil.debugPrint(onError.toString());
    // });
  }

  void gotoPositionByPlaceId() {
    GooglePlaceModel.getByPlaceId(
            placeId: model.placeId, apiKey: System.data.global.googleMapApiKey)
        .then((value) {
      model.selectedLatlong =
          LatLng(value.geometry.location.lat, value.geometry.location.lon);
      gotoPosition();
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError,
                prefix: "Error getting location from place id"),
          ),
        );
      },
    );
  }

  void pickLocation() {
    LatLng _latlong =
        LatLng(model.selectedLocation.lat, model.selectedLocation.lon);
    if (widget.onPickLocation != null) {
      ModeUtil.debugPrint(model.selectedLocation.lat);
      if (_latlong != null) {
        widget.onPickLocation(model.selectedLocation);
      }
    } else {
      ModeUtil.debugPrint(model.selectedLocation?.toJson());
    }
  }
}
