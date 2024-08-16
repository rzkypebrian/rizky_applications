import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/model/tmsVehicleCheckDocument.dart';
import 'package:enerren/module/driverAbsent/view.dart';
import 'package:flutter/material.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final TmsVehicleCheckDocument tmsVehicleCheckDocument;

  const Presenter({Key key, this.view, this.tmsVehicleCheckDocument})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  RatingController ratingController = RatingController();
  TmsVehicleCheckDocument tmsVehicleCheckDocument;
  @override
  void initState() {
    tmsVehicleCheckDocument = widget.tmsVehicleCheckDocument;
    ratingController.setRating(tmsVehicleCheckDocument.driverRating);
    super.initState();
  }
}
