import 'package:enerren/app/sample/driver/localData.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/sample/util/ColorUtil.dart';
import 'package:enerren/app/sample/driver/route.dart' as sampleDriverRoute;
import 'package:enerren/app/sample/util/ApiEndPointUtil.dart';

void main() {
  System.data.resource = ResourceUtil.ind();
  System.data.initialRouteName = sampleDriverRoute.RouteName.login;
  System.data.mapRoute = sampleDriverRoute.routes;
  System.data.colorUtil = ColorUtil().sieradColor();
  System.data.apiEndPointUtil = ApiEndPointUtil().sampleApiEndPoint();
  System.data.localData = new LocalData();
}
