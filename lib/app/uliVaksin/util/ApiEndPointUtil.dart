import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/SystemUtil.dart';

extension ApiEndPointUtilExtension on ApiEndPointUtil {
  ApiEndPointUtil uliVaksinEndPoint() {
    if (System.data.version.split(".")[1] == "2") {
      this.baseUrl = "http://sierad.inovatrack.com/v1/api/";
      this.baseUrlDebug = "http://sierad.inovatrack.com/v1/api/";
    } else {
      this.baseUrl = "http://dev2.enerren.com/SreeyaTMSApi/api/";
      this.baseUrlDebug = "http://dev2.enerren.com/SreeyaTMSApi/api/";
    }
    this.loginUrl = "Auth/Driver-login";
    this.changePasswordUrl = "Drivers/createpassword";
    this.changePasswordUrl = "Drivers/changepassword";
    return this;
  }

  ApiEndPointUtil sieradLBCustomerApiEndPoimt() {
    uliVaksinEndPoint();
    this.checkAccountUrl = "Customers/checkusername";
    this.loginUrl = "Auth/customer-login";
    this.createPasswordUrl = "Customers/createpassword";
    this.changePasswordUrl = "Customers/changepassword";
    this.thirdPartyLoginUrl = "Auth/Customers-thirdparty-login";
    return this;
  }

  ApiEndPointUtil uliVaksinTransporterEndPoint() {
    uliVaksinEndPoint();
    this.checkAccountUrl = "Transporter/checkusername";
    this.loginUrl = "Auth/transporter-login";
    this.createPasswordUrl = "Transporter/createpassword";
    this.changePasswordUrl = "Transporter/changepassword";
    return this;
  }

  ApiEndPointUtil sieradLBAdminApiEndPoint() {
    uliVaksinEndPoint();
    uliVaksinTransporterEndPoint();
    this.loginUrl = "Auth/admin-login";
    this.getTmsListVehicleUrl = "Shipment/getVehicleTransporterAdminList";
    return this;
  }
}
