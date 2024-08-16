 
import 'package:enerren/component/customeGoogleMapUpdate/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMapUpdate/googleMapsValue.dart';
import 'package:enerren/component/customeGoogleMapUpdate/objectData.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatelessWidget {
  final GoogleMapsControllers googleMapController;
  @required
  final Widget controllers;
  final ValueChanged<LatLng> centerMap;
  final ValueChanged<ObjectData> onTapMarker;
  final ValueChanged<CameraPosition> onCameraIdle;
  final ValueChanged<CameraPosition> onCameraMoveStarted;
  final ValueChanged<LatLng> onCameraUpdate;
  final LatLng center;
  final bool mapToolbar;
  final LatLngBounds bounds;

  GoogleMaps({
    Key key,
    this.googleMapController,
    this.controllers,
    this.onTapMarker,
    this.centerMap,
    this.onCameraIdle,
    this.onCameraMoveStarted,
    this.onCameraUpdate,
    this.center,
    this.mapToolbar = false,
    this.bounds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GoogleMapValue>(
      valueListenable: googleMapController,
      builder: (BuildContext context, value, Widget child) {
        value.onTapMarker = onTapMarker;
        value.bounds = bounds ?? value.bounds;
        return Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Align(
                child: GoogleMap(
                  initialCameraPosition: googleMapController.cameraPosition(),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: Set<Marker>.of(value.listMarker.values),
                  polylines: Set<Polyline>.of(value.listPolyline.values),
                  polygons: Set<Polygon>.of(value.listPolygon.values),
                  circles: Set<Circle>.of(value.listCircle.values),
                  onTap: googleMapController.onTapMaps,
                  trafficEnabled: value.trafficEnabled,
                  mapType: value.mapType,
                  rotateGesturesEnabled: value.rotateGesturesEnabled,
                  onCameraMoveStarted: () {
                    googleMapController.startCamera();
                    onCameraMoveStarted(value.cameraPositionStart);
                  },
                  onCameraIdle: () {
                    googleMapController.endCamera();
                    onCameraIdle(value.cameraPositionEnd);
                  },
                  mapToolbarEnabled: mapToolbar,
                  cameraTargetBounds: value.bounds != null
                      ? CameraTargetBounds(
                          value.bounds,
                        )
                      : null,
                  onMapCreated: googleMapController.onMapCreated,
                  onCameraMove: googleMapController.updateCameraPosition,
                  onLongPress: googleMapController.onLongPressMaps,
                ),
              ),
              SafeArea(child: controllers ?? Container()),
            ],
          ),
        );
      },
    );
  }
}
