import 'dart:async';

import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<List<LatLng>> onTapSetGeofence;
  final int layer;

  Presenter({
    Key key,
    this.layer = 0,
    this.view,
    this.onTapSetGeofence,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view == null) {
      return View();
    } else {
      return view;
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();

  @override
  void initState() {
    // getMyLocation();
    model.layerForDrawing = widget.layer;
    super.initState();
    model.loadingController.stopLoading();
    Timer.periodic(Duration(seconds: 1), (t) {
      if (model.mapControllers.isMapReady) {
        getMyLocation();
        t.cancel();
      }
    });
  }

  void getMyLocation() {
    GeolocatorUtil.myLocation().then((value) {
      model.mapControllers.newCameraPosition(
        latLng: LatLng(value.latitude, value.longitude),
        zoom: 13,
      );
    }).catchError((onError) {
      //
    });
  }

  void onTap(LatLng latLng) {
    model.mapControllers.addPoint(
      showPolygon: true,
      showPolyLine: false,
      circleFillColor: Colors.red.withOpacity(0.4),
      layer: model.layerForDrawing,
      polygonFillColor: System.data.colorUtil.primaryColor.withOpacity(0.3),
      pointData: new ObjectData(
        latLng: latLng,
        flat: false,
      ),
    );
  }

  void remove() {
    model.mapControllers.removeLastPoint(
      layer: model.layerForDrawing,
      createMarkerOnLastPolyLine: false,
    );
  }

  void setGeofence() {
    List<ObjectData> _validLatLng = model
        .mapControllers.value.point[model.layerForDrawing]
        .where((e) => e.latLng != null)
        .toList();

    if (_validLatLng.length < 3) {
      model.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: "${System.data.resource.pleaseSpecifyAtLeast2Points}",
        ),
      );
    }

    if (widget.onTapSetGeofence != null) {
      widget.onTapSetGeofence(
          List.generate(_validLatLng.length, (i) => _validLatLng[i].latLng));
    } else {
      ModeUtil.debugPrint(
          List.generate(_validLatLng.length, (i) => _validLatLng[i].latLng)
              .toString());
    }
  }
}
