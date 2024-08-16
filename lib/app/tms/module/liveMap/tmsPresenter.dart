import 'dart:ui';

import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/module/liveMaps/presenter.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'tmsViewModel.dart';
import 'package:enerren/util/StringExtention.dart';

mixin TmsPresenter<T> on PresenterState {
  TmsViewModel viewModel = new TmsViewModel();
  ChildReader<T> childReader;

  @override
  void initState() {
    setFirstSelected();
    super.initState();
  }

  void setFirstSelected() {
    //copy to single
    if (viewModel.shipment.isEmpty) return;
    var single = TmsShipmentModel.fromJson<T>(viewModel.shipment.first.toJson(),
        childReader: (json) {
      return childReader(json);
    });
    single.tmsShipmentDestinationList = <TmsShipmentDestinationModel<T>>[
      viewModel.shipment.first.tmsShipmentDestinationList.first,
    ];

    setSelectedShipment(single);
  }

  void setSelectedShipment(TmsShipmentModel<T> selected) {
    viewModel.selectedShipment = selected;
    viewModel.originLat =
        viewModel.selectedShipment.tmsShipmentDestinationList.first.originLat;
    viewModel.originLon =
        viewModel.selectedShipment.tmsShipmentDestinationList.first.originLong;
    viewModel.destinationLat = viewModel
        .selectedShipment.tmsShipmentDestinationList.first.destinationLat;
    viewModel.destinationLon = viewModel
        .selectedShipment.tmsShipmentDestinationList.first.destinationLong;
    viewModel.desinationAddress = viewModel
        .selectedShipment.tmsShipmentDestinationList.first.destinationAddress;
    viewModel.customerPhoneNumber = viewModel.selectedShipment.customerPhone;
    viewModel.driverPhoneNumber =
        viewModel.selectedShipment.tmsShipmentDestinationList.first.driverPhone;
    viewModel.commit();
  }

  @override
  void readDestination() async {
    super.model.destination = [];
    for (var s = 0; s < viewModel.shipment.length; s++) {
      for (var d = 0;
          d < viewModel.shipment[s].tmsShipmentDestinationList.length;
          d++) {
        //add address
        if (viewModel
            .shipment[s].tmsShipmentDestinationList[d].destinationAddress
            .isNullOrEmpty()) {
          await GeolocatorUtil.getAddress(
                  viewModel
                      .shipment[s].tmsShipmentDestinationList[d].destinationLat,
                  viewModel.shipment[s].tmsShipmentDestinationList[d]
                      .destinationLong)
              .then((onValue) {
            viewModel.shipment[s].tmsShipmentDestinationList[d]
                .destinationAddress = onValue;
          });
        }

        //copy to single
        var single = TmsShipmentModel.fromJson<T>(
            viewModel.shipment[s].toJson(), childReader: (json) {
          return childReader(json);
        });
        single.tmsShipmentDestinationList = <TmsShipmentDestinationModel<T>>[
          viewModel.shipment[s].tmsShipmentDestinationList[d]
        ];

        super.model.destination.add(
              new ObjectData(
                markerIcon: "assets/track_destination.png",
                iconSize: 100,
                name: "${viewModel.shipment[s].customerName}",
                snipset:
                    "${viewModel.shipment[s].tmsShipmentDestinationList[d].destinationAddress ?? "-"}",
                markerIconType: MarkerIconType.Asset,
                anchor: Offset(0.5, 1.0),
                flat: false,
                latLng: LatLng(
                    viewModel.shipment[s].tmsShipmentDestinationList[d]
                        .destinationLat,
                    viewModel.shipment[s].tmsShipmentDestinationList[d]
                        .destinationLong),
                data: single,
                onTapMarker: () {
                  setSelectedShipment(single);
                },
              ),
            );
      }
      super.model.commit();
    }
  }

  void openMap(bool gotoDestination) {
    if (gotoDestination == true) {
      ExternalLinkComponent.openGooleMap(
        lat: viewModel.destinationLat,
        lon: viewModel.destinationLon,
      );
    } else {
      ExternalLinkComponent.openGooleMap(
        lat: model.currentPoition.lat,
        lon: model.currentPoition.lon,
      );
    }
  }

  @override
  void onReceiveNewPosition(VtsPositionModel positionModel) {
    ModeUtil.debugPrint("receive new position map");
    ModeUtil.debugPrint(
        "receive new position ${positionModel.lat} ${positionModel.lon} ${viewModel.selectedShipment?.iconUrl}");
    viewModel.backdoor = VtsPositionModel.readSensor(
        viewModel.backdoorSensorCode, positionModel);
    viewModel.fan =
        VtsPositionModel.readSensor(viewModel.fanSensorCode, positionModel);
    viewModel.temperature = positionModel.temp1?.toInt();
    viewModel.commit();
    // create marker new position
    model.googleMapsControllers.removeLayer(layer: 3);
    model.googleMapsControllers.addPoint(
      layer: 3,
      createMarker: true,
      animateCamera: false,
      pointData: ObjectData(
        id: positionModel.vehicleId,
        latLng: LatLng(positionModel.lat, positionModel.lon),
        // rotation: poition.course,
        markerIcon: onCreateMarkerIconSecondData(positionModel),
        markerIconType: MarkerIconType.Network,
        iconSize: positionModel.iconSize,
        anchor: Offset(0.5, 0.5),
        zIndex: 2,
        flat: false,
        markerId: positionModel.vehicleId.toString() + "_5",
        // onTapMarker: () {},
      ),
    );
  }

  String onCreateMarkerIconSecondData(VtsPositionModel position) {
    // print("secont marker ${viewModel.selectedShipment.iconUrl}");
    ModeUtil.debugPrint(
        "create second data ${position.lat} ${position.lon} ${viewModel.selectedShipment?.iconUrl}");
    if (viewModel.selectedShipment != null &&
        viewModel.selectedShipment != null) {
      return viewModel.selectedShipment?.iconUrl;
    } else {
      return "";
    }
  }
}
