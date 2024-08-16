import 'dart:async';

import 'package:enerren/component/bottomDockComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'view.dart';
import 'viewModel.dart';
import 'package:enerren/util/StringExtention.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int userId;
  final String token;
  final bool showMarkerLabel;

  Presenter({
    this.view,
    this.showMarkerLabel = true,
    @required this.userId,
    @required this.token,
  });

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
  ViewModel model = new ViewModel();
  String markerSelectedIcon = "assets/selected_marker.png";
  EdgeInsetsGeometry bottomSheetContentPadding;
  double bottomSheetHeight = 300;
  BottomDockComponentController bottomSheetController =
      new BottomDockComponentController();
  DateTime lastDate;
  Timer trackingTimer;
  CircularProgressIndicatorController mapLoadingController =
      new CircularProgressIndicatorController();
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (t) {
      if (model.mapsControllers.isMapReady) {
        getAllPosition(true);
        // Timer.periodic(Duration(seconds: 3), (c) {
        //   getAllPosition(false);
        // });
        t.cancel();
      }
    });
  }

  Future<void> getAllPosition(bool isFirst) async {
    if (!mounted) return;
    return VtsPositionModel.getAllPotition(
      userId: widget.userId,
      token: widget.token,
    ).then((onValue) {
      onReceivedDataPosition(onValue, isFirst);
      Timer.periodic(Duration(seconds: System.data.global.intervalUpdateMaps),
          (t) {
        getAllPosition(false);
        t.cancel();
      });
    }).catchError((onError) {
      ModeUtil.debugPrint(onError);
    });
  }

  void onReceivedDataPosition(
      List<VtsPositionModel> onValue, bool isFirst) async {
    model.positions = onValue;
    await onFilteredPosition();
    onCreateAllPositionMarker(isFirst);
  }

  Future<void> onFilteredPosition() async {
    model.filteredPositions = model.positions;
    model.commit();
  }

  void onCreateAllPositionMarker(bool first) async {
    for (var i = 0; i < model.filteredPositions.length; i++) {
      try {
        ObjectData _firstData = onCreateFirstData(model.filteredPositions[i]);

        //_label marker
        ObjectData _markerLabel = widget.showMarkerLabel
            ? onCreateMarkerLabel(model.filteredPositions[i])
            : null;

        //_second data
        ObjectData _secondData = onCreateSecondData(model.filteredPositions[i]);

        if (first == true) {
          await model.mapsControllers.addPoint(
            layer: 0,
            showPolyLine: false,
            // markerId: model.filteredPositions[i].vehicleId.toString(),
            animateCamera: i < model.filteredPositions.length - 1
                ? false
                : first
                    ? true
                    : false,
            createMarker: true,
            patern: [],
            pointData: _firstData,
          );

          if (widget.showMarkerLabel && _markerLabel != null) {
            await model.mapsControllers.addPoint(
              layer: 0,
              showPolyLine: false,
              // markerId: model.filteredPositions[i].vehicleId.toString(),
              animateCamera: false,
              createMarker: true,
              patern: [],
              pointData: _markerLabel,
            );
          }

          if (_secondData != null) {
            await model.mapsControllers.addPoint(
              layer: 0,
              showPolyLine: false,
              // markerId: model.filteredPositions[i].vehicleId.toString(),
              animateCamera: false,
              createMarker: true,
              patern: [],
              pointData: _secondData,
            );
          }

          mapLoadingController.stopLoading();
          onFirstDraw();
        } else {
          if (model.mapsControllers.checkMarkerid(
            layer: 0,
            markerId: model.filteredPositions[i].vehicleId.toString(),
          )) {
            ObjectData _objectData = model.mapsControllers.value.point[0]
                .where((f) => f.id == model.filteredPositions[i].vehicleId)
                .first;
            int _index =
                model.mapsControllers.value.point[0].indexOf(_objectData);
            await model.mapsControllers.editPoint(
              layer: 0,
              index: _index,
              showPolyLine: false,
              // markerId: model.filteredPositions[i].vehicleId.toString(),
              animateCamera: false,
              createMarker: true,
              patern: [],
              pointData: _firstData,
            );

            if (_markerLabel != null && widget.showMarkerLabel) {
              ObjectData _markerLabelData = model.mapsControllers.value.point[0]
                  .where((f) => f.id == _markerLabel.id)
                  .first;
              int _index = model.mapsControllers.value.point[0]
                  .indexOf(_markerLabelData);
              await model.mapsControllers.editPoint(
                layer: 0,
                index: _index,
                showPolyLine: false,
                // markerId: model.filteredPositions[i].vehicleId.toString(),
                animateCamera: false,
                createMarker: true,
                patern: [],
                pointData: _markerLabel,
              );
            }

            if (_secondData != null) {
              ObjectData _objectData2 = model.mapsControllers.value.point[0]
                  .where((f) => f.id == _secondData.id)
                  .first;
              int _index =
                  model.mapsControllers.value.point[0].indexOf(_objectData2);
              await model.mapsControllers.editPoint(
                layer: 0,
                index: _index,
                showPolyLine: false,
                // markerId: model.filteredPositions[i].vehicleId.toString(),
                animateCamera: false,
                createMarker: true,
                patern: [],
                pointData: _secondData,
              );
            }
          }
        }
      } catch (e) {
        ModeUtil.debugPrint(e);
        ModeUtil.debugPrint("error ke $i");
      }
    }
    if (model.selected != null) {
      model.selected = model.filteredPositions
          .where((f) => f.vehicleId == model.selected.vehicleId)
          .first;
      createSelectedMarker(model.selected);
    }
  }

  void createSelectedMarker(VtsPositionModel selected,
      {bool moveCamera = false, int iconSize}) {
    ObjectData _data = ObjectData(
      latLng: LatLng(selected.lat, selected.lon),
      rotation: selected.course,
      markerIcon: "$markerSelectedIcon",
      iconSize: iconSize ?? (selected.iconSize ?? 50) * 3,
      markerIconType: MarkerIconType.Asset,
      anchor: Offset(0.5, 0.5),
      markerId: "selected",
    );
    if (model.mapsControllers.getListPoint[1].length <= 0) {
      model.mapsControllers.addPoint(
        layer: 1,
        // markerId: "selected",
        showPolyLine: false,
        createMarker: true,
        animateCamera: moveCamera,
        pointData: _data,
      );
    } else {
      model.mapsControllers.editPoint(
        layer: 1,
        index: 0,
        // markerId: "selected",
        showPolyLine: false,
        animateCamera: moveCamera,
        createMarker: true,
        pointData: _data,
      );
    }
  }

  ObjectData onCreateMarkerLabel(VtsPositionModel poition) {
    return ObjectData(
      id: poition.vehicleId,
      latLng: LatLng(poition.lat, poition.lon),
      rotation: 0,
      markerIcon: poition.vehicleName,
      markerIconType: MarkerIconType.Text,
      iconSize: poition.iconSize,
      anchor: Offset(0.5, -2.3),
      markerId: poition.vehicleId.toString() + "_label",
      flat: false,
      onTapMarker: () {
        model.selected = poition;
        model.commit();
        createSelectedMarker(model.selected);
        onTapMarker();
      },
    );
  }

  ObjectData onCreateFirstData(VtsPositionModel poition) {
    return ObjectData(
      id: poition.vehicleId,
      latLng: LatLng(poition.lat, poition.lon),
      rotation: poition.course,
      markerIcon: onCreatePositionMarkerIcon(poition),
      markerIconType: poition.imageIconUrl.isNullOrEmpty()
          ? MarkerIconType.Asset
          : MarkerIconType.Network,
      iconSize: poition.iconSize,
      anchor: Offset(0.5, 0.5),
      markerId: poition.vehicleId.toString(),
      onTapMarker: () {
        model.selected = poition;
        model.commit();
        createSelectedMarker(model.selected);
        onTapMarker();
      },
    );
  }

  ObjectData onCreateSecondData(VtsPositionModel poition) {
    return null;
  }

  void setTrafic(bool value) {
    model.isTrafic = value;
    model.commit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapMarker() {
    ModeUtil.debugPrint("marker tapped");
  }

  void onFirstDraw() {
    //
  }

  String onCreatePositionMarkerIcon(VtsPositionModel vtsPositionModel) {
    return vtsPositionModel.imageIconUrl.isNullOrEmpty()
        ? null
        : vtsPositionModel.imageIconUrl;
  }
}
