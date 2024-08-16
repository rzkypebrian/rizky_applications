import 'dart:async';

import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/VtsFleetModel.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'package:enerren/util/StringExtention.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int userIdVts;
  final String tokemVts;
  final ValueChanged<VtsPositionModel> onTapListItem;

  Presenter({
    this.view,
    this.userIdVts,
    this.tokemVts,
    this.onTapListItem,
  });

  @override
  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  InputComponentTextEditingController searchController =
      new InputComponentTextEditingController();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  ViewModel model = new ViewModel();

  @required
  initState() {
    super.initState();
    getAllVehicle();
  }

  bool validateSearch() {
    if (searchController.text.isNullOrEmpty()) {
      searchController.setStateInput = StateInput.Error;
      return false;
    } else {
      searchController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateSearch() ?? isValid;
    return isValid;
  }

  void submit() {
    if (!validate()) return;
    loadingController.startLoading();
    VtsPositionModel.getAllPotition(
      userId: null,
      token: null,
    );
  }

  void getAllVehicle({bool update = false}) {
    if (!update) loadingController.startLoading();
    VtsPositionModel.getAllPotition(
      userId: widget.userIdVts,
      token: widget.tokemVts,
    ).then((vehicleValue) {
      model.vehicles = vehicleValue;
      VtsFleetModel.getAllFleets(
        userId: widget.userIdVts,
        token: widget.tokemVts,
      ).then((fleetsValue) {
        model.fleets = fleetsValue;
        model.fleets.add(new VtsFleetModel(
          fleetId: 0,
          fleetName: System.data.resource.all,
          vehicles: List.generate(vehicleValue.length, (i) {
            return vehicleValue[i].vehicleId;
          }),
        ));
        if (model.selectedFleet != null) {
          if (model.fleets
                  .where((e) => e.fleetId == model.selectedFleet.fleetId)
                  .toList() //in68812898
                  .length <
              1) {
            model.fleets.add(model.selectedFleet);
          }
        } else {
          model.selectedFleet =
              model.fleets.where((e) => e.fleetId == 0).toList().first;
        }
        filterVehicle();
        loadingController.stopLoading();
        Timer.periodic(Duration(seconds: System.data.global.intervalUpdateData),
            (t) {
          t.cancel();
          getAllVehicle(update: true);
        });
      }).catchError((onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
        Timer.periodic(Duration(seconds: System.data.global.intervalUpdateData),
            (t) {
          t.cancel();
          getAllVehicle(update: true);
        });
      });
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
      Timer.periodic(Duration(seconds: System.data.global.intervalUpdateData),
          (t) {
        t.cancel();
        getAllVehicle(update: true);
      });
    });
  }

  void filterVehicle() {
    model.filteredVehicles = model.vehicles;

    //filter by fleet
    if (model.selectedFleet != null) {
      model.filteredVehicles = model.vehicles
          .where((e) =>
              model.selectedFleet.vehicles.cast<int>().contains(e.vehicleId))
          .toList();
    }

    if (searchController.text.isNullOrEmpty() == false) {
      model.filteredVehicles = model.filteredVehicles
          //filter vehicle name
          .where((e) =>
                  e.vehicleName
                      .toLowerCase()
                      .contains(searchController.text.trim().toLowerCase())
                  //filter vehicle number
                  ||
                  e.vehicleNumber
                      .toLowerCase()
                      .contains(searchController.text.trim().toLowerCase())
                  //filter driver name
                  ||
                  e.driverName
                      .toLowerCase()
                      .contains(searchController.text.trim().toLowerCase())
              //end
              )
          .toList();
    }

    model.commit();
  }

  void changeFleet(int fleetId) {
    model.selectedFleet =
        model.fleets.where((e) => e.fleetId == fleetId).toList()?.first;
    model.commit();
  }

  void onTapListItem(VtsPositionModel positionModel) {
    if (widget.onTapListItem != null) {
      widget.onTapListItem(positionModel);
    } else {
      ModeUtil.debugPrint("item tapped ${positionModel.toJson()}");
    }
  }
}
