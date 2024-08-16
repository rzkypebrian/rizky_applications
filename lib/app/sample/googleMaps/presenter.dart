import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart'; 
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;

  const Presenter({
    Key key,
    this.view,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  ViewModel model = new ViewModel();

  @override
  void initState() {
    super.initState();
  }

  void startPolygon() {
    model.setStatusPolygonv();
  }

  void startPolyline() {
    model.setStatusPolylinev();
  }

  void startMarker() {
    model.setStatusMarker();
  }
  
  void startCircle() {
    model.setStatusCircle();
  }

  void moveCamera() {
    model.googleMapControllers.gotoPosition(
        latLng: LatLng(-6.237794440952584, 106.50637831538916), zoom: 10);
  }
  
}
