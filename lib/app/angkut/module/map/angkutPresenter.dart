import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/dateTImePicker.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/module/maps/presenter.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'angkutViewModel.dart';
import 'package:http/http.dart' as http;

mixin AngkutPresenter on PresenterState {
  AngkutViewModel angkutViewModel = new AngkutViewModel();
  AngkutViewModelController angkutViewModelController;
  VoidCallback onMarkerSelected;

  @override
  void initState() {
    super.initState();
    angkutViewModelController = AngkutViewModelController(
      value: angkutViewModel,
    );
  }

  void moveToSelected(int vehicleId) {
    VtsPositionModel positionModel;
    //update map view model
    positionModel =
        super.model.positions.where((x) => x.vehicleId == vehicleId).first;
    super.createSelectedMarker(positionModel,
        moveCamera: true, iconSize: (super.model.selected.iconSize ?? 50) * 5);
    model.selected = positionModel;
    model.commit();
    //update sieradViewmodel
    angkutViewModel.selectedVehicle = angkutViewModel.vehicles
        .where((x) => x.vtsVehicleId == vehicleId)
        .first;
    angkutViewModel.commit();
  }

  @override
  void createSelectedMarker(VtsPositionModel selected,
      {bool moveCamera = false, int iconSize = 200}) {
    super.createSelectedMarker(selected,
        moveCamera: moveCamera,
        iconSize: (super.model.selected.iconSize ?? 50) * 5);
    //update sieradViewmodel
    angkutViewModel.selectedVehicle = angkutViewModel.vehicles
        .where((x) => x.vtsVehicleId == selected.vehicleId)
        .first;
    angkutViewModel.commit();
  }

  @override
  Future<void> onFilteredPosition() async {
    ModeUtil.debugPrint(model.filteredPositions.length);
    ModeUtil.debugPrint("load all vehicle");
    ModeUtil.debugPrint(System.data.global.token);
    await TmsVehicleModel.getAll<AngkutShipmentModel>(
      token: System.data.global.token,
      // vehicleStatus: 3,
      childReader: (json) => AngkutShipmentModel.fromJson(json),
    ).then((onValues) {
      ModeUtil.debugPrint("masuk sini");
      ModeUtil.debugPrint(onValues);
      angkutViewModel.vehicles = onValues;
      angkutViewModel.commit();
      super.mapLoadingController.stopLoading();
      model.filteredPositions = [];
      //filter by list from sierad
      model.positions.forEach(
        (f) {
          if (angkutViewModel.vehicles
                  .where((x) => x.vtsVehicleId == f.vehicleId)
                  .toList()
                  .length >
              0) {
            f.imageIconUrl = angkutViewModel.vehicles
                .where((x) => x.vtsVehicleId == f.vehicleId)
                .first
                ?.vehicleTypeIconUrlTop;
            // f.imageIconUrl = "https://sendeyo.com/up/d/16057bd984";
            f.iconSize = angkutViewModel.vehicles
                    .where((x) => x.vtsVehicleId == f.vehicleId)
                    .first
                    ?.vehicleTypeIconTopSize ??
                150;
            model.filteredPositions.add(f);
          }
        },
      );
      model.commit();
      return;
    }).catchError((onError) {
      String _error = "";
      try {
        http.Response _response = onError;
        _error = _response.body.isEmpty ? _response.statusCode : _response.body;
      } catch (e) {
        _error = onError;
      }
      super.mapLoadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.redColor.withOpacity(0.8),
              message: _error,
            ),
          );
      return;
    });
    // super.onFilteredPosition();
  }

  void openMap() {
    ModeUtil.debugPrint(
        "lat long nya ${model.selected.lat}  ${model.selected.lon}");
    ExternalLinkComponent.openGooleMap(
      lat: model.selected.y,
      lon: model.selected.x,
    );
  }

  @override
  onTapMarker() {
    onMarkerSelected();
  }
}

class AngkutViewModelController extends ValueNotifier<AngkutViewModel> {
  AngkutViewModelController({AngkutViewModel value})
      : super(value == null ? AngkutViewModel() : value);

  static const baseImageEncoder = "data:image/png;base64,";

  selectFromDate(BuildContext context) {
    showDateTimePicker(context,
        mode: PickerMode.DateTime,
        datePickerSetting: DatePickerSetting(
          initialDate: value.selectedFromDate,
          // lastDate: selectedToDate,
        )).then((date) {
      if (date != null) {
        value.fromDateController.text = DateFormat(
                System.data.resource.dateTimeFormat,
                System.data.resource.dateLocalFormat)
            .format(date);
        value.selectedFromDate = date;
      }
    }).catchError((onError) {
      //
    });
  }

  selectToDate(BuildContext context) {
    showDateTimePicker(
      context,
      mode: PickerMode.DateTime,
      datePickerSetting: DatePickerSetting(
        // firstDate: selectedFromDate,
        initialDate: value.selectedToDate,
      ),
    ).then((date) {
      if (date != null) {
        value.toDateController.text = DateFormat(
                System.data.resource.dateTimeFormat,
                System.data.resource.dateLocalFormat)
            .format(date);
        value.selectedToDate = date;
      }
    }).catchError((onError) {
      //
    });
  }

  bool validateFromDate() {
    if (value.selectedFromDate == null) {
      value.fromDateController.stateInput = StateInput.Error;
      notifyListeners();
      return false;
    } else {
      value.fromDateController.stateInput = StateInput.Enable;
      notifyListeners();
      return null;
    }
  }

  bool validateToDate() {
    if (value.selectedToDate == null) {
      value.toDateController.stateInput = StateInput.Error;
      notifyListeners();
      return false;
    } else {
      value.toDateController.stateInput = StateInput.Enable;
      notifyListeners();
      return null;
    }
  }

  bool validateSearchHistory() {
    bool valid = true;
    valid = validateFromDate() ?? valid;
    valid = validateToDate() ?? valid;
    notifyListeners();
    return valid;
  }

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }
}
