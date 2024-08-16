import 'package:enerren/model/tmsShipmentHistory.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final List<TmsShipmentHistory> data;
  final String shipmentNumber;
  final VoidCallback onTapLiveMap;
  final VoidCallback onTapDetailShipment;
  final bool showButtonMap;

  const Presenter({
    Key key,
    this.view,
    this.data,
    this.onTapLiveMap,
    this.shipmentNumber,
    this.onTapDetailShipment,
    this.showButtonMap = true,
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
  ViewModel model = new ViewModel();

  @override
  void initState() {
    super.initState();
    model.data = widget.data;
    model.shipmentNumber = widget.shipmentNumber;
    model.commit();
  }

  void liveMaps() {
    if (widget.onTapLiveMap != null) {
      widget.onTapLiveMap();
    } else {
      ModeUtil.debugPrint("LiveMap");
    }
  }

  void onTapDeatilShipment() {
    if (widget.onTapDetailShipment != null) {
      widget.onTapDetailShipment();
    }
  }
}
