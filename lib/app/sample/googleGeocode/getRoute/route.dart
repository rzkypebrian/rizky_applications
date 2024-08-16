import 'package:enerren/app/sample/googleGeocode/getRoute/localData.dart';
import 'package:flutter/material.dart';
import 'package:enerren/model/googleService/GoogleGeocoderModel.dart';
import 'package:enerren/module/locationPicker/main.dart' as locationPicker;
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteName {
  static const String origin = "origin";
  static const String destination = "destination";
}

Map<String, WidgetBuilder> routes = {
  RouteName.origin: (BuildContext context) => locationPicker.Presenter(
        onPickLocation: (location) {
          System.data.getLocal<LocalData>().origin = LatLng(location.lat, location.lon);
          System.data.routes.pushNamed(context, RouteName.destination);
        },
      ),
  RouteName.destination: (BuildContext context) => locationPicker.Presenter(
        onPickLocation: (location) {
          System.data.getLocal<LocalData>().destination = LatLng(location.lat, location.lon);
          GoogleGeocoderModel.getRouteFromPositiom(
            origin: System.data.getLocal<LocalData>().origin,
            destination: System.data.getLocal<LocalData>().destination,
            apiKey: System.data.global.googleMapApiKey,
          ).then((value) {
            ModeUtil.debugPrint(value.routes.first.overViewPolyline);
          });
        },
      ),
};
