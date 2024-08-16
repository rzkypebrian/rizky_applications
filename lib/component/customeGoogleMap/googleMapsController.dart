import 'dart:typed_data';
import 'dart:ui';
import 'package:enerren/component/customeGoogleMap/googleMapsValue.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/util/ImageUtil.dart';
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
  List<List<int>> listAdd = [];

  bool get isMapReady => value.mapIsReady;
  bool get getStatusTrafic => value.trafficEnabled;
  List<List<ObjectData>> get getListPoint {
    return value.point;
  }

  int totalPoint({id = 0}) {
    return id == null ? value.point.length : value.point[id].length;
  }

  int totalPointPolyline({id = 0}) {
    return value.point[id].where((f) => f.latLng != null).toList().length;
  }

  CameraPosition cameraPosition() {
    return CameraPosition(
      target: value.latLng,
      zoom: value.zoom,
    );
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
    value.centerMap(value.latLng);
    commit();
  }

  void onTapMaps(LatLng latLng) {
    value.latLng = latLng;
    commit();
  }

  void onLongPressMaps(LatLng latLng) {
    value.latLng = latLng;
    commit();
  }

  void clear() {
    commit();
  }

  // Future<void> addPolyLine({int id = 0, List<PatternItem> patern}) async {
  //   removePolylines(id: id);
  //   if (value.polyLineSetting[id] == false) return;

  //   List<LatLng> po = <LatLng>[];

  //   for (var i = 0; i < value.point[id].length; i++) {
  //     if (value.point[id][i].latLng != null) {
  //       po.add(value.point[id][i].latLng);
  //       commit();
  //     }
  //   }

  //   String polylineIdVal = 'polyline_$id';
  //   value.polylineId = PolylineId(polylineIdVal);

  //   Polyline polyline = Polyline(
  //     polylineId: value.polylineId,
  //     consumeTapEvents: true,
  //     color: value.primaryColor ?? System.data.colorUtil.primaryColor,
  //     width: 5,
  //     points: po,
  //     startCap: Cap.squareCap,
  //     endCap: Cap.squareCap,
  //     geodesic: true,
  //     jointType: JointType.round,
  //     patterns: patern ??
  //         [
  //           PatternItem.dash(40),
  //           PatternItem.gap(10.0),
  //         ],
  //     onTap: () {
  //       // onPolylineTapped(polylineId);
  //     },
  //   );

  //   value.listPolyline[value.polylineId] = polyline;
  //   commit();
  // }

  Future<void> addPolyLines({int layer = 0, List<PatternItem> patern}) async {
    String polylineIdVal = 'polyline_$layer';
    value.polylineId = PolylineId(polylineIdVal);

    // print("--------create prolyline $polylineIdVal--------------");
    // print("jumlah polyline saat ini ${value.listPolyline.length}");

    // print("pint di layer $id ${value.point[id].length}");
    // print(
    //     "polyline di layer $id ${value.listPointPolyline[id].where((f) => f != null).toList().length}");
    // print("------------------------------------------------------");
    List<ObjectData> validLatLng =
        value.point[layer].where((f) => f.latLng != null).toList();

    Polyline polyline = Polyline(
      polylineId: value.polylineId,
      consumeTapEvents: true,
      color: value.primaryColor ?? System.data.colorUtil.primaryColor,
      width: 5,
      // points: value.listPointPolyline[layer].where((f) => f != null).toList(),
      points: List.generate(validLatLng.length, (i) => validLatLng[i].latLng),
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
        // onPolylineTapped(polylineId);
      },
    );

    value.listPolyline[value.polylineId] = polyline;
    commit();
  }

  Future<void> addPolygons({int layer = 0, @required Color fillColor}) async {
    String polygonIdVal = 'polygon_$layer';
    value.polygonId = PolygonId(polygonIdVal);

    List<ObjectData> validLatLng =
        value.point[layer].where((e) => e.latLng != null).toList();

    Polygon polygon = Polygon(
      polygonId: value.polygonId,
      consumeTapEvents: true,
      points: List.generate(validLatLng.length, (i) => validLatLng[i].latLng),
      strokeWidth: 2,
      strokeColor: value.primaryColor ?? System.data.colorUtil.primaryColor,
      fillColor:
          fillColor ?? value.primaryColor ?? System.data.colorUtil.primaryColor,
      onTap: () {
        ModeUtil.debugPrint("OnTap Polygone");
      },
    );

    value.listPolygon[value.polygonId] = polygon;

    commit();
  }

  Future<void> addCircleSinggle({
    layer = 0,
    ObjectData objec,
    bool userIcon = true,
    String markerName,
    @required double radius,
    @required Color fillColor,
    @required Color strokeColor,
    @required double width,
  }) async {
    if (objec.latLng != null) {
      String circleIdVal =
          '${(markerName == null ? getMarkerId(layer: layer, markerId: (value.point[layer].length - 1).toString()) : markerName)}';

      CircleId circleId = CircleId(circleIdVal);

      Circle circle = Circle(
        circleId: circleId,
        center: objec.latLng,
        radius: radius,
        fillColor: fillColor ??
            value.secondColor ??
            System.data.colorUtil.secondaryColor,
        strokeWidth: width ?? value.width,
        strokeColor: strokeColor ??
            value.primaryColor ??
            System.data.colorUtil.primaryColor,
      );
      value.listCircle[circleId] = circle;
      commit();
    }
  }

  void changePoint(List<ObjectData> point, {int layer}) {
    value.point[layer] = point;
    commit();
  }

  Future<void> addPoint({
    ObjectData pointData,
    int layer = 0,
    bool animateCamera = true,
    bool notifyListiner = true,
    List<PatternItem> patern,
    bool createMarker = true,
    // String markerId,
    bool showPolyLine = true,
    bool showPolygon = false,
    Color polygonFillColor,
    //all about circle
    bool createCircle = false,
    double circleRadius,
    Color circleFillColor,
    Color circleStrokeColor,
    double circleWidth,
  }) async {
    // if (ArrayUtil.checkIndexArray(list: value.point, index: id)) {
    value.point[layer].add(pointData);
    value.showPolylineSetting[layer] = showPolyLine;
    value.paternPolylineSetting[layer] = patern;
    value.showPolygonSetting[layer] = showPolygon;
    value.fillColorPolygonSetting[layer] = polygonFillColor;

    // } else {
    //   value.point.add([object]);
    // }

    // if (ArrayUtil.checkIndexArray(list: value.listPointPolyline, index: id)) {
    // value.listPointPolyline[layer].add(pointData.latLng);
    // } else {
    //   value.listPointPolyline.add([object.latLng]);
    // }

    if (createMarker) {
      if (checkMarkerid(
        layer: layer,
        // markerId: markerId,
        markerId: pointData.markerId ?? value.point[layer].length.toString(),
      )) {
        await changePositionMarker(
          markerId: getMarkerId(
              layer: layer,
              // markerId: markerId,
              markerId: pointData.markerId ?? value.point[layer].length),
          objectData: pointData,
        );
      } else {
        await addMarkerSingle(
          layer: layer,
          objec: pointData,
          markerName: getMarkerId(
            layer: layer,
            // markerId: markerId,
            markerId:
                pointData.markerId ?? value.point[layer].length.toString(),
          ),
        );
      }
    }

    if (createCircle) {
      if (checkCircleid(
        layer: layer,
        // markerId: markerId,
        markerId: pointData.markerId ?? value.point[layer].length.toString(),
      )) {
        await changePositionCircle(
          markerId: getMarkerId(
              layer: layer,
              // markerId: markerId,
              markerId:
                  pointData.markerId ?? value.point[layer].length.toString()),
          objectData: pointData,
          fillColor: circleFillColor,
          radius: circleRadius,
          stroke: circleWidth,
          strokeColor: circleStrokeColor,
        );
      } else {
        await addCircleSinggle(
          layer: layer,
          objec: pointData,
          markerName: getMarkerId(
            layer: layer,
            // markerId: markerId,
            markerId:
                pointData.markerId ?? value.point[layer].length.toString(),
          ),
          fillColor: circleFillColor,
          radius: circleRadius,
          width: circleWidth,
          strokeColor: circleStrokeColor,
        );
      }
    }

    if (value.showPolylineSetting[layer]) {
      if (checkPolylineId(layer: layer)) {
        await changePolyline(
            layer: layer, patern: value.paternPolylineSetting[layer]);
      } else {
        await addPolyLines(
            layer: layer, patern: value.paternPolylineSetting[layer]);
      }
    }

    if (value.showPolygonSetting[layer]) {
      if (checkPolygonId(layer: layer)) {
        await changePolygon(
            layer: layer, fillColor: value.fillColorPolygonSetting[layer]);
      } else {
        await addPolygons(
            layer: layer, fillColor: value.fillColorPolygonSetting[layer]);
      }
    }

    if (pointData.latLng != null && animateCamera == true) {
      if (animateCamera) {
        newCameraPosition(
          latLng: pointData.latLng,
          zoom: value.zoom,
        );
      }
    }

    //---------------old function-----------//

    // if (notifyListiner == true) {
    //   commit();
    // }

    // value.point[id].add(object);
    // if (createMarker == true) {
    //   await addMarkerSingle(
    //     id: id,
    //     objec: object,
    //     markerName: markerId,
    //   );
    // }
    // addPolyLine(id: 0, patern: patern);
    // if (object.latLng != null && animateCamera == true) {
    //   newCameraPosition(
    //     latLng: object.latLng,
    //     zoom: value.zoom,
    //   );
    // }
    // if (notifyListiner == true) {
    //   commit();
    // }

    //---------------old function-----------//
  }

  Future<void> removeLastPoint({
    int layer = 0,
    bool animateCamera = true,
    bool createMarkerOnLastPolyLine = true,
    bool notifyListiner = true,
    List<PatternItem> patern,
    String markerId,
    bool showPolyLine,
    bool showPolygon,
    Color polygonFillColor,
  }) async {
    //update setting
    if (showPolyLine != null) value.showPolylineSetting[layer] = showPolyLine;
    if (patern != null) value.paternPolylineSetting[layer] = patern;
    if (showPolygon != null) value.showPolygonSetting[layer] = showPolygon;
    if (polygonFillColor != null)
      value.fillColorPolygonSetting[layer] = polygonFillColor;

    ObjectData lastData = value.point[layer].last;
    removeMarkerById(
        layer: layer,
        markerId: lastData.markerId ?? value.point[layer].length.toString());
    removeLastData();
    if (totalPointPolyline(id: layer) > 0) {
      if (createMarkerOnLastPolyLine) {
        if (checkMarkerid(layer: layer, markerId: markerId)) {
          await changePositionMarker(
            markerId: getMarkerId(
              layer: layer,
              markerId: markerId,
            ),
            objectData: value.point[layer].last,
          );
        } else {
          await addMarkerSingle(
            layer: layer,
            objec: value.point[layer].last,
            markerName: getMarkerId(
              layer: layer,
              markerId: markerId,
            ),
          );
        }
      }
      if (value.showPolygonSetting[layer]) {
        if (checkPolylineId(layer: layer)) {
          await changePolyline(
              layer: layer, patern: value.paternPolylineSetting[layer]);
        } else {
          await addPolyLines(
              layer: layer, patern: value.paternPolylineSetting[layer]);
        }
      }
      if (value.showPolygonSetting[layer]) {
        if (checkPolygonId(layer: layer)) {
          await changePolygon(
              layer: layer, fillColor: value.fillColorPolygonSetting[layer]);
        } else {
          await addPolygons(
              layer: layer, fillColor: value.fillColorPolygonSetting[layer]);
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
    // String markerId,
    bool showPolyLine,
    bool showPolygon,
    Color polygonFillColor,
  }) async {
    if (pointData != null) value.point[layer][index] = pointData;
    if (showPolyLine != null) value.showPolylineSetting[layer] = showPolyLine;
    if (patern != null) value.paternPolylineSetting[layer] = patern;
    if (showPolygon != null) value.showPolygonSetting[layer] = showPolygon;
    if (polygonFillColor != null)
      value.fillColorPolygonSetting[layer] = polygonFillColor;

    // value.listPointPolyline[layer][index] = pointData.latLng;

    if (createMarker == true) if (checkMarkerid(
      // markerId: markerId ?? index.toString(),
      markerId: pointData.markerId ?? index.toString(),
      layer: layer,
    )) {
      await changePositionMarker(
        markerId: getMarkerId(
          layer: layer,
          // markerId: markerId ?? index.toString(),
          markerId: pointData.markerId ?? index.toString(),
        ),
        objectData: pointData,
      );
    } else {
      if (reCreateMarker == true) {
        // print(
        //     "create marker ${getMarkerId(layer: layer, markerId: pointData.markerId ?? index.toString())}");
        await addMarkerSingle(
          layer: layer,
          objec: pointData,
          // markerName: markerId ?? index.toString(),
          markerName: getMarkerId(
            layer: layer,
            markerId: pointData.markerId ?? index.toString(),
          ),
        );
      } else {
        ModeUtil.debugPrint("marker id not found");
      }
    }

    // addPolyLine(id: id);
    if (value.showPolylineSetting[layer]) {
      if (checkPolylineId(layer: layer)) {
        await changePolyline(
            layer: layer, patern: value.paternPolylineSetting[layer]);
      } else {
        await addPolyLines(
            layer: layer, patern: value.paternPolylineSetting[layer]);
      }
    }
    if (value.showPolygonSetting[layer]) {
      if (checkPolygonId(layer: layer)) {
        await changePolygon(
            layer: layer, fillColor: value.fillColorPolygonSetting[layer]);
      } else {
        await addPolygons(
            layer: layer, fillColor: value.fillColorPolygonSetting[layer]);
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

  Future<void> newCameraPosition(
      {LatLng latLng, double zoom, bool animate = true}) async {
    if (animate) {
      await value.controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng ?? value.latLng,
            zoom: zoom ?? value.zoom,
          ),
        ),
      );
    } else {
      await value.controller.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng ?? value.latLng,
            zoom: zoom ?? value.zoom,
          ),
        ),
      );
    }
  }

  void gotoPosition({LatLng latLng, double zoom, bool animate}) {
    newCameraPosition(
      latLng: latLng,
      zoom: zoom,
      animate: animate,
    ).then((onValue) {
      value.center = latLng;
      commit();
    });
  }

  Future<Uint8List> generateIconMarker({
    MarkerIconType markerIconType = MarkerIconType.Asset,
    String markerIcon,
    int width = 200,
    TextStyle textStyle,
  }) async {
    switch (markerIconType) {
      case MarkerIconType.Asset:
        ByteData data = await rootBundle.load(markerIcon);
        Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
            targetWidth: width);
        FrameInfo fi = await codec.getNextFrame();
        return (await fi.image.toByteData(format: ImageByteFormat.png))
            .buffer
            .asUint8List();
        break;

      case MarkerIconType.Network:
        var request = await http.get(Uri(scheme: markerIcon));
        var bytes = request.bodyBytes;

        Codec codec = await instantiateImageCodec(bytes.buffer.asUint8List(),
            targetWidth: width);
        FrameInfo fi = await codec.getNextFrame();
        return (await fi.image.toByteData(format: ImageByteFormat.png))
            .buffer
            .asUint8List();
        break;

      case MarkerIconType.Text:
        return await ImageUtil.createLabelImage(
          text: markerIcon,
          backgroundColor: Colors.white,
          textStyle: textStyle,
        ).then(
          (value) {
            return value.buffer.asUint8List();
          },
        ).catchError((onError) {
          return null;
        });
      default:
        return null;
        break;
    }
  }

  Future<void> addMarkerSingle({
    layer = 0,
    ObjectData objec,
    bool userIcon = true,
    String markerName,
  }) async {
    if (objec.latLng != null) {
      String markerIdVal =
          '${(markerName == null ? getMarkerId(layer: layer, markerId: (value.point[layer].length - 1).toString()) : markerName)}';

      // print("add marker $markerIdVal");

      MarkerId markerId = MarkerId(markerIdVal);
      // onMarkerTapped(markerId: null, object: objec);

      Uint8List iconMarker = await generateIconMarker(
        markerIcon: objec.markerIcon ?? value.primaryIcon,
        width: objec.iconSize ?? 50,
        markerIconType: objec.markerIconType ?? MarkerIconType.Asset,
        textStyle: objec.markerIconTextStyle,
      );

      Marker marker = Marker(
        markerId: markerId,
        position: objec.latLng,
        infoWindow: InfoWindow(
          title: objec.name,
          snippet: objec.snipset,
        ),
        onTap: () {
          // onMarkerTapped(markerId: markerId, object: objec);
          if (objec.onTapMarker != null) {
            objec.onTapMarker();
          } else {
            value.onTapMarker(objec);
          }
          commit();
        },
        onDragEnd: (LatLng position) {},
        icon: BitmapDescriptor.fromBytes(iconMarker),
        rotation: objec.rotation,
        alpha: objec.alpha,
        zIndex: objec.zIndex + 1,
        // objec.zIndex == 0 || objec.zIndex == null ? layer : objec.zIndex,
        anchor: objec.anchor,
        flat: objec.flat,
      );

      value.listMarker[markerId] = marker;
      commit();

      value.listMarker[markerId] = marker.copyWith(
        anchorParam: objec.anchor,
      );
      commit();
    }
  }

  Future<void> onMarkerTapped({MarkerId markerId, ObjectData object}) async {
    Uint8List p = await generateIconMarker(
      // fromAssets: object.markerIconType == MarkerIconType.Asset ? true : false,
      markerIcon: object.markerIcon ?? value.primaryIcon,
      width: object.iconSize ?? 50,
      markerIconType: object.markerIconType ?? MarkerIconType.Asset,
      textStyle: object.markerIconTextStyle,
    );

    Uint8List s = await generateIconMarker(
      // fromAssets: object.markerIconType == MarkerIconType.Asset ? true : false,
      markerIcon: object.markerIconSelected ?? value.secondaryIcon,
      width: object.iconSize ?? 50,
      markerIconType: object.markerIconType ?? MarkerIconType.Asset,
      textStyle: object.markerIconTextStyle,
    );

    final Marker tappedMarker = value.listMarker[markerId];

    if (value.markerId != null) {
      if (value.listMarker.containsKey(value.markerId)) {
        final Marker resetOld = value.listMarker[value.markerId].copyWith(
          iconParam: BitmapDescriptor.fromBytes(p),
        );
        value.listMarker[value.markerId] = resetOld;
      }
    }

    value.markerId = markerId;
    value.selected = object;

    if (markerId != null) {
      final Marker newMarker =
          tappedMarker.copyWith(iconParam: BitmapDescriptor.fromBytes(s));
      value.listMarker[markerId] = newMarker;
      commit();
    }
  }

  void rotateGesturesEnabled() {
    value.rotateGesturesEnabled = !value.rotateGesturesEnabled;
    commit();
  }

  // remove
  void removeMarkerById({int layer = 0, String markerId}) {
    value.markerId = MarkerId(getMarkerId(layer: layer, markerId: markerId));
    if (value.listMarker.containsKey(value.markerId)) {
      value.listMarker.remove(value.markerId);
    }
    commit();
  }

  void removePolylines({int layer}) {
    value.polylineId = PolylineId("polyline_$layer");
    if (value.listPolyline.containsKey(value.polylineId)) {
      value.listPolyline.remove(value.polylineId);
    }
    value.polylineId = null;
    commit();
  }

  void removePolygon({int layer}) {
    value.polygonId = PolygonId("polygon_$layer");
    if (value.listPolygon.containsKey(value.polygonId)) {
      value.listPolygon.remove(value.polygonId);
    }
    value.polygonId = null;
    commit();
  }

  void removeCircleById({int layer = 0, String markerId}) {
    value.circleId = CircleId(getMarkerId(layer: layer, markerId: markerId));
    if (value.listCircle.containsKey(value.markerId)) {
      value.listCircle.remove(value.markerId);
    }
    commit();
  }

  void removeAll() {
    removeAllMarker();
    removeAllPolyline();
    removeAllPolygon();
    removeAllCircle();
    removeAllPoint();
  }

  void removeMarkerByLayer({int layer = 0}) {
    int i = 0;
    getListPoint[layer].forEach(
      (e) {
        value.listMarker.remove(MarkerId(
            getMarkerId(layer: layer, markerId: e.markerId ?? i.toString())));
        i++;
      },
    );
    // value.listMarker.clear();
    commit();
  }

  void removeAllMarker() {
    value.listMarker.clear();
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

  void removeCircleByLayer({int layer = 0}) {
    int i = 0;
    getListPoint[layer].forEach(
      (e) {
        value.listCircle.remove(MarkerId(
            getMarkerId(layer: layer, markerId: e.markerId ?? i.toString())));
        i++;
      },
    );
    // value.listMarker.clear();
    commit();
  }

  void removeAllCircle() {
    value.listCircle.clear();
    commit();
  }

  void removeAllPoint() {
    value.point = [];
    commit();
  }

  void removePoint(
    int layer,
    int index,
  ) async {
    value.point
        .removeAt(layer ?? value.selectedLayer)
        .removeAt(index ?? value.selectedIndex);
    //re create polyline
    if ((value.showPolylineSetting[layer] ?? false) == true) {
      if (checkPolylineId(layer: layer)) {
        await changePolyline(
            layer: layer, patern: value.paternPolylineSetting[layer]);
      } else {
        await addPolyLines(
            layer: layer, patern: value.paternPolylineSetting[layer]);
      }
    }
    //re create polygon
    if ((value.showPolygonSetting[layer] ?? false) == true) {
      if (checkPolygonId(layer: layer)) {
        await changePolygon(
            layer: layer, fillColor: value.fillColorPolygonSetting[layer]);
      } else {
        await addPolygons(
            layer: layer, fillColor: value.fillColorPolygonSetting[layer]);
      }
    }
  }

  void removePoinId(int index, {int layer = 0}) {
    // print(
    //     "remove marker ${getMarkerId(layer: layer, markerId: value.point[layer][index].markerId ?? index.toString())}");
    removeMarkerById(
      layer: layer,
      markerId: getMarkerId(
        layer: layer,
        markerId: value.point[layer][index].markerId ?? index.toString(),
      ),
    );
    value.point[layer].removeAt(index);
    // value.listPointPolyline[layer].removeAt(index);
    commit();
  }

  void removeLastData({int layer = 0}) {
    value.point[layer].removeLast();
    // value.listPointPolyline[layer].removeLast();
    commit();
  }

  void removeLayer({int layer = 0}) {
    removePolylines(layer: layer);
    removeMarkerByLayer(layer: layer);
    removeMarkerByLayer(layer: layer);
    removePolygon(layer: layer);
    value.point[layer] = [];
    // value.listPointPolyline[layer] = [];
    commit();
  }

  // change marker and polyline
  Future<void> changePositionMarker({
    String markerId,
    ObjectData objectData,
  }) async {
    value.markerId = MarkerId("$markerId");
    value.selectedMarker = value.listMarker[value.markerId];
    value.selected = objectData;

    Uint8List iconMarker = await generateIconMarker(
      // fromAssets:  objectData.markerIconType == MarkerIconType.Asset ? true : false,
      markerIcon: objectData.markerIcon ?? value.primaryIcon,
      width: objectData.iconSize ?? 50,
      markerIconType: objectData.markerIconType ?? MarkerIconType.Asset,
      textStyle: objectData.markerIconTextStyle,
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
    List<ObjectData> validLatLng =
        value.point[layer].where((e) => e.latLng != null).toList();

    value.polylineId = PolylineId('polyline_$layer');
    value.selectedPolyline = value.listPolyline[value.polylineId];
    value.listPolyline[value.polylineId] = value.selectedPolyline.copyWith(
        // pointsParam:
        //     value.listPointPolyline[layer].where((f) => f != null).toList(),
        pointsParam:
            List.generate(validLatLng.length, (i) => validLatLng[i].latLng),
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

  Future<void> changePolygon({int layer = 0, @required Color fillColor}) async {
    List<ObjectData> validLatLng =
        value.point[layer].where((e) => e.latLng != null).toList();

    value.polygonId = PolygonId('polygon_$layer');
    value.selectedPolygon = value.listPolygon[value.polygonId];
    value.listPolygon[value.polygonId] = value.selectedPolygon.copyWith(
        // pointsParam:
        //     value.listPointPolyline[layer].where((f) => f != null).toList(),
        pointsParam:
            List.generate(validLatLng.length, (i) => validLatLng[i].latLng),
        consumeTapEventsParam: true,
        strokeColorParam: value.primaryColor,
        strokeWidthParam: 5,
        fillColorParam: fillColor,
        geodesicParam: true,
        onTapParam: () {});

    commit();
  }

  Future<void> changePositionCircle({
    String markerId,
    ObjectData objectData,
    @required Color fillColor,
    @required Color strokeColor,
    @required double radius,
    @required double stroke,
  }) async {
    value.circleId = CircleId("$markerId");
    value.selectedCircle = value.listCircle[value.circleId];
    value.selected = objectData;

    value.listCircle[value.circleId] = value.selectedCircle.copyWith(
      centerParam: objectData.latLng,
      fillColorParam: fillColor ??
          value.secondColor ??
          value.selectedCircle.fillColor ??
          System.data.colorUtil.secondaryColor,
      radiusParam: radius ?? value.selectedCircle.radius,
      strokeWidthParam:
          stroke ?? value.selectedCircle.strokeWidth ?? value.width,
      strokeColorParam: strokeColor ??
          value.selectedCircle.strokeColor ??
          value.primaryColor ??
          System.data.colorUtil.primaryColor,
    );
    commit();
  }

  // controller map
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

  // check poly and marker
  bool checkMarkerid({int layer = 0, String markerId}) {
    var _markerId = MarkerId("marker_${layer}_$markerId");
    return value.listMarker.containsKey(_markerId);
  }

  bool checkCircleid({int layer = 0, String markerId}) {
    var _markerId = MarkerId("marker_${layer}_$markerId");
    return value.listCircle.containsKey(_markerId);
  }

  bool checkPolylineId({int layer = 0}) {
    var _polylineId = PolylineId("polyline_$layer");
    return value.listPolyline.containsKey(_polylineId);
  }

  bool checkPolygonId({int layer = 0}) {
    var _polygonId = PolygonId("polygon_$layer");
    return value.listPolygon.containsKey(_polygonId);
  }

  // markerid and polylineId
  String getMarkerId({int layer = 0, String markerId}) {
    try {
      return "marker_${layer}_${int.parse(markerId)}";
    } catch (e) {
      return markerId;
    }
  }

  String getPolylineId({int layer = 0}) {
    return "polyline_$layer";
  }

  set bounds(LatLngBounds bounds) {
    value.bounds = bounds;
    commit();
  }

  // notifyListeners
  void commit() {
    notifyListeners();
  }
}
