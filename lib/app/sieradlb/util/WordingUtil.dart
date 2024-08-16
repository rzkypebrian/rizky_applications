import 'package:enerren/util/SystemUtil.dart';

class WordingUtil {
  static String brokenWordingByShipmentType(String shipmentType) {
    switch (shipmentType) {
      case "DOC":
        return System.data.resource.brokenOrDead;
        break;
      case "HE":
        return System.data.resource.demagedOrBroken;
      default:
        return System.data.resource.brokenOrDead;
        break;
    }
  }
}
