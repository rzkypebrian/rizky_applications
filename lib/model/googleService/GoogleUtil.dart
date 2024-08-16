import 'GooglePosition.dart';

class GoogleUtil {
  static List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }

  static List<GooglePosition> convertToLatLng(List points) {
    List<GooglePosition> result = <GooglePosition>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(
          GooglePosition(
            lat: points[i - 1],
            lon: points[i],
          ),
        );
      }
    }
    return result;
  }
}
