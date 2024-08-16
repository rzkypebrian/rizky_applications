import 'package:enerren/util/SystemUtil.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorUtil {
  static Future<Position> myLocation() async {
    try {
      Geolocator geolocator = Geolocator();
      bool serviceEnabled = await geolocator.isLocationServiceEnabled();
      if (serviceEnabled == true) {
        return await geolocator.getCurrentPosition();
      } else {
        throw "please allow gps";
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<Placemark> getLocation(double lat, double lon) {
    return Geolocator().placemarkFromCoordinates(lat, lon).then((onValue) {
      return onValue.first;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<String> getAddress(double lat, double lon, {String alt}) {
    return Geolocator().placemarkFromCoordinates(lat, lon).then((onValue) {
      return changeToAddress(onValue.first);
    }).catchError((onError) {
      return alt ?? "${System.data.resource.invalidLocationOnAddress}";
    });
  }

  static String changeToAddress(Placemark place) {
    return "${place.thoroughfare} ${place.subThoroughfare} ${place.subLocality} ${place.locality} ${place.subAdministrativeArea} ${place.administrativeArea} ${place.country} ${place.postalCode}";
  }
}
