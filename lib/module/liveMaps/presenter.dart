import 'dart:async';

import 'package:enerren/component/bottomDockComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/googleService/GoogleGeocoderModel.dart';
import 'package:enerren/util/DateTimeUtil.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int vehicleId;
  //setting for marker
  //1 standart marker
  final String vehicleIconTopUrl;
  final MarkerIconType vehicleIconTopType;
  final int vehicleIconTopSize;
  //2 delay marker
  final bool usingDelayedMarker;
  final String vehicleIconTopUrlIfDelay;
  final MarkerIconType vehicleIconTopTypeIfDelay;
  final int delayedDurationLimitInMinutes;
  //----
  final DateTime fromDate;
  final DateTime toDate;
  final bool liveTrack;
  final List<ObjectData> destination;
  final bool usingLastPositionOnEmpty;
  final bool folowTheVehicle;
  final bool showHistoryLine;
  final bool isExpandBottomDock;
  final bool drawRoute;

  const Presenter({
    Key key,
    this.view,
    @required this.vehicleId,
    @required this.fromDate,
    this.destination,
    this.vehicleIconTopUrl,
    this.vehicleIconTopType,
    this.vehicleIconTopSize,
    this.usingLastPositionOnEmpty = true,
    this.folowTheVehicle = true,
    this.showHistoryLine = false,
    this.isExpandBottomDock = false,
    this.usingDelayedMarker = false,
    this.vehicleIconTopUrlIfDelay = "assets/vehilcle_delay_level1.png",
    this.vehicleIconTopTypeIfDelay = MarkerIconType.Asset,
    this.delayedDurationLimitInMinutes = 5,
    this.toDate,
    this.liveTrack = true,
    this.drawRoute = false,
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
  ViewModel model = ViewModel();
  EdgeInsetsGeometry bottomSheetContentPadding;
  double bottomSheetHeight = 300;
  BottomDockComponentController bottomSheetController =
      new BottomDockComponentController();
  DateTime lastDate;
  CircularProgressIndicatorController mapLoadingController =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    readDestination();
    Timer.periodic(Duration(seconds: 1), (t) {
      if (model.googleMapsControllers.isMapReady) {
        initViewModel();
        mapLoadingController.startLoading();
        createMarkerDestination();
        getPositionHistory(
          fromDate: widget.fromDate,
        );
        t.cancel();
      }
    });
    if (widget.isExpandBottomDock) {
      bottomSheetController.expand();
    }
  }

  void initViewModel() {
    model.isFollowVehicle = widget.folowTheVehicle ?? true;
    model.commit();
  }

  void readDestination() async {
    model.destination = widget.destination ?? [];
    model.commit();
  }

  Future<void> getPositionHistory({
    bool isUpdate = false,
    @required DateTime fromDate,
  }) async {
    if (!mounted) {
      return;
    }
    if (widget.vehicleId == null) {
      mapLoadingController.stopLoading();
      return;
    }
    await VtsPositionModel.get(
      vehicleId: widget.vehicleId,
      startDate: fromDate,
      toDate: widget.toDate ?? DateTime.now(),
      showLastPotionOnEmpty: widget.usingLastPositionOnEmpty,
    ).then((onValue) {
      if (onValue.length == 0) {
        mapLoadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
                message: "${System.data.resource.vehiclePositionNotFound}"));
      } else {
        print(
            "jumlah posisi terakhir $fromDate ${DateTime.now()} result ${onValue.length}");
        if (isUpdate && onValue.length > 0) {
          removeMarker((model.googleMapsControllers.getListPoint[0].length - 1)
              .toString());
        }
        for (var i = 0; i < onValue.length; i++) {
          try {
            model.googleMapsControllers.addPoint(
              layer: 0,
              showPolyLine: widget.showHistoryLine ?? true,
              // animateCamera: model.isFollowVehicle == true
              //     ? widget.liveTrack ? true : false
              //     : (isUpdate == true)
              //         ? false
              //         : (i < onValue.length - 1) ? false : true,
              // createMarker: onValue[i] == onValue.last ? true : false,
              // markerId: widget.vehicleId.toString(),
              animateCamera: false,
              createMarker: false,
              patern: [],
              pointData: new ObjectData(
                  latLng: LatLng(onValue[i].lat, onValue[i].lon),
                  rotation: onValue[i].course,
                  markerIcon: getMarkerIcon(onValue[i]),
                  markerIconType: getMarkerIconType(onValue[i]),
                  iconSize: widget.vehicleIconTopSize,
                  zIndex: 0,
                  markerId: widget.vehicleId.toString(),
                  anchor: Offset(0.5, 0.5),
                  onTapMarker: () {}),
            );
            lastDate = onValue[i].dateTime;
            model.currentPoition = onValue[i];
          } catch (e) {
            ModeUtil.debugPrint("error ke $i");
          }
        }

        model.commit();
        if (widget.drawRoute == true) {
          drawRoute(
            LatLng(onValue.last.lat, onValue.last.lon),
            model.destination?.first?.latLng,
            List.generate(
              model.destination.length,
              (i) {
                return model.destination[i]?.latLng;
              },
            ),
          );
        }
        markerCurrentPosition(onValue.last);
        onReceiveNewPosition(onValue.last);
      }
      if (!isUpdate) mapLoadingController.stopLoading();
      if (widget.liveTrack) {
        Timer.periodic(Duration(seconds: System.data.global.intervalUpdateMaps),
            (t) {
          getPositionHistory(fromDate: lastDate, isUpdate: true);
          t.cancel();
        });
      }
    }).catchError((onError) {
      mapLoadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError)));
      if (!isUpdate) mapLoadingController.stopLoading();
      if (widget.liveTrack) {
        Timer.periodic(Duration(seconds: System.data.global.intervalUpdateMaps),
            (t) {
          getPositionHistory(fromDate: lastDate, isUpdate: true);
          t.cancel();
        });
      }
    });
  }

  void markerCurrentPosition(VtsPositionModel positionModel) {
    model.googleMapsControllers.removeLayer(layer: 1);
    model.googleMapsControllers.addPoint(
      layer: 1,
      showPolyLine: widget.showHistoryLine ?? true,
      animateCamera: widget.folowTheVehicle ? true : false,
      createMarker: true,
      patern: [],
      pointData: new ObjectData(
        latLng: LatLng(positionModel.lat, positionModel.lon),
        rotation: positionModel.course,
        markerIcon: getMarkerIcon(positionModel),
        markerIconType: getMarkerIconType(positionModel),
        iconSize: widget.vehicleIconTopSize,
        zIndex: 1,
        markerId: widget.vehicleId.toString(),
        anchor: Offset(0.5, 0.5),
      ),
    );
  }

  void removeMarker(String markerId) {
    model.googleMapsControllers.removeMarkerById(layer: 0, markerId: markerId);
    model.googleMapsControllers.commit();
  }

  void removePolyline() {
    model.googleMapsControllers.removePolylines(layer: 0);
    model.googleMapsControllers.commit();
  }

  void createMarkerDestination() {
    for (var i = 0; i < model.destination.length; i++) {
      var _pointData = model.destination[i];
      _pointData.zIndex = 2;
      _pointData.markerId = i.toString();
      model.googleMapsControllers.addPoint(
        layer: 2,
        animateCamera: i < model.destination.length - 1 ? true : false,
        createMarker: true,
        pointData: model.destination[i],
        showPolyLine: false,
        // markerId: i.toString(),
      );
    }
  }

  void setTrafic(bool value) {
    model.isTrafic = value;
    model.commit();
  }

  void setFollowVehicle(bool value) {
    model.isFollowVehicle = value;
    if (value == true) {
      model.googleMapsControllers.newCameraPosition(
        latLng: LatLng(model.currentPoition.lat, model.currentPoition.lon),
        zoom: 13,
      );
    }
    model.commit();
  }

  void onTaGotoMap() {
    ExternalLinkComponent.openGooleMap(
      lat: model.currentPoition.lat,
      lon: model.currentPoition.lon,
    );
  }

  void onReceiveNewPosition(VtsPositionModel positionModel) {
    ModeUtil.debugPrint("receive new position");
  }

  String getMarkerIcon(
    VtsPositionModel vtsPositionModel,
  ) {
    if (widget.usingDelayedMarker == false) {
      return getDefaultIconMarker();
    } else {
      if (DateTimeUtil.dateDiffWithNow(vtsPositionModel.dateTime).inMinutes >=
          widget.delayedDurationLimitInMinutes) {
        return widget.vehicleIconTopUrlIfDelay == null
            ? null
            : widget.vehicleIconTopUrlIfDelay;
      } else {
        return getDefaultIconMarker();
      }
    }
  }

  String getDefaultIconMarker() {
    return widget.vehicleIconTopUrl == null ? null : widget.vehicleIconTopUrl;
  }

  MarkerIconType getMarkerIconType(VtsPositionModel vtsPositionModel) {
    if (widget.usingDelayedMarker == false) {
      return getDefaultIconType(vtsPositionModel);
    } else {
      if (DateTimeUtil.dateDiffWithNow(vtsPositionModel.dateTime).inMinutes >=
          widget.delayedDurationLimitInMinutes) {
        return widget.vehicleIconTopTypeIfDelay == null
            ? widget.vehicleIconTopUrlIfDelay == null
                ? MarkerIconType.Asset
                : MarkerIconType.Network
            : widget.vehicleIconTopTypeIfDelay;
      } else {
        return getDefaultIconType(vtsPositionModel);
      }
    }
  }

  MarkerIconType getDefaultIconType(VtsPositionModel vtsPositionModel) {
    return widget.vehicleIconTopType == null
        ? widget.vehicleIconTopUrl == null
            ? MarkerIconType.Asset
            : MarkerIconType.Network
        : widget.vehicleIconTopType;
  }

  void drawRoute(LatLng origin, LatLng destination, List<LatLng> wayPoint) {
    model.googleMapsControllers.removeLayer(layer: 3);
    GoogleGeocoderModel.getRouteFromPositiom(
      origin: origin,
      destination: destination,
      apiKey: System.data.global.googleMapApiKey,
    ).then((value) {
      model.googleGeocoderModel = value;
      model.commit();
      if (value.routes.isNotEmpty)
        value.routes[0].overViewPolyline.forEach(
          (p) {
            model.googleMapsControllers.addPoint(
              layer: 3,
              showPolyLine: true,
              patern: <PatternItem>[
                PatternItem.dot,
              ],
              animateCamera: false,
              createMarker: false,
              pointData: ObjectData(
                latLng: LatLng(p.lat, p.lon),
              ),
            );
          },
        );
      // model.googleMapsControllers.bounds = LatLngBounds(
      //   northeast: LatLng(value.routes[0].bounds.northeast.lat,
      //       value.routes[0].bounds.northeast.lon),
      //   southwest: LatLng(value.routes[0].bounds.southwest.lat,
      //       value.routes[0].bounds.southwest.lon),
      // );
    }).catchError(
      (onError) {
        mapLoadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }

  // List<LatLng> getDistanceMatrix(LatLng origin, List<LatLng> destination) {

  // }
}
