import 'package:enerren/util/ModeUtil.dart';
import 'package:http/http.dart' as http;

class ErrorHandlingUtil {
  static handleApiError(
    dynamic error, {
    String prefix = "",
  }) {
    String _message;
    try {
      http.Response response = error;
      _message =
          "$prefix ${response.body.isNotEmpty ? response.body : response.statusCode}";
    } catch (e) {
      _message = "$prefix $error";
    }
    ModeUtil.debugPrint("error $prefix $_message");
    return _message;
  }
}
