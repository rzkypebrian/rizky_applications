import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/SystemUtil.dart';

extension ApiEndPointUtilExtension on ApiEndPointUtil {
  ApiEndPointUtil inovaPickUpDriverApiEndPoint() {
    if (System.data.version.split(".")[1] == "2") {
      this.baseUrl = "http://dev2.enerren.com/PeopleTransportApiDriver/api/";
      this.baseUrlDebug =
          "http://dev2.enerren.com/PeopleTransportApiDriver/api/";
    } else {
      this.baseUrl = "http://dev2.enerren.com/PeopleTransportApiDriver/api/";
      this.baseUrlDebug =
          "http://dev2.enerren.com/PeopleTransportApiDriver/api/";
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

  ApiEndPointUtil inovaPickUpCustomerApiEndPoint() {
    inovaPickUpDriverApiEndPoint();
    if (System.data.version.split(".")[1] == "2") {
      this.baseUrl = "http://dev2.enerren.com/PeopleTransportApiCustomer/api/";
      this.baseUrlDebug =
          "http://dev2.enerren.com/PeopleTransportApiCustomer/api/";
    } else {
      this.baseUrl = "http://dev2.enerren.com/PeopleTransportApiCustomer/api/";
      this.baseUrlDebug =
          "http://dev2.enerren.com/PeopleTransportApiCustomer/api/";
    }
    this.changePasswordUrl = "Customers/changepassword";
    this.createPasswordUrl = "Customers/createpassword";
    this.loginUrl = "Auth/customer-login";
    this.validatePhoneNumberUrl = "Customers/SendOtpRegister";
    this.checkAccountUrl = "Customers/checkusername";
    this.setRatingUrl = "Shipment/giveDriverRating";

    return this;
  }

  ApiEndPointUtil inovaPickUpTransporterEndPoint() {
    inovaPickUpDriverApiEndPoint();
    if (System.data.version.split(".")[1] == "2") {
      this.baseUrl =
          "http://dev2.enerren.com/PeopleTransportApiTransporter/api/";
      this.baseUrlDebug =
          "http://dev2.enerren.com/PeopleTransportApiTransporter/api/";
    } else {
      this.baseUrl =
          "http://dev2.enerren.com/PeopleTransportApiTransporter/api/";
      this.baseUrlDebug =
          "http://dev2.enerren.com/PeopleTransportApiTransporter/api/";
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
