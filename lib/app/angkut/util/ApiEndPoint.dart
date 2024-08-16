import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/SystemUtil.dart';

extension ApiEndPointUtilExtension on ApiEndPointUtil {
  ApiEndPointUtil angkutDriverApiEndPoint() {
    if (System.data.version.split(".")[1] == "2") {
      this.baseUrl = "http://api.angkut.com/v1.0/angkutapidriver/api/";
      this.baseUrlDebug = "http://api.angkut.com/v1.0/angkutapidriver/api/";
    } else if (System.data.version.split(".")[1] == "3") {
      this.baseUrl = "https://api.angkut.com/v1.0/angkutapidriver/api/";
      this.baseUrlDebug = "https://api.angkut.com/v1.0/angkutapidriver/api/";
    } else {
      this.baseUrl = "http://dev2.enerren.com/AngkutAPIDriver/api/";
      this.baseUrlDebug = "http://dev2.enerren.com/AngkutAPIDriver/api/";
    }
    this.checkAccountUrl = "Drivers/checkusername";
    this.loginUrl = "Auth/driver-login";
    this.setVehicleType = "VehicleType/getAllVehicleType";
    this.getUOMListUrl = "Shipment/getUOMList";
    this.getShipmentItemDescriptionUrl = "Shipment/getShipmentItemDescription";
    this.addShipmentItemDescriptionUrl = "Shipment/addShipmentItemDescription";
    this.updateShipmentItemDescriptionUrl =
        "Shipment/updateShipmentItemDescription";
    this.deleteShipmentItemDescriptionUrl =
        "Shipment/deleteShipmentItemDescription";
    this.setPodUrl = "Shipment/setPod";
    this.pickupOrderUrl = "Shipment/pickupOrder";
    this.updateSingleShipmentItemDescriptionUrl =
        "Shipment/updateSingleShipmentItemDescription";
    this.submitDetailPickupOrderUrl = "Shipment/submitDetailPickupOrder";
    this.finishDetailDestinationOrderUrl =
        "Shipment/finishDetailDestinationOrder";
    return this;
  }

  ApiEndPointUtil angkutCustomerApiEndPoint() {
    angkutDriverApiEndPoint();
    if (System.data.version.split(".")[1] == "2") {
      this.baseUrl = "http://api.angkut.com/v1.0/angkutapicustomer/api/";
      this.baseUrlDebug = "http://api.angkut.com/v1.0/angkutapicustomer/api/";
    } else if (System.data.version.split(".")[1] == "3") {
      this.baseUrl = "https://api.angkut.com/v1.0/angkutapicustomer/api/";
      this.baseUrlDebug = "https://api.angkut.com/v1.0/angkutapicustomer/api/";
    } else {
      this.baseUrl = "http://dev2.enerren.com/AngkutAPICustomer/api/";
      this.baseUrlDebug = "http://dev2.enerren.com/AngkutAPICustomer/api/";
    }
    this.changePasswordUrl = "Customers/changepassword";
    this.createPasswordUrl = "Customers/createpassword";
    this.loginUrl = "Auth/customer-login";
    this.validatePhoneNumberUrl = "Customers/SendOtpRegister";
    this.checkAccountUrl = "Customers/checkusername";
    this.setRatingUrl = "Shipment/giveDriverRating";

    return this;
  }

  ApiEndPointUtil angkutTransporterEndPoint() {
    angkutDriverApiEndPoint();
    if (System.data.version.split(".")[1] == "2") {
      this.baseUrl = "http://api.angkut.com/v1.0/angkutapitransporter/api/";
      this.baseUrlDebug =
          "http://api.angkut.com/v1.0/angkutapitransporter/api/";
    } else if (System.data.version.split(".")[1] == "3") {
      this.baseUrl = "https://api.angkut.com/v1.0/angkutapitransporter/api/";
      this.baseUrlDebug =
          "https://api.angkut.com/v1.0/angkutapitransporter/api/";
    } else {
      this.baseUrl = "http://dev2.enerren.com/AngkutAPITransporter/api/";
      this.baseUrlDebug = "http://dev2.enerren.com/AngkutAPITransporter/api/";
    }
    this.loginUrl = "Auth/transporter-login";
    this.getUangJalanListUrl = "UangJalan/getUangJalanList";
    this.addUangJalanUrl = "UangJalan/addUangJalan";
    this.changePasswordUrl = "Transporter/changepassword";
    this.checkAccountUrl = "Transporter/checkusername";
    this.createPasswordUrl = "Transporter/createpassword";

    return this;
  }
}
