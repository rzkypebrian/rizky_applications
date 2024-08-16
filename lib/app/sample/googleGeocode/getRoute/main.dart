import 'package:enerren/app/sample/googleGeocode/getRoute/localData.dart';
import 'package:enerren/util/SystemUtil.dart';

import 'route.dart' as route;

Future main() {
  System.data.initialRouteName = route.RouteName.origin;
  System.data.mapRoute = route.routes;
  System.data.localData = LocalData();
  return null;
}
