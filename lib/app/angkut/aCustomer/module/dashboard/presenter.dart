import 'dart:async';

import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/app/angkut/model/VehicleCategory.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/main.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapModule;
  final ValueChanged2Param<ViewModel, int> onSelectLocation;
  final ValueChanged2Param<ViewModel, VehicleType> onSubmit;
  final VoidCallback onTapTrack;
  final VoidCallback onTapHistory;
  final VoidCallback onTapHelp;
  final VoidCallback onTapSetting;
  final VoidCallback onTapProfile;
  final VoidCallback onTapNotification;
  final VoidCallback onTapPriceSimulation;
  final ValueChanged<AngkutShipmentModel> onTapRatting;
  final bool useValidateIdenticalContact;
  final String pickUpAssetsIcon;
  final double pickUpWidthIcon;
  final bool useRating;
  final Color backgroundColor1;
  final Color backgroundColor2;

  const Presenter({
    Key key,
    this.view,
    this.onTapModule,
    this.onSelectLocation,
    this.onSubmit,
    this.onTapTrack,
    this.onTapHistory,
    this.onTapHelp,
    this.onTapSetting,
    this.onTapProfile,
    this.onTapNotification,
    this.onTapPriceSimulation,
    this.onTapRatting,
    this.useValidateIdenticalContact = true,
    this.pickUpAssetsIcon = "assets/angkut/box_angkut.svg",
    this.pickUpWidthIcon,
    this.useRating = true,
    this.backgroundColor1,
    this.backgroundColor2,
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
    with TickerProviderStateMixin {
  ViewModel model = new ViewModel();

  ScrollController scrollController = ScrollController();

  Curve curve = Curves.bounceOut;
  Duration duration = Duration(seconds: 1);
  double heightLocation = 105;

  bool addPoint = false;

  @override
  void initState() {
    super.initState();
    model.controller.stopLoading();
    init();
  }

  void init() {
    // GeolocatorUtil.myLocation.then((loc) async {
    //   String _ad = await getAdderes(loc.latitude, loc.longitude);
    //   _objectData = ObjectData(
    //     dateTime: DateTime.now(),
    //     address: _ad,
    //     latLng: google.LatLng(loc.latitude, loc.longitude),
    //   );
    //   model.googleMapControllers.addPoint(object: _objectData);
    // });
    getVehicle();
    startCheckShipmentNotyetRated();
    Timer.periodic(Duration(seconds: 1), (t) {
      if (model.googleMapControllers.isMapReady) {
        model.googleMapControllers.addPoint(
          pointData: ObjectData(),
          showPolyLine: false,
          showPolygon: false,
        );
        model.googleMapControllers.addPoint(
          pointData: ObjectData(),
          showPolyLine: false,
          showPolygon: false,
        );
        model.commit();
        t.cancel();
      }
    });
  }

  Future<String> getAdderes(double lat, double long) async {
    return await GeolocatorUtil.getAddress(lat, long);
  }

  void getVehicle() {
    model.controller.startLoading();
    model.finishTypeVehicle = false;
    model.commit();
    int _init = 0;
    VehicleCategory.getAllVehicleType(token: " ").then((onValue) {
      model.controller.stopLoading();
      _init = (onValue.length / 2).ceil() - 1;
      _init = (_init < 0) ? 0 : _init;
      model.vehicleCategory = onValue;
      model.selectedVehicleCategory = onValue[_init];
      model.selectedVehicleTypeList = onValue[_init].vehicleTypeList;
      model.typeController = new PageController(
        initialPage: _init,
        viewportFraction: 0.25,
      );
      model.finishTypeVehicle = true;
      model.commit();
    }).catchError((onError) {});
  }

  void addNewLocation() {
    if (model.googleMapControllers.value.point[0]
            .where((f) => f.latLng == null)
            .toList()
            .length >
        0) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: System
              .data.resource.pleaseDefineYourePickupAndDestinationLocation,
        ),
      );
      return;
    }
    model.heightInput = 160;
    addPoint = true;
    model.googleMapControllers.addPoint(
      pointData: ObjectData(),
      showPolyLine: false,
      showPolygon: false,
    );
    model.commit();
    maxScroll();
  }

  void startMaps() {
    model.alignmentTop = Alignment(0, -2);
    model.alignmentTop1 = Alignment(0, -2);
    model.alignmentBottom = Alignment(0, 4);
    model.commit();

    showVehicles();
    ModeUtil.debugPrint("startMaps");
  }

  void stopMaps() {
    model.alignmentTop = Alignment.topCenter;
    model.alignmentTop1 = Alignment(0, -0.75);
    model.alignmentBottom = Alignment.bottomCenter;
    model.commit();

    ModeUtil.debugPrint("stopMaps");
  }

  void removePoint(int i) {
    print("remove point as $i");
    if (i < model.googleMapControllers.totalPoint(id: 0)) {
      model.googleMapControllers.removePoinId(i);
    }
    if (model.googleMapControllers.totalPoint(id: 0) < 3) {
      addPoint = false;
    }
    model.googleMapControllers.newCameraPosition(
        latLng: model.googleMapControllers.getListPoint.first.last.latLng);
    model.commit();
    model.drawRoute();
    maxScroll();
  }

  void next() {}

  void maxScroll() {
    double _h = 50;
    if (model.googleMapControllers.totalPoint(id: 0) == 2) {
      _h = 0;
      model.heightInput = 115;
    }

    scrollController.animateTo(
      scrollController.position.maxScrollExtent + _h,
      curve: Curves.easeInOut,
      duration: Duration(microseconds: 500),
    );
  }

  void onTapTexteditor({int i}) {
    widget.onSelectLocation(model, i);
  }

  void updateMaps() {
    model.commit();
    model.googleMapControllers.clear();
  }

  @override
  void dispose() {
    model.typeController.dispose();
    model.commit();
    super.dispose();
  }

  void showVehicles({bool show = false}) {
    if (!show) {
      model.heightSelectedVehicle = 50;
      model.showVehicles = show;
    } else {
      if (model.selectedVehicleTypeList.length == 0) {
        model.heightSelectedVehicle = 50;
        model.showVehicles = false;
      } else {
        model.heightSelectedVehicle = 200;
        model.showVehicles = show;
        model.alignmentTop1 = Alignment(0, -0.66);
      }
    }
    model.commit();
  }

  void nextJalan() {
    bool _valid = true;
    model.controller.startLoading();
    for (var f in (model.googleMapControllers.getListPoint[0])) {
      if (f.latLng == null) {
        _valid = false;
        break;
      }
    }
    if (_valid && model.selectedVehicleTypes != null) {
      if (!validateLocation()) {
        print("masuk sini");
        model.controller.stopLoading();
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
              message: System.data.resource
                  .theLocationOfThePickupAndDestinationCannotBeTheSame),
        );
      } else if (validateIdenticalContact()) {
        model.controller.stopLoading();
        loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
                message: System.data.resource.senderAndReceiverCannotBeSome));
      } else if (model.selectedVehicleTypes.isAvailable == false) {
        model.controller.stopLoading();
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.yellowColor,
            message:
                "${model.selectedVehicleTypes.vehicleTypeName} ${System.data.resource.notYetAvailable}",
          ),
        );
      } else {
        if (widget.onSubmit != null) {
          widget.onSubmit(model, model.selectedVehicleTypes);
          model.controller.stopLoading();
        }
      }

      ModeUtil.debugPrint(true);
    } else {
      if (model.googleMapControllers.value.point[0]
              .where((f) => f.latLng == null)
              .toList()
              .length >
          0) {
        model.controller.stopLoading();
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: System
                .data.resource.pleaseDefineYourePickupAndDestinationLocation,
          ),
        );
      } else {
        model.controller.stopLoading();
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: System.data.resource.pleaseSelectVehicleType,
          ),
        );
      }
    }
  }

  void gotoCurrentLocations() {
    GeolocatorUtil.myLocation().then((loc) async {
      model.googleMapControllers
          .newCameraPosition(latLng: LatLng(loc.latitude, loc.longitude));
      model.commit();
    });
  }

  void notifSelectedVehicleTyoe(VehicleType type) {
    model.controller.stopLoading(
      messageAlign: Alignment.topCenter,
      messageWidget: DecorationComponent.topMessageDecoration(
        messageStyle: System.data.textStyleUtil.mainLabel(
          color: type.isAvailable
              ? System.data.colorUtil.lightTextColor
              : System.data.colorUtil.darkTextColor,
        ),
        message:
            "${type.vehicleTypeName} ${type.isAvailable ? System.data.resource.selected : System.data.resource.notYetAvailable}",
        backgroundColor: type.isAvailable
            ? System.data.colorUtil.greenColor
            : System.data.colorUtil.yellowColor,
      ),
    );
  }

  void startCheckShipmentNotyetRated() {
    if (widget.useRating == false) return;
    print(
        "status rating = ${System.data.isPopUpRatingOpened} user = ${System.data.getLocal<LocalData>().user == null}");
    if (System.data.isPopUpRatingOpened == true ||
        System.data.getLocal<LocalData>().user == null) {
      Timer.periodic(Duration(minutes: 5), (timer) {
        timer.cancel();
        startCheckShipmentNotyetRated();
      });
    } else {
      AngkutShipmentModel.getNotRated(token: System.data.global.token)
          .then((List<AngkutShipmentModel> onValue) {
        if (onValue.isNotEmpty) {
          System.data.isPopUpRatingOpened = true;
          System.data.showPopupRating(
            onTapRatting: () {
              if (widget.onTapRatting != null) {
                widget.onTapRatting(onValue.first);
              }
            },
          );
        }
        Timer.periodic(Duration(minutes: 5), (timer) {
          timer.cancel();
          startCheckShipmentNotyetRated();
        });
      }).catchError(
        (onError) {
          Timer.periodic(Duration(minutes: 5), (timer) {
            timer.cancel();
            startCheckShipmentNotyetRated();
          });
          model.controller.stopLoading(
            duration: Duration(seconds: 10),
            message: ErrorHandlingUtil.handleApiError(onError),
            isError: true,
            messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError,
                  prefix: "on get not ratted shipment"),
            ),
          );
        },
      );
    }
  }

  bool validateLocation() {
    if (model.googleMapControllers.value.point[0][0].latLng ==
        model.googleMapControllers.value.point[0][1].latLng) {
      return false;
    } else {
      return true;
    }
  }

  bool validateIdenticalContact() {
    if ((model.googleMapControllers.value.point[0][0].data.name ==
                model.googleMapControllers.value.point[0][1].data.name ||
            model.googleMapControllers.value.point[0][0].data.phoneNumber ==
                model
                    .googleMapControllers.value.point[0][1].data.phoneNumber) &&
        widget.useValidateIdenticalContact) {
      return true;
    } else {
      return false;
    }
  }
}
