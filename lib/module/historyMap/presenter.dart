import 'dart:async';

import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsValue.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int vehicleIdVts;
  final String markerOnEngineOn;
  final String markerOnEngineOff;
  final int markerSize;
  final MarkerIconType markerIconType;
  final DateTime fromDate;
  final DateTime toDate;

  const Presenter({
    Key key,
    this.view,
    this.vehicleIdVts,
    this.fromDate,
    this.toDate,
    this.markerOnEngineOn,
    this.markerIconType,
    this.markerOnEngineOff,
    this.markerSize,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter>
    with SingleTickerProviderStateMixin {
  ViewModel model = ViewModel();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  GoogleMapsControllers googleMapControllers = GoogleMapsControllers(
    GoogleMapValue(
        zoom: 18,
        primaryIcon: "assets/live_track_truck.png",
        secondaryIcon: "assets/live_track_truck.png",
        primaryColor: System.data.colorUtil.primaryColor),
  );

  PageController pageController = new PageController();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: model.lengthTab, vsync: this)
      ..addListener(() {
        model.currentIndexTab = tabController.index;
        model.commit();
      });
    loadingController.stopLoading();
    getHistory();
  }

  void getHistory() {
    loadingController.startLoading();
    ModeUtil.debugPrint(
        "${widget.vehicleIdVts} ${widget.fromDate} ${widget.toDate}");
    VtsPositionModel.get(
      vehicleId: widget.vehicleIdVts,
      startDate: widget.fromDate,
      toDate: widget.toDate,
    ).then((onValue) {
      model.listVtsPositionModel = onValue;
      if (model.listVtsPositionModel.length > 0) {
        readPoint(0);
        model.isLoaded = true;
        model.boxHeight = 130;
        model.commit();
        loadingController.stopLoading();
      } else {
        loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
                message: "${System.data.resource.noHistoryFound}"));
      }
      model.commit();
    }).catchError((onError) {
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError)));

      model.commit();
    });
  }

  void openInfoBox() {
    model.detailBoxInfoHeight = 300;
    model.infoBoxStatus = true;
    model.commit();
  }

  void closeInfoBox() {
    model.detailBoxInfoHeight = 30;
    model.infoBoxStatus = false;
    model.commit();
  }

  void togleInfoBox() {
    if (model.infoBoxStatus == true) {
      closeInfoBox();
    } else {
      openInfoBox();
    }
  }

  void detailHistory() {
    model.detail = !model.detail;
    model.iconDetail = model.detail
        ? FontAwesomeLight(FontAwesomeId.fa_chevron_double_down)
        : FontAwesomeLight(FontAwesomeId.fa_chevron_double_up);
    model.boxHeight = model.detail ? 380 : 130;
    model.commit();
  }

  void play() async {
    model.startTimer = !model.startTimer;
    model.duration = Duration(milliseconds: 1000);

    if (!model.startTimer) {
      model.timer.cancel();
      model.commit();
    } else {
      if (model.startTimer) {
        timers();
      }
      if (model.currentIndex == model.maxSlider) {
        movePrevious(0);
      }
    }
  }

  void timers() {
    model.timer = Timer.periodic(model.duration, (t) {
      model.currentIndex++;
      if (model.currentIndex == model.totalListAll) {
        model.startTimer = false;
        model.currentIndex = model.maxSlider;
        model.timer.cancel();
        model.commit();
      }
      ModeUtil.debugPrint("play ${model.currentIndex} ${model.totalListAll}");
      if (model.currentIndex != 0) {
        readPoint(model.currentIndexInt);
      }
      model.commit();
    });
  }

  void readPoint(int index, {bool moveCamera = true, updateMarker = true}) {
    googleMapControllers.addPoint(
      // markerId: model.listVtsPositionModel[index].vehicleId.toString(),
      animateCamera: moveCamera,
      createMarker: updateMarker,
      pointData: ObjectData(
          markerIconType: widget.markerIconType ?? MarkerIconType.Asset,
          markerIcon: model.listVtsPositionModel[index].engine == 1
              ? widget.markerOnEngineOn ?? "assets/live_track_truck_on.png"
              : widget.markerOnEngineOff ?? "assets/live_track_truck.png",
          iconSize: widget.markerSize,
          address: model.listVtsPositionModel[index].streetName,
          latLng: LatLng(model.listVtsPositionModel[index].lat,
              model.listVtsPositionModel[index].lon),
          name: model.listVtsPositionModel[index].vehicleName,
          flat: true,
          dateTime: model.listVtsPositionModel[index].dateTime,
          rotation: model.listVtsPositionModel[index].course,
          markerId: model.listVtsPositionModel[index].vehicleId.toString()),
    );
  }

  void moveNext(int index) {
    model.startTimer = false;
    try {
      model.timer.cancel();
    } catch (e) {}

    if (index > model.currentIndexInt) {
      for (var i = model.currentIndexInt; i < index; i++) {
        readPoint(
          i,
          moveCamera: i + 1 < index ? false : true,
          updateMarker: i + 1 < index ? false : true,
        );
      }
    }

    model.currentIndex = index.toDouble();
    model.commit();
  }

  void movePrevious(int index) {
    model.startTimer = false;
    try {
      model.timer.cancel();
    } catch (e) {}

    for (int i = model.currentIndexInt; i > index; i--) {
      googleMapControllers.removeLastPoint(
        markerId: model.listVtsPositionModel[i].vehicleId.toString(),
        createMarkerOnLastPolyLine: i - 1 > index ? false : true,
        animateCamera: i - 1 > index ? false : true,
      );
    }

    model.currentIndex =
        googleMapControllers.totalPointPolyline().toDouble() - 1;
    model.commit();
  }

  void ontapTabView(int indexx) {
    model.currentIndexTab = indexx;
    model.commit();
  }

  void changeTrafic() {
    model.showTrafic = googleMapControllers.trafficEnabled();
    model.commit();
  }
}
