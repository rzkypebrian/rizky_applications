import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/googleService/GoogleGeocoderModel.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/module/liveMaps/presenter.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ViewModelLiveMap.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';

mixin AngkutPresenter on PresenterState {
  ViewModeliveMap viewModeliveMap = ViewModeliveMap();
  ValueChanged<ViewModeliveMap> onTapPickup;
  ValueChanged2Param<ViewModeliveMap, int> onTapFinish;
  int currentStatus = 0;
  String confirmStartIlustrationAssets;

  bool get isEmergency {
    return viewModeliveMap
        .angkutShipmentModel.tmsShipmentDestinationList.first.emergencyData
        .any((e) =>
            e.driverId == System.data.getLocal<LocalData>().user.driverId &&
            e.emergencyStatus == 1);
  }

  LatLng get pickupLocation {
    LatLng _pickupLocation = LatLng(
        viewModeliveMap
            .angkutShipmentModel.tmsShipmentDestinationList.first.originLat,
        viewModeliveMap
            .angkutShipmentModel.tmsShipmentDestinationList.first.originLong);
    TmsDeliveryEmergencyModel _currentEmergency = viewModeliveMap
        .angkutShipmentModel
        .tmsShipmentDestinationList
        .first
        .getCurrentEmergency;
    int _lastShipmentStatus = _currentEmergency?.lastShipmentStatus ?? null;

    if (isEmergency == false) {
      if (_lastShipmentStatus == 7) {
        _pickupLocation = LatLng(
            _currentEmergency.emergencyLat, _currentEmergency.emergencyLon);
      }
    }

    return _pickupLocation;
  }

  LatLng get getMapLocationDirection {
    if (viewModeliveMap.angkutShipmentModel.shipmentStatusId == 7) {
      return LatLng(
          viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList.first
              .destinationLat,
          viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList.first
              .destinationLong);
    } else {
      return pickupLocation;
    }
  }

  @override
  void initState() {
    super.initState();
    viewModeliveMap.loadingController.stopLoading();
    getShipment();
  }

  void ontapStart() {
    Navigator.of(context).pop();

    viewModeliveMap.loadingController.startLoading();
    ModeUtil.debugPrint("${viewModeliveMap.angkutShipmentModel.tmsShipmentId}");

    VtsPositionModel.getVehiclePosition(
      vehicleId: widget.vehicleId,
    ).then((onValue) {
      AngkutShipmentModel.pickupOrder(
        token: System.data.global.token,
        driverId: viewModeliveMap
            .angkutShipmentModel.tmsShipmentDestinationList.first.driverId,
        shipmentId: viewModeliveMap.angkutShipmentModel.tmsShipmentId,
        vehicleLat: onValue.lat,
        vehicleLon: onValue.lon,
        vehicleOdometer: onValue.odometer,
      ).then((onValue) {
        viewModeliveMap.angkutShipmentModel = onValue;
        viewModeliveMap.commit();
        ModeUtil.debugPrint("selesai");
      }).whenComplete(() {
        viewModeliveMap.loadingController.stopLoading();
      }).catchError((onError) {});
    }).catchError((onError) {});
  }

  void onFinish() {
    // viewModeliveMap.angkutShipmentModel.shipmentStatusId = 3;
    // viewModeliveMap.commit();
    showBottonDo();
  }

  void showBottonDo() {
    ModalComponent.bottomModalWithCorner(context,
        child: Container(
          height: 234,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      SvgPicture.asset("assets/angkut/edit_order.svg"),
                      Text(
                        "${System.data.resource.pleaseCheckTheDODeliveryOrderFormAndSenderPhoto}",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: BottonComponent.roundedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onTapFinish != null) {
                            //untuk pod bebeas
                            // onTapFinish(
                            //     viewModeliveMap, viewModeliveMap.starPage);
                            //untuk pod berurut
                            onTapFinish(
                                viewModeliveMap,
                                getNextPodDestinationOrderNumber(
                                        getNextDestinationId()) -
                                    1);
                          }
                        },
                        radius: 0,
                        textstyle: System.data.textStyleUtil.mainTitle(),
                        text: "${System.data.resource.ok}")),
              )
            ],
          ),
        ));
  }

  TmsShipmentDestinationModel getNextDestination() {
    var a = viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList
        .where((a) => a.detailStatus == 7)
        .toList();

    if (a.isNotEmpty) {
      return a.first;
    } else {
      return null;
    }
  }

  int getNextDestinationId() {
    var a = viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList
        .where((a) => a.detailStatus == 7)
        .toList();

    if (a.isNotEmpty) {
      return a[0].detailshipmentId;
    } else {
      return 0;
    }
  }

  int getNextPodDestinationOrderNumber(int destinationId) {
    for (var i = 0;
        i <
            viewModeliveMap
                .angkutShipmentModel.tmsShipmentDestinationList.length;
        i++) {
      if (viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList[i]
              .detailshipmentId ==
          destinationId) {
        return i + 1;
      }
    }
    return 0;
  }

  void confirmStartButton() {
    ModalComponent.bottomModalWithCorner(
      context,
      child: Container(
        height: 234,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Container(
                      child: SvgPicture.asset(confirmStartIlustrationAssets ??
                          "assets/angkut/boxCar.svg")),
                  Column(
                    children: <Widget>[
                      Text(
                        "${System.data.resource.areYouSureWantToPickupRightNow}",
                        textAlign: TextAlign.center,
                        style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Divider(
                height: 20,
                color: System.data.colorUtil.primaryColor,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 46,
                // color: System.data.colorUtil.primaryColor,
                color: Colors.red,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: ontapStart,
                        child: Container(
                          color: System.data.colorUtil.primaryColor,
                          child: Center(
                            child: Text(
                              "${System.data.resource.yes}",
                              style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.secondaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: System.data.colorUtil.secondaryColor,
                          child: Center(
                            child: Text(
                              "${System.data.resource.no}",
                              style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void cancleEmergency() {
    super.bottomSheetController.less();
    super.mapLoadingController.startLoading();
    TmsDeliveryEmergencyModel.rejectEmergency(
      reasonDesc: "",
      shipmentId: viewModeliveMap.angkutShipmentModel.tmsShipmentId,
      token: System.data.global.token,
    ).then((onValue) {
      viewModeliveMap.angkutShipmentModel =
          AngkutShipmentModel.fromJson(onValue);
      viewModeliveMap.commit();
      super.model.commit();
      super.mapLoadingController.stopLoading();
    }).catchError(
      (onError) {
        mapLoadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError),
            ));
      },
    );
  }

  @override
  void onReceiveNewPosition(VtsPositionModel positionModel) {
    if (currentStatus != viewModeliveMap.angkutShipmentModel.shipmentStatusId) {
      currentStatus = viewModeliveMap.angkutShipmentModel.shipmentStatusId;
      drawRoute(
          null,
          LatLng(getNextDestination().destinationLat,
              getNextDestination().destinationLong),
          null);
    }
  }

  void drawRoute(LatLng origin, LatLng destination, List<LatLng> wayPoint) {
    LatLng origin = pickupLocation;

    destination = destination != null
        ? destination
        : LatLng(
            viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList.first
                .destinationLat,
            viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList.first
                .destinationLong);

    //jika statusnya pickup
    if (viewModeliveMap.angkutShipmentModel.shipmentStatusId == 4) {
      origin = LatLng(model.currentPoition.lat, model.currentPoition.lon);
      destination = pickupLocation;
    }

    //jika statusnya delivery
    if (viewModeliveMap.angkutShipmentModel.shipmentStatusId == 7) {
      origin = LatLng(model.currentPoition.lat, model.currentPoition.lon);
      // destination = LatLng(
      //     viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList.first
      //         .destinationLat,
      //     viewModeliveMap.angkutShipmentModel.tmsShipmentDestinationList.first
      //         .destinationLong);
    }

    model.googleMapsControllers.removeLayer(layer: 3);
    GoogleGeocoderModel.getRouteFromPositiom(
      origin: origin,
      destination: destination,
      apiKey: System.data.global.googleMapApiKey,
    ).then((value) {
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

  Future<void> getShipment() {
    viewModeliveMap.loadingController.startLoading();
    return AngkutShipmentModel.getAll(
      shipmentId: viewModeliveMap.angkutShipmentModel.tmsShipmentId,
      limit: 1,
      token: System.data.global.token,
    ).then(
      (value) {
        viewModeliveMap.angkutShipmentModel = value.first;
        viewModeliveMap.loadingController.stopLoading();
        viewModeliveMap.commit();
      },
    ).catchError(
      (onError) {
        viewModeliveMap.loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }
}
