import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/model/AngkutCreateOrderModel.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/app/angkut/model/VehicleCategory.dart';
import 'package:enerren/app/angkut/util/AngkutOrderUtil.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsValue.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/googleService/GoogleGeocoderModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewModel extends ChangeNotifier {
  List<VehicleCategory> vehicleCategory = [];
  List<VehicleType> selectedVehicleTypeList;

  VehicleCategory selectedVehicleCategory;
  VehicleType selectedVehicleTypes;
  double heightSelectedVehicle = 50;
  PageController typeController;
  bool finishTypeVehicle = false;

  bool showVehicles = false;
  Alignment alignmentTop = Alignment.topCenter;
  Alignment alignmentTop1 = Alignment(0, -0.75);
  Alignment alignmentBottom = Alignment.bottomCenter;

  GoogleMapsControllers googleMapControllers = GoogleMapsControllers(
    GoogleMapValue(
      primaryIcon: "assets/angkut/marker_red.png",
      secondaryIcon: "assets/angkut/marker_dot_blue.png",
      // startEndMarker:  true,
      // primaryColor:
    ),
  );

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  //for simulation view
  bool showRoute = false;
  bool finishShowRoute = true;
  Widget mapWidget;
  PageController typePageController =
      PageController(initialPage: 0, viewportFraction: 0.6);

  double heightInput = 115;

  void drawRoute() {
    // controller.startLoading();
    int i = -1;
    googleMapControllers.removeLayer(layer: 1);
    List<ObjectData> validLatLng = [];

    validLatLng = googleMapControllers.getListPoint[0]
        .where((f) => f.latLng != null)
        .toList();

    validLatLng.forEach(
      (p) {
        i = i + 1;
        if (i != 0) {
          ModeUtil.debugPrint(
              "print route from ${i - 1} => $i <==> ${validLatLng[i - 1].latLng.toString()} => ${validLatLng[i].latLng.toString()}");
          GoogleGeocoderModel.getRouteFromPositiom(
            origin: validLatLng[i - 1].latLng,
            destination: validLatLng[i].latLng,
            apiKey: System.data.global.googleMapApiKey,
          ).then((value) {
            value.routes[0].overViewPolyline.forEach(
              (p) {
                googleMapControllers.addPoint(
                  layer: 1,
                  showPolyLine: true,
                  animateCamera: false,
                  createMarker: false,
                  showPolygon: false,
                  pointData: ObjectData(
                    latLng: LatLng(p.lat, p.lon),
                  ),
                );
              },
            );
            googleMapControllers.bounds = LatLngBounds(
              northeast: LatLng(value.routes[0].bounds.northeast.lat,
                  value.routes[0].bounds.northeast.lon),
              southwest: LatLng(value.routes[0].bounds.southwest.lat,
                  value.routes[0].bounds.southwest.lon),
            );
            controller.stopLoading();
          }).catchError(
            (onError) {
              controller.stopLoading(
                messageAlign: Alignment.topCenter,
                messageWidget: DecorationComponent.topMessageDecoration(
                  message: ErrorHandlingUtil.handleApiError(onError),
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<AngkutShipmentModel> calculatePrice() {
    return AngkutShipmentModel.calculate(
        token: System.data.global.token,
        createOrderModel: new AngkutCreateOrderModel(
          customerId: System.data.getLocal<LocalData>()?.user?.customerId ?? 0,
          isInstant: true,
          extraHelper: false,
          deliveryNo: null,
          itemDescription: null,
          scheduledDate: null,
          shipmentFee: 0,
          vehicleTypeId: selectedVehicleTypes?.vehicleTypeId,
          detailDestinationList: readDestinationModel(
            googleMapControllers.getListPoint[0],
          ),
        )).then((onValue) {
      return onValue;
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  void clearSelectionVehicle() {
    selectedVehicleCategory = null;
    selectedVehicleTypeList = null;
    selectedVehicleTypes = null;
    alignmentTop1 = Alignment(0, -0.75);
    commit();
    typeController.animateToPage((vehicleCategory.length / 2).ceil() - 1,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void clearDestination() {
    print("total point at ${googleMapControllers.totalPoint(id: 0)} ");
    for (var i = googleMapControllers.totalPoint(id: 0) - 1; i >= 0; i--) {
      print("clear point at $i ");
      googleMapControllers.removePoinId(i);
    }
    for (var i = 1; i <= 2; i++) {
      googleMapControllers.addPoint(
        pointData: ObjectData(),
        showPolyLine: false,
        showPolygon: false,
      );
    }
    googleMapControllers.commit();
    drawRoute();
    heightInput = 115;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
