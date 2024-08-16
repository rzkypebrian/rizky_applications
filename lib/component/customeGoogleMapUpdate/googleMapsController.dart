import 'dart:typed_data';
import 'dart:ui';
import 'package:enerren/component/customeGoogleMapUpdate/googleMapsValue.dart';
import 'package:enerren/component/customeGoogleMapUpdate/objectData.dart';
import 'package:enerren/util/ArrayUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsControllers extends ValueNotifier<GoogleMapValue> {
  GoogleMapsControllers(GoogleMapValue value)
      : super(value == null ? GoogleMapValue() : value);

  int _mapType = 1;
  // -----------------------------------------------------------
  // get setter
  void changeIsPolygon() {
    value.isPolygon = !value.isPolygon;
    commit();
  }

  bool get getStatusPolygon => value.isPolygon;

  void changeIsMarker() {
    value.isMarker = !value.isMarker;
    commit();
  }

  bool get getStatusMarker => value.isMarker;

  void changeIsPolyline() {
    value.isPolyline = !value.isPolyline;
    commit();
  }

  bool get getStatusPolyline => value.isPolyline;

  void changeIsCircle() {
    value.isCircle = !value.isCircle;
    commit();
  }

  bool get getStatusCircle => value.isCircle;

  void changeisMapReady() {
    value.mapIsReady = !value.mapIsReady;
    commit();
  }

  bool get isMapReady => value.mapIsReady;

  void changeisTraffic() {
    value.trafficEnabled = !value.trafficEnabled;
    commit();
  }

  bool get isTrafic => value.trafficEnabled;

  CameraPosition get getCameraPosition => value.cameraPosition;

  CameraPosition get getStartCameraPosition {
    return value.cameraPositionStart;
  }

  CameraPosition get getEndCameraPosition {
    return value.cameraPositionEnd;
  }

  void startCamera() {
    value.cameraPositionStart = value.cameraPosition;
    ModeUtil.debugPrint("Start position ${value.cameraPositionStart}");
    commit();
  }

  void endCamera() {
    value.cameraPositionEnd = value.cameraPosition;
    ModeUtil.debugPrint("end position ${value.cameraPositionEnd}");
    commit();
  }

  // -------------------------------------------------------
  // total list
  int totalPoint({index}) {
    return index == null ? value.point.length : value.point[index].length;
  }

  int totalPointCircle({index}) {
    return index == null
        ? value.listPointCircle.length
        : value.listPointCircle[index].length;
  }

  int totalPointPolyline({index}) {
    return index == null
        ? value.listPointPolyline.length
        : value.listPointPolyline[index].length;
  }

  int totalPointPolygon({index}) {
    return index == null
        ? value.listPointPolygon.length
        : value.listPointPolygon[index].length;
  }

  // ----------------------------------
  // get list
  List<List<LatLng>> get getAllPointPolygon {
    return value.listPointPolygon;
  }

  List<List<LatLng>> get getAllPointPolyline {
    return value.listPointPolyline;
  }

  List<List<ObjectData>> get getAllPoint {
    return value.point;
  }

  List<List<ObjectData>> get getAllCirle {
    return value.listPointCircle;
  }

  // -----------------------------------------------
  // generete polyline, polygone and marker
  Future<void> generatePolyLines(
      {int layer = 0, List<PatternItem> patern}) async {
    value.polylineId = PolylineId(getPolylineId(layer: layer));
    Polyline polyline = Polyline(
      polylineId: value.polylineId,
      consumeTapEvents: true,
      color: value.primaryColor ?? System.data.colorUtil.primaryColor,
      width: value.width,
      points: value.listPointPolyline[layer].where((f) => f != null).toList(),
      startCap: Cap.squareCap,
      endCap: Cap.squareCap,
      geodesic: true,
      jointType: JointType.round,
      patterns: patern ??
          [
            PatternItem.dash(40),
            PatternItem.gap(10.0),
          ],
      onTap: () {
        ModeUtil.debugPrint("OnTap Polyline");
      },
    );
    if (value.isPolyline) value.listPolyline[value.polylineId] = polyline;
    commit();
  }

  Future<void> generatePolygons({
    int layer = 0,
  }) async {
    value.polygonId = PolygonId(getPolygonId(layer: layer));
    Polygon polyline = Polygon(
      polygonId: value.polygonId,
      consumeTapEvents: true,
      points: value.listPointPolygon[layer].where((f) => f != null).toList(),
      strokeWidth: 2,
      strokeColor: value.primaryColor ?? System.data.colorUtil.primaryColor,
      fillColor: value.primaryColor ?? System.data.colorUtil.primaryColor,
      onTap: () {
        ModeUtil.debugPrint("OnTap Polygone");
      },
    );
    if (value.isPolygon) value.listPolygon[value.polygonId] = polyline;
    commit();
  }

  Future<void> generateCircle({
    layer = 0,
    ObjectData objec,
    String circleName,
  }) async {
    if (objec.latLng != null) {
      ModeUtil.debugPrint(
          "marker idnya ya ${getCircleId(layer: layer, circleId: circleName ?? (value.listPointCircle[layer].length - 1).toString())} object name ${objec.name}");
      CircleId circleId = CircleId(getCircleId(
          layer: layer,
          circleId: circleName ??
              (value.listPointCircle[layer].length - 1).toString()));

      Circle circle = Circle(
        circleId: circleId,
        center: objec.latLng,
        radius: value.radius,
        fillColor: value.secondColor ?? System.data.colorUtil.secondaryColor,
        strokeWidth: value.width,
        strokeColor: value.primaryColor ?? System.data.colorUtil.primaryColor,
      );
      if (value.isCircle) value.listCircle[circleId] = circle;
      commit();
    }
  }

  Future<void> generateAllCircle({
    layer = 0,
    String circleName,
  }) async {
    int _no = 0;
    for (ObjectData objec in value.listPointCircle[layer]) {
      if (objec.latLng != null) {
        CircleId circleId = CircleId(
            getCircleId(layer: layer, circleId: circleName ?? _no.toString()));

        Circle circle = Circle(
          circleId: circleId,
          center: objec.latLng,
          radius: value.radius,
          fillColor: value.secondColor ?? System.data.colorUtil.secondaryColor,
          strokeWidth: value.width,
          strokeColor: value.primaryColor ?? System.data.colorUtil.primaryColor,
        );
        if (value.isCircle) value.listCircle[circleId] = circle;
        commit();
      }
      _no++;
    }
  }

  Future<void> generateMarker({
    layer = 0,
    ObjectData objec,
    bool userIcon = true,
    String markerName,
  }) async {
    if (objec.latLng != null) {
      ModeUtil.debugPrint(
          "marker idnya ya ${getMarkerId(layer: layer, markerId: markerName ?? (value.point[layer].length - 1).toString())} object name ${objec.name}");
      MarkerId markerId = MarkerId(getMarkerId(
          layer: layer,
          markerId: markerName ?? (value.point[layer].length - 1).toString()));

      Uint8List iconMarker = await getBytesFrom(
        fromAssets: objec.markerIconType == MarkerIconType.Asset ? true : false,
        path: objec.markerIcom ?? value.primaryIcon,
        width: objec.iconSize ?? 50,
      );

      Marker marker = Marker(
        markerId: markerId,
        position: objec.latLng,
        infoWindow: InfoWindow(
          title: objec.name,
          snippet: objec.snipset,
        ),
        onTap: () {
          ModeUtil.debugPrint("ontap marker id $markerId");

          if (objec.onTapMarker != null) {
            objec.onTapMarker();
          } else {
            value.onTapMarker(objec);
            onMarkerTapped(markerId: markerId, object: objec);
            commit();
          }
        },
        onDragEnd: (LatLng position) {},
        icon: BitmapDescriptor.fromBytes(iconMarker),
        rotation: objec.rotation,
        alpha: objec.alpha,
        zIndex: objec.zIndex,
        anchor: objec.anchor,
        flat: objec.flat,
      );

      if (value.isMarker) value.listMarker[markerId] = marker;
      commit();
    }
  }

  Future<void> generateAllMarker({
    layer = 0,
    bool userIcon = true,
    String markerName,
  }) async {
    int _no = 0;
    for (ObjectData objec in value.point[layer]) {
      if (objec.latLng != null) {
        MarkerId markerId = MarkerId(
            getMarkerId(layer: layer, markerId: markerName ?? _no.toString()));

        Uint8List iconMarker = await getBytesFrom(
          fromAssets:
              objec.markerIconType == MarkerIconType.Asset ? true : false,
          path: objec.markerIcom ?? value.primaryIcon,
          width: objec.iconSize ?? 50,
        );

        ModeUtil.debugPrint("ontap marker id ${objec.name}");

        Marker marker = Marker(
          markerId: markerId,
          position: objec.latLng,
          infoWindow: InfoWindow(
            title: objec.name,
            snippet: objec.snipset,
          ),
          onTap: () {
            ModeUtil.debugPrint("ontap marker id $markerId");

            if (objec.onTapMarker != null) {
              objec.onTapMarker();
            } else {
              value.onTapMarker(objec);
              onMarkerTapped(markerId: markerId, object: objec);
              commit();
            }
          },
          onDragEnd: (LatLng position) {},
          icon: BitmapDescriptor.fromBytes(iconMarker),
          rotation: objec.rotation,
          alpha: objec.alpha,
          zIndex: objec.zIndex,
          anchor: objec.anchor,
          flat: objec.flat,
        );

        if (value.isMarker) value.listMarker[markerId] = marker;
        commit();
      }
      _no++;
    }
  }

  // ----------------------------
  // add single
  Future<void> addPointPolygon({
    int layer = 0,
    LatLng pointData,
  }) async {
    ModeUtil.debugPrint("ontap map polygon status ${value.isPolygon}");
    if (value.isPolygon) {
      value.listPointPolygon[layer].add(pointData);
      await generatePolygons(layer: layer);
    }
    commit();
  }

  Future<void> addPointPolyline({
    int layer = 0,
    LatLng pointData,
  }) async {
    ModeUtil.debugPrint("ontap map polyline  status ${value.isPolygon}");
    if (value.isPolyline) {
      value.listPointPolyline[layer].add(pointData);
      await generatePolyLines(layer: layer);
    }
    commit();
  }

  Future<void> addPointMarker({
    int layer = 0,
    LatLng pointData,
  }) async {
    ModeUtil.debugPrint("ontap map marker status ${value.isMarker}");
    ObjectData _objectData = ObjectData(
        latLng: pointData, name: (value.point[layer].length).toString());
    if (value.isMarker) {
      value.point[layer].add(_objectData);
      await generateMarker(layer: layer, objec: _objectData);
    }
    commit();
  }

  Future<void> addPointCircle({
    int layer = 0,
    LatLng pointData,
  }) async {
    ModeUtil.debugPrint("ontap map circle status ${value.isCircle}");
    ObjectData _objectData = ObjectData(
        latLng: pointData,
        name: (value.listPointCircle[layer].length).toString());
    if (value.isCircle) {
      value.listPointCircle[layer].add(_objectData);
      await generateCircle(layer: layer, objec: _objectData);
    }
    commit();
  }

  // ---------------------------------------------
  //
  void changePoint(List<ObjectData> point, {int layer}) {
    value.point[layer] = point;
    commit();
  }

  // -------------------------------------------------------------------
  // point
  Future<void> addPoint({
    ObjectData pointData,
    int layer = 0,
    bool animateCamera = true,
    bool notifyListiner = true,
    List<PatternItem> patern,
    bool createMarker = true,
  }) async {
    value.point[layer].add(pointData);
    value.listPointPolyline[layer].add(pointData.latLng);
    value.listPointPolygon[layer].add(pointData.latLng);

    if (value.isMarker) {
      if (checkMarkerid(
        layer: layer,
        markerId: pointData.markerId ?? value.point[layer].length,
      ))
        await changePositionMarker(
          markerId: getMarkerId(
              layer: layer,
              markerId:
                  pointData.markerId ?? value.point[layer].length.toString()),
          objectData: pointData,
        );
      else
        await generateMarker(
          layer: layer,
          objec: pointData,
          markerName: getMarkerId(
            layer: layer,
            markerId:
                pointData.markerId ?? value.point[layer].length.toString(),
          ),
        );
    }

    if (value.isPolyline) {
      if (checkPolylineId(layer: layer))
        await changePolyline(layer: layer, patern: patern);
      else
        await generatePolyLines(layer: layer, patern: patern);
    }

    if (value.isPolygon) {
      if (checkPolygonId(layer: layer))
        await changePolygon(layer: layer);
      else
        await generatePolygons(layer: layer);
    }

    if (pointData.latLng != null && animateCamera == true) {
      if (animateCamera) {
        newCameraPosition(
          latLng: pointData.latLng,
          zoom: value.zoom,
        );
      }
    }
  }

  @deprecated
  Future<void> addOnlyPoints({
    ObjectData object,
    int layer = 0,
    bool animateCamera = true,
    bool notifyListiner = true,
    List<PatternItem> patern,
    String markerId,
    bool showPolyLine = true,
    bool moveCamera = true,
    bool updateMarker = true,
  }) async {
    if (ArrayUtil.checkIndexArray(list: value.point, index: layer)) {
      value.point[layer].add(object);
    } else {
      value.point.add([object]);
    }

    if (ArrayUtil.checkIndexArray(
        list: value.listPointPolyline, index: layer)) {
      value.listPointPolyline[layer].add(object.latLng);
    } else {
      value.listPointPolyline.add([object.latLng]);
    }

    if (value.isMarker) {
      if (checkMarkerid(layer: layer, markerId: markerId))
        await changePositionMarker(
          markerId: getMarkerId(
            layer: layer,
            markerId: markerId,
          ),
          objectData: object,
        );
      else
        await generateMarker(
          layer: layer,
          objec: object,
          markerName: getMarkerId(
            layer: layer,
            markerId: markerId,
          ),
        );
    }

    if (value.isPolyline) {
      if (checkPolylineId(layer: layer))
        await changePolyline(layer: layer, patern: patern);
      else
        await generatePolyLines(layer: layer, patern: patern);
    }

    if (value.isPolygon) {
      if (checkPolygonId(layer: layer))
        await changePolygon(layer: layer);
      else
        await generatePolygons(layer: layer);
    }

    if (object.latLng != null && animateCamera == true) {
      if (moveCamera) {
        newCameraPosition(
          latLng: object.latLng,
          zoom: value.zoom,
        );
      }
    }

    if (notifyListiner == true) {
      commit();
    }
  }

  Future<void> removeLastPoint({
    int layer = 0,
    bool animateCamera = true,
    bool createMarker = true,
    bool notifyListiner = true,
    List<PatternItem> patern,
    String markerId,
  }) async {
    removeAllLastData();
    if (totalPointPolyline(index: layer) > 0) {
      if (value.isMarker) {
        if (checkMarkerid(layer: layer, markerId: markerId)) {
          await changePositionMarker(
            markerId: getMarkerId(
              layer: layer,
              markerId: markerId,
            ),
            objectData: value.point[layer].last,
          );
        } else {
          await generateMarker(
            layer: layer,
            objec: value.point[layer].last,
            markerName: getMarkerId(
              layer: layer,
              markerId: markerId,
            ),
          );
        }
      }

      if (value.isPolyline) {
        if (checkPolylineId(layer: layer)) {
          await changePolyline(layer: layer, patern: patern);
        } else {
          await generatePolyLines(layer: layer, patern: patern);
        }
      }

      if (value.isPolygon) {
        if (checkPolygonId(layer: layer)) {
          await changePolygon(layer: layer);
        } else {
          await generatePolygons(layer: layer);
        }
      }

      if (animateCamera) {
        if (value.point[layer].last.latLng != null && animateCamera == true) {
          newCameraPosition(
            latLng: value.point[layer].last.latLng,
            zoom: value.zoom,
          );
        }
      }
    }
    if (notifyListiner == true) {
      commit();
    }
  }

  Future<void> editPoint({
    @required int index,
    @required ObjectData pointData,
    int layer = 0,
    bool animateCamera = true,
    bool notifyListiner = true,
    List<PatternItem> patern,
    bool createMarker = true,
    bool reCreateMarker = false,
  }) async {
    value.point[layer][index] = pointData;
    value.listPointPolyline[layer][index] = pointData.latLng;
    value.listPointPolygon[layer][index] = pointData.latLng;

    if (value.isMarker) {
      if (checkMarkerid(
        markerId: pointData.markerId ?? index.toString(),
        layer: layer,
      ))
        await changePositionMarker(
          markerId: getMarkerId(
            layer: layer,
            markerId: pointData.markerId ?? index.toString(),
          ),
          objectData: pointData,
        );
      else
        await generateMarker(
          layer: layer,
          objec: pointData,
          markerName: getMarkerId(
            layer: layer,
            markerId: pointData.markerId ?? index.toString(),
          ),
        );
    }

    if (value.isPolyline) {
      if (checkPolylineId(layer: layer)) {
        await changePolyline(layer: layer, patern: patern);
      } else {
        await generatePolyLines(layer: layer, patern: patern);
      }
    }

    if (value.isPolygon) {
      if (checkPolygonId(layer: layer)) {
        await changePolygon(
          layer: layer,
        );
      } else {
        await generatePolygons(
          layer: layer,
        );
      }
    }

    if (pointData.latLng != null && animateCamera == true) {
      newCameraPosition(
        latLng: pointData.latLng,
        zoom: value.zoom,
      );
    }
    commit();
  }

  // --------------------------------------------------------------------------
  // position
  newCameraPosition({LatLng latLng, double zoom}) {
    value.controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng ?? value.latLng,
          zoom: zoom ?? value.zoom,
        ),
      ),
    );
    commit();
  }

  void gotoPosition({LatLng latLng, double zoom}) {
    newCameraPosition(latLng: latLng, zoom: zoom);
  }

  void onMapCreated(GoogleMapController controller) {
    value.controller = controller;
    value.mapIsReady = true;
    if (value.onMapReady != null) {
      value.onMapReady(this);
    }
    commit();
  }

  void updateCameraPosition(CameraPosition position) {
    value.zoom = position.zoom;
    value.latLng = position.target;
    value.tilt = position.tilt;
    value.bearing = position.bearing;
    value.center = value.latLng;
    value.cameraPosition = position;
    commit();
  }

  CameraPosition cameraPosition() {
    value.cameraPosition = CameraPosition(
      target: value.latLng,
      zoom: value.zoom,
    );
    commit();
    return value.cameraPosition;
  }

  // ------------------------------------------------------------------
  // marker

  Future<Uint8List> getBytesFrom({
    bool fromAssets = true,
    String path,
    int width = 200,
  }) async {
    if (fromAssets) {
      ByteData data = await rootBundle.load(path);
      Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ImageByteFormat.png))
          .buffer
          .asUint8List();
    } else {
      var request = await http.get(Uri(scheme: path));
      var bytes = request.bodyBytes;

      Codec codec = await instantiateImageCodec(bytes.buffer.asUint8List(),
          targetWidth: width);
      FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ImageByteFormat.png))
          .buffer
          .asUint8List();
    }
  }

  // --------------------------------------------------------------------------------
  // ontap marker, polyline and polygon
  Future<void> onMarkerTapped({MarkerId markerId, ObjectData object}) async {
    Uint8List p = await getBytesFrom(
      fromAssets: object.markerIconType == MarkerIconType.Asset ? true : false,
      path: value.primaryIcon,
      width: object.iconSize,
    );

    Uint8List s = await getBytesFrom(
      fromAssets: object.markerIconType == MarkerIconType.Asset ? true : false,
      path: value.secondaryIcon,
      width: object.iconSize,
    );

    final Marker tappedMarker = value.listMarker[markerId];

    if (tappedMarker != null) {
      if (value.listMarker.containsKey(value.markerId)) {
        final Marker resetOld = value.listMarker[value.markerId].copyWith(
          iconParam: BitmapDescriptor.fromBytes(p),
        );
        value.listMarker[value.markerId] = resetOld;
      }
      value.markerId = markerId;
      final Marker newMarker =
          tappedMarker.copyWith(iconParam: BitmapDescriptor.fromBytes(s));
      value.listMarker[markerId] = newMarker;
      commit();
    }
  }

  // ------------------------------------------------------------------------
  // remove
  void removeMarkerById({int layer = 0, String markerId}) {
    value.markerId = MarkerId(getMarkerId(
        layer: layer,
        markerId: markerId ?? (value.point[layer].length - 1).toString()));
    if (value.listMarker.containsKey(value.markerId)) {
      value.listMarker.remove(value.markerId);
    }
    commit();
  }

  void removePolylines({int layer = 0}) {
    value.polylineId = PolylineId(getPolylineId(layer: layer));
    if (value.listPolyline.containsKey(value.polylineId)) {
      value.listPolyline.remove(value.polylineId);
    }
    commit();
  }

  void removePolygon({int layer = 0}) {
    value.polygonId = PolygonId(getPolygonId(layer: layer));
    if (value.listPolygon.containsKey(value.polygonId)) {
      value.listPolygon.remove(value.polygonId);
    }
    commit();
  }

  void removeAll() {
    removeAllMarker();
    removeAllCircle();
    removeAllPolyline();
    removeAllPolygon();
  }

  void removeLayer({int layer = 0}) {
    removePoint(layer: layer);
    removePointPolyline(layer: layer);
    removePointPolygon(layer: layer);
    removePointCricle(layer: layer);
    commit();
  }

  void removeCricleByLayer({int layer = 0}) {
    int i = 0;
    getAllCirle[layer].forEach(
      (e) {
        value.cirleId = CircleId(
            getCircleId(layer: layer, circleId: e.markerId ?? i.toString()));
        if (value.listCircle.containsKey(value.cirleId)) {
          ModeUtil.debugPrint("ketemu circle id ${value.cirleId}");
          value.listCircle.remove(value.cirleId);
        }
        i++;
        commit();
      },
    );
  }

  void removeMarkerByLayer({int layer = 0}) {
    int i = 0;
    getAllPoint[layer].forEach(
      (e) {
        value.markerId = MarkerId(
            getMarkerId(layer: layer, markerId: e.markerId ?? i.toString()));
        if (value.listMarker.containsKey(value.markerId)) {
          ModeUtil.debugPrint("ketemu marker id ${value.markerId}");
          value.listMarker.remove(value.markerId);
        }
        i++;
        commit();
      },
    );
  }

  void removeAllMarker() {
    value.listMarker.clear();
    commit();
  }

  void removeAllCircle() {
    value.listCircle.clear();
    commit();
  }

  void removeAllPolyline() {
    value.listPolyline.clear();
    commit();
  }

  void removeAllPolygon() {
    value.listPolygon.clear();
    commit();
  }

  void removePoint({int layer = 0}) {
    if (layer == null) {
      value.point.clear();
      removeAllPolyline();
    } else {
      removeMarkerByLayer(layer: layer);
      value.point[layer].clear();
    }
    commit();
  }

  void removePointCricle({int layer = 0}) {
    if (layer == null) {
      value.listPointCircle.clear();
      removeAllPolyline();
    } else {
      removeCricleByLayer(layer: layer);
      value.listPointCircle[layer].clear();
    }
    commit();
  }

  void removePointPolyline({int layer}) {
    if (layer == null) {
      value.listPointPolyline.clear();
      removeAllPolyline();
    } else {
      value.listPointPolyline[layer].clear();
      removePolylines(layer: layer);
    }
    commit();
  }

  void removePointPolygon({int layer}) {
    if (layer == null) {
      value.listPointPolygon.clear();
      removeAllPolygon();
    } else {
      value.listPointPolygon[layer].clear();
      removePolygon(layer: layer);
    }
    commit();
  }

  void removeAllPoinId(int index, {int layer = 0}) {
    value.point[layer].removeAt(index);
    value.listPointPolyline[layer].removeAt(index);
    value.listPointPolygon[layer].removeAt(index);
    commit();
  }

  void removeAllLastData({int layer = 0}) {
    value.point[layer].removeLast();
    value.listPointPolyline[layer].removeLast();
    value.listPointPolygon[layer].removeLast();
    commit();
  }

  // -----------------------------------------------------
  // change marker, polyline and polygon
  Future<void> changePositionMarker(
      {String markerId, ObjectData objectData}) async {
    value.markerId = MarkerId("$markerId");
    value.selectedMarker = value.listMarker[value.markerId];

    Uint8List iconMarker = await getBytesFrom(
      fromAssets:
          objectData.markerIconType == MarkerIconType.Asset ? true : false,
      path: objectData.markerIcom ?? value.primaryIcon,
      width: objectData.iconSize ?? 50,
    );

    value.listMarker[value.markerId] = value.selectedMarker.copyWith(
      positionParam: objectData.latLng,
      anchorParam: objectData.anchor,
      rotationParam: objectData.rotation,
      alphaParam: objectData.alpha,
      zIndexParam: objectData.zIndex,
      flatParam: objectData.flat,
      iconParam: BitmapDescriptor.fromBytes(iconMarker),
    );
    commit();
  }

  Future<void> changePolyline({int layer = 0, List<PatternItem> patern}) async {
    value.polylineId = PolylineId(getPolylineId(layer: layer));
    value.selectedPolyline = value.listPolyline[value.polylineId];
    value.listPolyline[value.polylineId] = value.selectedPolyline.copyWith(
        pointsParam:
            value.listPointPolyline[layer].where((f) => f != null).toList(),
        consumeTapEventsParam: true,
        colorParam: value.primaryColor ?? System.data.colorUtil.primaryColor,
        widthParam: 5,
        startCapParam: Cap.squareCap,
        endCapParam: Cap.squareCap,
        geodesicParam: true,
        jointTypeParam: JointType.round,
        patternsParam: patern ??
            [
              PatternItem.dash(40),
              PatternItem.gap(10.0),
            ],
        onTapParam: () {});

    commit();
  }

  Future<void> changePolygon({int layer = 0}) async {
    value.polygonId = PolygonId(getPolygonId(layer: layer));
    value.selectedPolygon = value.listPolygon[value.polygonId];
    value.listPolygon[value.polygonId] = value.selectedPolygon.copyWith(
        pointsParam:
            value.listPointPolygon[layer].where((f) => f != null).toList(),
        consumeTapEventsParam: true,
        strokeWidthParam: 2,
        strokeColorParam:
            value.primaryColor ?? System.data.colorUtil.primaryColor,
        fillColorParam:
            value.primaryColor ?? System.data.colorUtil.primaryColor,
        onTapParam: () {});

    commit();
  }

  // ---------------------------------------------------------------------------------------
  // check polyline polgyon and marker
  bool checkMarkerid({int layer = 0, String markerId}) {
    value.markerId = MarkerId(getMarkerId(markerId: markerId, layer: layer));
    return value.listMarker.containsKey(value.markerId);
  }

  bool checkPolylineId({int layer = 0}) {
    value.polylineId = PolylineId(getPolylineId(layer: layer));
    return value.listPolyline.containsKey(value.polylineId);
  }

  bool checkPolygonId({int layer = 0}) {
    value.polylineId = PolylineId(getPolygonId(layer: layer));
    return value.listPolyline.containsKey(value.polylineId);
  }

  // ---------------------------------------------------------------------------------------------
  // markerid and polylineId
  String getMarkerId({int layer = 0, String markerId}) {
    return "marker_${layer}_$markerId";
  }

  String getCircleId({int layer = 0, String circleId}) {
    return "circle_${layer}_$circleId";
  }

  String getPolylineId({int layer = 0}) {
    return "polyline_$layer";
  }

  String getPolygonId({int layer = 0}) {
    return "polygon_$layer";
  }

  //--------------------------------------------------------------------------------------
  // setting map
  void zoom({bool zoom = true}) {
    if (zoom) {
      value.zoom += 1;
    } else {
      value.zoom -= 1;
    }

    if (value.zoom < 3) {
      value.zoom = 3;
    } else if (value.zoom > 20) {
      value.zoom = 20;
    }
    value.zoom = value.zoom;
    newCameraPosition();
    commit();
  }

  void mapType() {
    if (_mapType == 1) {
      value.mapType = MapType.normal;
    } else if (_mapType == 2) {
      value.mapType = MapType.satellite;
    } else if (_mapType == 3) {
      value.mapType = MapType.hybrid;
    }
    _mapType++;
    if (_mapType > 3) {
      _mapType = 1;
    }
    commit();
  }

  bool trafficEnabled() {
    var a = value.trafficEnabled = !value.trafficEnabled;
    commit();
    return a;
  }

  void changeMapType() {
    if (value.mapType == MapType.normal) {
      value.mapType = MapType.satellite;
    } else if (value.mapType == MapType.satellite) {
      value.mapType = MapType.terrain;
    } else if (value.mapType == MapType.terrain) {
      value.mapType = MapType.hybrid;
    } else {
      value.mapType = MapType.normal;
    }
    commit();
  }

  void rotateGesturesEnabled() {
    value.rotateGesturesEnabled = !value.rotateGesturesEnabled;
    commit();
  }

  set bounds(LatLngBounds bounds) {
    value.bounds = bounds;
    commit();
  }

  Future<void> onTapMaps(LatLng latLng) async {
    value.latLng = latLng;

    ModeUtil.debugPrint("total point ${value.point[0].length}");

    if (value.isMarker) {
      await addPointMarker(pointData: latLng);
    }

    if (value.isPolygon) {
      await addPointPolygon(pointData: latLng);
    }

    if (value.isPolyline) {
      await addPointPolyline(pointData: latLng);
    }

    if (value.isCircle) {
      await addPointCircle(pointData: latLng);
    }

    commit();
  }

  void onLongPressMaps(LatLng latLng) {
    value.latLng = latLng;
    commit();
  }

  // notifyListeners
  void commit() {
    notifyListeners();
  }
}
