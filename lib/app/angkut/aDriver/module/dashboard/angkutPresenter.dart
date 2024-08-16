import 'dart:async';

import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/model/tmsVehicleCheckDocument.dart';
import 'package:enerren/module/dashboard/presenter.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';
import 'package:enerren/main.dart' as main;

mixin AngkutPresenter on PresenterState {
  ViewModel model = new ViewModel();
  AbsentController absentController = new AbsentController();
  CircularProgressIndicatorController dashboardLoadingController =
      new CircularProgressIndicatorController();
  CircularProgressIndicatorController totalBlocLoadingController =
      new CircularProgressIndicatorController();
  CircularProgressIndicatorController absentLoadingController =
      new CircularProgressIndicatorController();

  bool absteintStatus;

  @override
  void initState() {
    super.initState();
    dashboardLoadingController.stopLoading();
    totalBlocLoadingController.startLoading();
    absentLoadingController.stopLoading();
    updateProfile();
  }

  Future<bool> checkAbsteins() {
    return DriverModel.checkVehicleAbsenceDaily(
      token: System.data.global.token,
    ).then((value) {
      dashboardLoadingController.stopLoading();
      return value;
    }).catchError((onError) {
      throw onError;
    });
  }

  void setToWork() {
    dashboardLoadingController.startLoading();
    DriverModel.setToActive(
      token: System.data.global.token,
    ).then((value) {
      System.data.getLocal<LocalData>().user.isReadyToWork = true;
      absentController.clear();
      System.commit();
      dashboardLoadingController.stopLoading();
    }).catchError((onError) {
      dashboardLoadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  void send() {
    ModalComponent.bottomModalWithCorner(
      context,
      height: double.infinity,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.white.withOpacity(0.1),
      child: Container(
        height: MediaQuery.of(context).size.height - 150,
        child: GestureDetector(
          onVerticalDragDown: (a) {
            return;
          },
          child: Stack(
            children: <Widget>[
              DecorationComponent.circularLOadingIndicator(
                coverScreen: false,
                controller: totalBlocLoadingController,
              ),
            ],
          ),
        ),
      ),
    );
    //validasi
    if (absentController.value.confirm == false) {
      Navigator.of(context).pop();
      main.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message:
              "${System.data.resource.pleaseCheckTheDataValidityStatement}",
        ),
      );
      return;
    } else {
      // if (absentController.value.fuelLevel == false ||
      //     absentController.value.engineTemperature == false ||
      //     absentController.value.oilLevel == false ||
      //     absentController.value.batteraiStatus == false) {
      //   Navigator.of(context).pop();
      //   main.loadingController.stopLoading(
      //     messageAlign: Alignment.topCenter,
      //     messageWidget: DecorationComponent.topMessageDecoration(
      //       message:
      //           "${System.data.resource.pleaseCheckAllConditionOfYourVehicle}",
      //     ),
      //   );
      //   return;
      if (3 == 2) {
      } else {
        if (absentController.value.multipleImagePickerController
                    .getBase64Compress()
                    .isEmpty ==
                true ||
            absentController.value.multipleImagePickerController
                    .getBase64Compress()
                    .length <
                2) {
          Navigator.of(context).pop();
          main.loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              message: "${System.data.resource.pleaseAttachAtLeast2photo}",
            ),
          );
          return;
        }
      }
    }

    //send data to server
    TmsVehicleCheckDocument.add(
      param: new TmsVehicleCheckDocument(
          checkFileGuid: null,
          checkNote: null,
          shipmentRef: null,
          driverId: System.data.getLocal<LocalData>().user.driverId,
          checkTime: DateTime.now(),
          accuStatus: absentController.value.batteraiStatus,
          fuelLevel: absentController.value.fuelLevel,
          oilLevel: absentController.value.oilLevel,
          machineTemperature: absentController.value.engineTemperature,
          selfiePhoto: absentController.value.multipleImagePickerController
              .getBase64Compress()),
      token: System.data.global.token,
    ).then((onValue) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      System.data.getLocal<LocalData>().user.isReadyToWork = true;
      absentController.clear();
      System.commit();
    }).catchError((onError) {
      Navigator.of(context).pop();
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  void setToRest() {
    dashboardLoadingController.startLoading();
    DriverModel.setToRest(
      token: System.data.global.token,
    ).then((onValue) {
      System.data.getLocal<LocalData>().user.isReadyToWork = false;
      System.commit();
      dashboardLoadingController.stopLoading();
    }).catchError((onError) {
      dashboardLoadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  currentShipment({
    ValueChanged<AngkutShipmentModel> callback,
  }) {
    loadingController.startLoading();
    AngkutShipmentModel.getProcessed(
      token: System.data.global.token,
      isLowerThanId: false,
      limit: 10,
      shipmentId: null,
      withRoute: false,
    ).then((onValue) {
      if (onValue.length == 0) {
        loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            duration: Duration(seconds: 5),
            messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.redColor,
              message: "${System.data.resource.noShipmentProcessed}",
            ));
      } else {
        loadingController.stopLoading();
        callback(onValue.first);
      }
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          backgroundColor: System.data.colorUtil.redColor,
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  void updateProfile() {
    DriverModel.getInfo(
      token: System.data.global.token,
    ).then((onValue) {
      System.data.getLocal<LocalData>().user = onValue;
      System.commit();
      // Timer.periodic((Duration(seconds: System.data.global.intervalUpdateData)),
      //     (t) {
      //   t.cancel();
      //   updateProfile();
      // });
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.redColor,
            message: ErrorHandlingUtil.handleApiError(onError,
                prefix: "Update User Info")),
      );
    });
  }
}

class AbsentController extends ValueNotifier<AbsentModel> {
  AbsentController({
    AbsentModel value,
    AbsentModel target,
  }) : super(value == null ? AbsentModel() : value);

  static const baseImageEncoder = "data:image/png;base64,";

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }

  void setFuelStatus(bool status) {
    ModeUtil.debugPrint("masuk sini juga");
    value.fuelLevel = status;

    notifyListeners();
  }

  void setEngineTemperatureStatus(bool status) {
    value.engineTemperature = status;
    notifyListeners();
  }

  void oilStatus(bool status) {
    value.oilLevel = status;
    notifyListeners();
  }

  void batterayStatus(bool status) {
    value.batteraiStatus = status;
    notifyListeners();
  }

  void confirmStatus(bool status) {
    value.confirm = status;
    notifyListeners();
  }

  void clear() {
    value.batteraiStatus = false;
    value.confirm = false;
    value.oilLevel = false;
    value.engineTemperature = false;
    value.fuelLevel = false;
    value.multipleImagePickerController.clear();
    notifyListeners();
  }
}
