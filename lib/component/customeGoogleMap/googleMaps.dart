import 'package:enerren/component/customeGoogleMap/googleMapsController.dart';
import 'package:enerren/component/customeGoogleMap/googleMapsValue.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatelessWidget {
  final GoogleMapsControllers googleMapController;
  @required
  final Widget controllers;
  final ValueChanged<LatLng> centerMap;
  final ValueChanged<ObjectData> onTapMarker;
  final VoidCallback onCameraIdle;
  final VoidCallback onCameraMoveStarted;
  final ValueChanged<LatLng> onCameraUpdate;
  final LatLng center;
  final bool mapToolbar;
  final LatLngBounds bounds;
  final ValueChanged<LatLng> onTapMap;
  final bool zoomControllEnabled;

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
    this.zoomControllEnabled = false,
    this.bounds,
    this.onTapMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GoogleMapValue>(
      valueListenable: googleMapController,
      builder: (BuildContext context, value, Widget child) {
        value.onTapMarker = onTapMarker;
        value.centerMap = centerMap;
        value.center = center ?? value.center;
        value.latLng = center ?? value.latLng;
        value.bounds = bounds ?? value.bounds;
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blue[200],
          child: Stack(
            children: <Widget>[
              Align(
                child: GoogleMap(
                  initialCameraPosition: googleMapController.cameraPosition(),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: zoomControllEnabled,
                  markers: Set<Marker>.of(value.listMarker.values),
                  circles: Set<Circle>.of(value.listCircle.values),
                  polylines: Set<Polyline>.of(value.listPolyline.values),
                  polygons: Set<Polygon>.of(value.listPolygon.values),
                  onTap: (value) {
                    googleMapController.onTapMaps(value);
                    onTapMap(value);
                  },
                  onMapCreated: googleMapController.onMapCreated,
                  onCameraMove: (cameraPosition) {
                    print("camera move");
                    googleMapController.updateCameraPosition(cameraPosition);
                    onCameraUpdate(cameraPosition.target);
                  },
                  onLongPress: googleMapController.onLongPressMaps,
                  mapType: value.mapType,
                  trafficEnabled: value.trafficEnabled,
                  onCameraIdle: onCameraIdle,
                  onCameraMoveStarted: onCameraMoveStarted,
                  rotateGesturesEnabled: value.rotateGesturesEnabled,
                  mapToolbarEnabled: mapToolbar,
                  cameraTargetBounds: value.bounds != null
                      ? CameraTargetBounds(
                          value.bounds,
                        )
                      : null,
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
