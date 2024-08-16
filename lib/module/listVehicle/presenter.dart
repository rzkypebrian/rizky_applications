import 'dart:async';

import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter<T> extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged2Param<TmsVehicleModel<T>, VtsPositionModel> onTapVehicle;
  final ValueChanged2Param<TmsVehicleModel<T>, VtsPositionModel> onTapDriver;
  final ChildReader<T> childReader;
  final int userIdVts;
  final String tokenVts;
  final int selectedTab;
  final int selectedVehicleTab;
  final int selectedDriverTab;
  final bool withUnSuitableVehicle;

  const Presenter({
    Key key,
    this.view,
    this.onTapVehicle,
    this.onTapDriver,
    this.childReader,
    @required this.userIdVts,
    @required this.tokenVts,
    this.selectedTab,
    this.selectedVehicleTab,
    this.selectedDriverTab,
    this.withUnSuitableVehicle = false,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View<T>();
    }
  }
}

abstract class PresenterState<T> extends State<Presenter<T>>
    with TickerProviderStateMixin {
  ViewModel<T> model = new ViewModel<T>();

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  Timer timerWatch;

  TabController listController;
  TabController listControllerVehicle;
  TabController listControllerDriver;

  @override
  void initState() {
    super.initState();
    loadTab();
    matchTheVehicle();
  }

  void loadTab() {
    listController = new TabController(
        length: 2, vsync: this, initialIndex: widget.selectedTab ?? 0);
    model.selectedTab = widget.selectedTab ?? 0;
    listControllerVehicle = new TabController(
        length: 4, vsync: this, initialIndex: widget.selectedVehicleTab ?? 0);
    model.selectedVehicle = widget.selectedVehicleTab ?? 0;
    listControllerDriver = new TabController(
        length: 4, vsync: this, initialIndex: widget.selectedDriverTab ?? 0);
    model.selectetDriver = widget.selectedDriverTab ?? 0;
    model.commit();
  }

  @override
  void dispose() {
    listController.dispose();
    listControllerVehicle.dispose();
    listControllerDriver.dispose();
    super.dispose();
  }

  void changeTab(int i) {
    model.selectedTab = i;
    model.commit();
  }

  void onTapSubTabDriver(int i) {
    model.selectetDriver = i;
    model.commit();
  }

  void onTapSubTabVehicle(int i) {
    model.selectedVehicle = i;
    model.commit();
  }

  void matchTheVehicle([bool withLoadingIndicator = true]) {
    if (!mounted) return;
    getDataVehicle(
        withLoadingIndicator: withLoadingIndicator,
        onReceiveData: (vehicle) {
          getPositionVehicle(
              withLoadingIndicator: withLoadingIndicator,
              onReceiveData: (position) {
                model.suitableVehicle = [];
                vehicle.forEach((f) {
                  if (position
                          .where((x) => x.vehicleId == f.vtsVehicleId)
                          .toList()
                          .length >
                      0) {
                    f.isSuitable = true;
                    model.suitableVehicle.add(f);
                    model.commit();
                  } else {
                    if (widget.withUnSuitableVehicle == true) {
                      model.suitableVehicle.add(f);
                      model.commit();
                    }
                  }
                });
                Timer.periodic(
                    Duration(seconds: System.data.global.intervalUpdateMaps),
                    (t) {
                  matchTheVehicle(false);
                  t.cancel();
                });
              });
        });
  }

  void onTapItemVehicle(
      TmsVehicleModel<T> vehicle, VtsPositionModel vtsPositionModel) {
    if (widget.onTapVehicle != null) {
      widget.onTapVehicle(vehicle, vtsPositionModel);
    }
  }

  void onTapItemDriver(
      TmsVehicleModel<T> vehicle, VtsPositionModel vtsPositionModel) {
    if (widget.onTapDriver != null) {
      widget.onTapDriver(vehicle, vtsPositionModel);
    }
  }

  void getDataVehicle({
    bool withLoadingIndicator,
    ValueChanged<List<TmsVehicleModel<T>>> onReceiveData,
  }) {
    if (withLoadingIndicator) loadingController.startLoading();
    TmsVehicleModel.getAll<T>(
      token: System.data.global.token,
      childReader: (json) => widget.childReader(json),
    ).then((onValue) {
      // need to fix
      // from api
      ModeUtil.debugPrint("vehicle received ${onValue.length}");
      model.vehicles = onValue;
      loadingController.stopLoading();
      if (onReceiveData != null) {
        onReceiveData(model.vehicles);
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("error get vehicle from TMS ${onError.toString()}");
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.redColor.withOpacity(1.0),
            message: ErrorHandlingUtil.handleApiError(onError),
          ));
    });
  }

  void getPositionVehicle({
    bool withLoadingIndicator,
    ValueChanged<List<VtsPositionModel>> onReceiveData,
  }) {
    if (withLoadingIndicator) loadingController.startLoading();
    VtsPositionModel.getAllPotition(
      userId: widget.userIdVts,
      token: widget.tokenVts,
    ).then((onValue) {
      model.positions = onValue;
      // model.commit();
      loadingController.stopLoading();
      if (onReceiveData != null) {
        onReceiveData(model.positions);
      }
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }
}
