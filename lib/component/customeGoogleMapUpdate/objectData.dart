import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ObjectData<T> {
  int id;
  LatLng latLng;
  String name;
  DateTime dateTime;
  T data;
  double rotation;
  double alpha;
  double zIndex;
  bool flat;
  Offset anchor;
  String address;
  String markerIcom;
  MarkerIconType markerIconType;
  int iconSize;
  VoidCallback onTapMarker;
  String snipset;
  String markerId;

  ObjectData({
    this.address,
    this.id = 0,
    this.flat = true,
    this.anchor,
    this.zIndex = 0,
    this.alpha = 1.0,
    this.rotation = 0,
    this.name,
    this.dateTime,
    this.latLng,
    this.data,
    this.markerIcom,
    this.markerIconType = MarkerIconType.Asset,
    this.iconSize,
    this.onTapMarker,
    this.snipset,
    this.markerId,
  }) {
    this.anchor = this.anchor ?? Offset(0.5, 1);
  }
}

enum MarkerIconType {
  Network,
  Asset,
}
