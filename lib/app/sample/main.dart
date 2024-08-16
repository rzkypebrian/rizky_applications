import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/sample/util/ColorUtil.dart';
import 'package:enerren/app/sample/driver/route.dart' as sampleDriverRoute;

void main() {
  System.data.resource = ResourceUtil.ind();
  System.data.initialRouteName = sampleDriverRoute.RouteName.login;
  System.data.mapRoute = sampleDriverRoute.routes;
  System.data.colorUtil = ColorUtil().sieradColor();
}
