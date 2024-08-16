import 'package:enerren/util/ApiEndPointUtil.dart';

extension InovatrackApiEndPointUtil on ApiEndPointUtil {
  ApiEndPointUtil inovatrackApi() {
    this.baseUrl = 'https://api.inovatrack.com/v1/api/';
    this.loginUrl = 'Mobile/Login';
    this.getVehicleStatusSummaryUrl = "Mobile/FleetGeneralInformation";
    return this;
  }
}
