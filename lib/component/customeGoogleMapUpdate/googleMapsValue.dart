import 'package:enerren/component/customeGoogleMapUpdate/objectData.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'googleMapsController.dart';

class GoogleMapValue {
  GoogleMapController controller;
  @required
  ObjectData selected;
  List<List<ObjectData>> point;
  List<List<LatLng>> listPointPolyline;
  LatLng latLng;
  double zoom;
  @required
  Color primaryColor;
  @required
  Color secondColor;
  Map<PolylineId, Polyline> listPolyline;
  Polyline selectedPolyline;
  PolylineId polylineId;
  Map<MarkerId, Marker> listMarker;
  Marker selectedMarker;
  MarkerId markerId;
  int width;
  @required
  String primaryIcon;
  @required
  String secondaryIcon;
  bool mapIsReady;
  double tilt;
  double bearing;
  MapType mapType;
  ValueChanged<ObjectData> onTapMarker;
  ValueChanged<LatLng> centerMap;
  LatLng center;
  bool trafficEnabled;
  bool showMarker;
  bool rotateGesturesEnabled;
  bool startEndMarker;
  ValueChanged<GoogleMapsControllers> onMapReady;
  LatLngBounds bounds;

  Circle selectedCirle;
  CircleId cirleId;
  Map<CircleId, Circle> listCircle;
  List<List<ObjectData>> listPointCircle;
  double radius;
  Polygon selectedPolygon;
  Map<PolygonId, Polygon> listPolygon;
  List<List<LatLng>> listPointPolygon;
  bool isPolygon;
  bool isPolyline;
  bool isMarker;
  bool isCircle;
  PolygonId polygonId;
  CameraPosition cameraPosition;
  CameraPosition cameraPositionStart;
  CameraPosition cameraPositionEnd;

  GoogleMapValue({
    this.selectedCirle,
    this.cirleId,
    this.listPointCircle,
    this.listCircle,
    this.radius = 100,
    this.cameraPosition,
    this.cameraPositionStart,
    this.cameraPositionEnd,
    this.isPolygon = false,
    this.isCircle = false,
    this.isMarker = false,
    this.isPolyline = false,
    this.polygonId,
    this.listPolygon,
    this.listPointPolygon,
    this.selectedPolygon,
    this.listPointPolyline,
    this.selectedPolyline,
    this.startEndMarker = false,
    this.rotateGesturesEnabled = true,
    this.centerMap,
    this.trafficEnabled = false,
    this.showMarker = true,
    this.onTapMarker,
    this.mapType = MapType.normal,
    this.tilt = 0,
    this.bearing = 0,
    this.zoom = 13,
    this.mapIsReady = false,
    this.latLng,
    this.markerId,
    this.point,
    this.controller,
    this.selected,
    this.primaryColor,
    this.secondColor,
    this.width,
    this.polylineId,
    this.listMarker,
    this.listPolyline,
    this.selectedMarker,
    this.primaryIcon,
    this.secondaryIcon,
    this.onMapReady,
    this.bounds,
    this.center,
  }) {
    this.listMarker = <MarkerId, Marker>{};
    this.listPolyline = <PolylineId, Polyline>{};
    this.listPolygon = <PolygonId, Polygon>{};
    this.listCircle = <CircleId, Circle>{};
    this.latLng = LatLng(-6.175392, 106.827153);
    this.point = [];
    this.point.add(<ObjectData>[]); //[0]
    this.point.add(<ObjectData>[]); //[1]
    this.point.add(<ObjectData>[]); //[2]
    this.point.add(<ObjectData>[]); //[3]
    this.point.add(<ObjectData>[]); //[4]
    this.point.add(<ObjectData>[]); //[5]
    this.point.add(<ObjectData>[]); //[6]
    this.point.add(<ObjectData>[]); //[7]
    this.point.add(<ObjectData>[]); //[8]
    this.point.add(<ObjectData>[]); //[9]
    this.listPointPolyline = [];
    this.listPointPolyline.add(<LatLng>[]); //[0]
    this.listPointPolyline.add(<LatLng>[]); //[1]
    this.listPointPolyline.add(<LatLng>[]); //[2]
    this.listPointPolyline.add(<LatLng>[]); //[3]
    this.listPointPolyline.add(<LatLng>[]); //[4]
    this.listPointPolyline.add(<LatLng>[]); //[5]
    this.listPointPolyline.add(<LatLng>[]); //[6]
    this.listPointPolyline.add(<LatLng>[]); //[7]
    this.listPointPolyline.add(<LatLng>[]); //[8]
    this.listPointPolyline.add(<LatLng>[]); //[9]
    this.listPointPolygon = [];
    this.listPointPolygon.add(<LatLng>[]); //[0]
    this.listPointPolygon.add(<LatLng>[]); //[1]
    this.listPointPolygon.add(<LatLng>[]); //[2]
    this.listPointPolygon.add(<LatLng>[]); //[3]
    this.listPointPolygon.add(<LatLng>[]); //[4]
    this.listPointPolygon.add(<LatLng>[]); //[5]
    this.listPointPolygon.add(<LatLng>[]); //[6]
    this.listPointPolygon.add(<LatLng>[]); //[7]
    this.listPointPolygon.add(<LatLng>[]); //[8]
    this.listPointPolygon.add(<LatLng>[]); //[9]
    this.listPointCircle = [];
    this.listPointCircle.add(<ObjectData>[]); //[0]
    this.listPointCircle.add(<ObjectData>[]); //[1]
    this.listPointCircle.add(<ObjectData>[]); //[2]
    this.listPointCircle.add(<ObjectData>[]); //[3]
    this.listPointCircle.add(<ObjectData>[]); //[4]
    this.listPointCircle.add(<ObjectData>[]); //[5]
    this.listPointCircle.add(<ObjectData>[]); //[6]
    this.listPointCircle.add(<ObjectData>[]); //[7]
    this.listPointCircle.add(<ObjectData>[]); //[8]
    this.listPointCircle.add(<ObjectData>[]); //[9]
    this.point.first = [];
    // this.polyLineSetting = [
    //   true, //[0]
    //   true, //[1]
    //   true, //[2]
    //   true, //[3]
    //   true, //[4]
    //   true, //[5]
    //   true, //[6]
    //   true, //[7]
    //   true, //[8]
    //   true, //[9]
    // ];
  }
}
