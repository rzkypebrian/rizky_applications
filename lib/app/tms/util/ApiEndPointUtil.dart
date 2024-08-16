import 'package:enerren/util/ApiEndPointUtil.dart';

extension ApiEndPointUtilExtension on ApiEndPointUtil {
  ApiEndPointUtil tmsApiEndPoint() {
    this.baseUrl = "http://dev2.enerren.com/TMSApi/api/";
    this.baseUrlDebug = "http://dev2.enerren.com/TMSApi/api/";
    // this.baseUrl = "http://dev2.enerren.com/TMSGeneralApi/api/";
    // this.baseUrlDebug = "http://dev2.enerren.com/TMSGeneralApi/api/";
    // this.baseUrl = "http://dev2.enerren.com/TMSHacacaAPI/api/";
    // this.baseUrlDebug = "http://dev2.enerren.com/TMSHacacaAPI/api/";
    // this.baseUrl = "http://dev.enerren.com/InovaTMSAPI/api/";
    // this.baseUrlDebug = "http://dev.enerren.com/InovaTMSAPI/api/";
    this.loginUrl = "Auth/Driver-login";
    this.changePasswordUrl = "Drivers/createpassword";
    this.changePasswordUrl = "Drivers/changepassword";
    this.getUangJalanListUrl = "UangJalan/getUangJalanList";
    return this;
  }

  ApiEndPointUtil tmsCustomerApiEndPoimt() {
    tmsApiEndPoint();
    this.checkAccountUrl = "Customers/checkusername";
    this.loginUrl = "Auth/customer-login";
    this.createPasswordUrl = "Customers/createpassword";
    this.changePasswordUrl = "Customers/changepassword";
    this.thirdPartyLoginUrl = "Auth/Customers-thirdparty-login";
    return this;
  }

  ApiEndPointUtil tmsTransporterApiEndPoimt() {
    tmsApiEndPoint();
    this.checkAccountUrl = "Transporter/checkusername";
    this.loginUrl = "Auth/transporter-login";
    this.createPasswordUrl = "Transporter/createpassword";
    this.changePasswordUrl = "Transporter/changepassword";
    this.addUangJalanUrl = "UangJalan/addUangJalanByTransporter";
    this.getUangJalanListUrl = "UangJalan/getUangJalanListForTransporter";
    return this;
  }

  ApiEndPointUtil tmsAdminApiEndPoint() {
    tmsApiEndPoint();
    tmsTransporterApiEndPoimt();
    this.loginUrl = "Auth/admin-login";
    this.getTmsListVehicleUrl = "Shipment/getVehicleTransporterAdminList";
    return this;
  }
}
