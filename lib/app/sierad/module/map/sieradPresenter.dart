import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/component/dateTImePicker.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/module/maps/presenter.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'sieradViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:enerren/util/StringExtention.dart';

mixin SieradPresenter on PresenterState {
  SieradViewModel sieradViewModel = new SieradViewModel();
  SieradViewModelController sieradViewModelController;

  @override
  void initState() {
    super.initState();
    sieradViewModelController = SieradViewModelController(
      value: sieradViewModel,
    );
  }

  void moveToSelected(int vehicleId) {
    VtsPositionModel positionModel;
    //update map view model
    positionModel =
        super.model.positions.where((x) => x.vehicleId == vehicleId).first;
    super.createSelectedMarker(positionModel, moveCamera: true);
    model.selected = positionModel;
    model.commit();
    //update sieradViewmodel
    sieradViewModel.selectedVehicle = sieradViewModel.vehicles
        .where((x) => x.vtsVehicleId == vehicleId)
        .first;
    sieradViewModel.commit();
  }

  @override
  void createSelectedMarker(VtsPositionModel selected,
      {bool moveCamera = false, int iconSize = 200}) {
    super.createSelectedMarker(selected);
    //update sieradViewmodel
    sieradViewModel.selectedVehicle = sieradViewModel.vehicles
        .where((x) => x.vtsVehicleId == selected.vehicleId)
        .first;
    sieradViewModel.commit();
  }

  @override
  Future<void> onFilteredPosition() async {
    ModeUtil.debugPrint(model.filteredPositions.length);
    // super.mapLoadingController.startLoading();
    ModeUtil.debugPrint(System.data.global.token);
    await TmsVehicleModel.getAll<
        TmsShipmentModel<SieradShipmentDetailHatcheryModel>>(
      token: System.data.global.token,
      // vehicleStatus: 3,
      childReader: (json) => TmsShipmentModel.fromJson(json,
          childReader: (subJson) =>
              SieradShipmentDetailHatcheryModel.fromJson(subJson)),
    ).then((onValues) {
      sieradViewModel.vehicles = onValues;
      sieradViewModelController.filter();
      sieradViewModel.commit();
      super.mapLoadingController.stopLoading();
      model.filteredPositions = [];
      //filter by list from sierad
      model.positions.forEach(
        (f) {
          if (sieradViewModel.vehicles
                  .where((x) => x.vtsVehicleId == f.vehicleId)
                  .toList()
                  .length >
              0) {
            f.imageIconUrl = sieradViewModel.vehicles
                .where((x) => x.vtsVehicleId == f.vehicleId)
                .first
                ?.vehicleTypeIconUrlTop;
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
            messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.redColor.withOpacity(0.5),
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
  String onCreatePositionMarkerIcon(VtsPositionModel vtsPositionModel) {
    return super.onCreatePositionMarkerIcon(vtsPositionModel);
  }

  @override
  ObjectData onCreateSecondData(VtsPositionModel poition) {
    // return null;
    return ObjectData(
      id: poition.vehicleId,
      latLng: LatLng(poition.lat, poition.lon),
      // rotation: poition.course,
      markerIcon: onCreateMarkerIconSecondData(poition),
      markerIconType: poition.imageIconUrl.isNullOrEmpty()
          ? MarkerIconType.Asset
          : MarkerIconType.Network,
      iconSize: poition.iconSize,
      anchor: Offset(0.5, 0.5),
      flat: false,
      markerId: poition.vehicleId.toString() + "_2",
      onTapMarker: () {
        model.selected = poition;
        model.commit();
        createSelectedMarker(model.selected);
        onTapMarker();
      },
    );
  }

  String onCreateMarkerIconSecondData(VtsPositionModel position) {
    List<TmsVehicleModel> vehicle = sieradViewModel.vehicles
        .where((x) => x.vtsVehicleId == position.vehicleId)
        .toList();
    if (vehicle != null) {
      if (vehicle.first.shipmentHeaderData != null &&
          vehicle.first.shipmentHeaderData.length > 0) {
        return (vehicle.first.shipmentHeaderData.first as TmsShipmentModel)
            .iconUrl;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

class SieradViewModelController extends ValueNotifier<SieradViewModel> {
  SieradViewModelController({SieradViewModel value})
      : super(value == null ? SieradViewModel() : value);

  static const baseImageEncoder = "data:image/png;base64,";

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }

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

  void filter() {
    value.filteredVehicle = value.vehicles;
    if (value.searchController.text.isNotEmpty) {
      value.filteredVehicle = value.filteredVehicle
          .where(
            (x) =>
                x.vehicleName
                    .toLowerCase()
                    .contains(value.searchController.text.toLowerCase()) ||
                x.driverName
                    .toLowerCase()
                    .contains(value.searchController.text.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }
}
