import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ModeUtil.dart';

class ApiEndPointUtil {
  String baseUrl = "http://dev.enerren.com/InovaTMSAPI/api/";
  String baseUrlDebug = "http://dev.enerren.com/InovaTMSAPI/api/";
  String vtsBaseUrl = "https://api.inovatrack.com/v1/api/mobile/";
  String vtsBaseUrlDebug = "https://api.inovatrack.com/v1/api/mobile/";
  String checkAccountUrl = "Drivers/checkusername";
  String loginUrl = "Auth/Driver-login";
  String createPasswordUrl = "Drivers/createpassword";
  String changePasswordUrl = "Drivers/changepassword";
  String validatePhoneNumberUrl = "Drivers/SendOtpRegister";
  String setTmsDeliveryPodUrl = "Shipment/setPod";
  String getTmsDeliveryPodUrl = "Shipment/getPod";
  String getTmsLoadingPodUrl = "Shipment/getLoadingPOD";
  String getTmsUnloadingPodUrl = "Shipment/getUnloadingPOD";
  String getTmsDeliveryEmergencyUrl = "Emergency/getemergency";
  String setTmsDeliveryEmergencydUrl = "Emergency/addemergency";
  String getTmsListVehicleUrl = "Shipment/getVehicleTransporterList";
  String setBackToPoolUrl = "Shipment/isBackToPool";
  String setVehicleType = "VehicleType/getAllVehicleType";
  String getAllShipmentUrl = "Shipment/getAllShipment";
  String getOpenedShipmentUrl = "Shipment/getOpenedShipment";
  String getProcessShipmentUrl = "Shipment/getProcessedShipment";
  String getShippedShipmentUrl = "Shipment/getShippedShipment";
  String getFinishedShipmentUrl = "Shipment/getFinishedShipment";
  String getNotYieldShipmentUrl = "Shipment/getNotYetPaidShipment";
  String getCanceledShipmentUrl = "Shipment/getCanceledShipment";
  String getShipmentByShipmentNumberUrl =
      "Shipment/getShipmentByShipmentNumber";
  String getCalculateShipmentUrl = "Shipment/calculatePriceOrder";
  String getAcceptOrderUrl = "Shipment/acceptOrder";
  String getCalculateShipmentPriceOrder = "Shipment/calculatePriceOrder";
  String getRegisterUrl = "Customers/register";
  String getShipmentCreateOrderUrl = "Shipment/createOrder";
  String getShipmentCancleOrderUrl = "Shipment/cancelOrder";
  String pickupOrderUrl = "Shipment/pickupOrder";
  String submitDetailPickupOrderUrl = "Shipment/submitDetailPickupOrder";
  String finishDetailDestinationOrderUrl =
      "Shipment/finishDetailDestinationOrder";
  String getUOMListUrl = "Shipment/getUOMList";
  String setRatingUrl = "Customers/giveRating";
  String getShipmentItemDescriptionUrl = "Shipment/getShipmentItemDescription";
  String addShipmentItemDescriptionUrl = "Shipment/addShipmentItemDescription";
  String updateShipmentItemDescriptionUrl =
      "Shipment/updateShipmentItemDescription";
  String updateSingleShipmentItemDescriptionUrl =
      "Shipment/updateSingleShipmentItemDescription";
  String deleteShipmentItemDescriptionUrl =
      "Shipment/deleteShipmentItemDescription";
  String loadingItemShipmentDescription = "Shipment/getLoadingItemDescription";
  String unloadingItemShipmentDescription =
      "Shipment/getUnloadingItemDescription";
  String setPodUrl = "Shipment/setPod";
  String addVehicleCheckDailyUrl = "Drivers/addVehicleCheckDaily";
  String getVehicleCheckDailyUrl = "Shipment/getVehicleCheckDaily";
  String isShipmentPaidUrl = "Shipment/isShipmentPaid";
  String setShipmentPaidUrl = "Shipment/setShipmentAsPaid";
  String checkVehicleAbsenceDailyUrl = "Drivers/checkVehicleAbsenceDaily";
  String setToRestUrl = "Drivers/setToRest";
  String setToActiveUrl = "Drivers/setToActive";
  String getVtsPositionHistoryUrl = "GetHistory";
  String getVtsAllPositionUrl = "GetVehicles";
  String getVtsVehiclePositionUrl = "GetVehicle";
  String getVtsAllFleetUrl = "GetFleets";
  String driverScoreUrl = "Drivers/getDriverScore";
  String logOutUrl = "Auth/logout";
  String getVehicleStatusSummaryUrl =
      "Shipment/getSummaryVehicleStatusTransporter";
  String confirmWaitingUrl = "Shipment/confirmWaitingOrder";
  String getAllNotificationUrl = "Notification/getAllNotification";
  String getDriverProfileUrl = "Drivers/getDriverInfo";
  String changeDriverProfileUrl = "Drivers/changeprofile";
  String getCustomerProfileUrl = "Customers/getCustomerInfo";
  String updateCustomerProfileUrl = "Customers/changeprofile";
  String getTransporterProfileUrl = "Transporter/getTransporterInfo";
  String getUangJalanListUrl = "UangJalan/getUangJalanList";
  String addUangJalanUrl = "UangJalan/addUangJalan";
  String addUangJalanExpenseUrl = "UangJalan/addUangJalanExpense";
  String deleteUangJalanExpenseUrl = "UangJalan/deleteUangJalanExpense";
  String setFinishUangJalanUrl = "UangJalan/setFinishUangJalan";
  String thirdPartyLoginUrl = "Auth/customer-thirdparty-login";
  String getLocationHistoryUrl = "LocationHistory/getHistoryLocation";
  String addLocationHistoryUrl = "LocationHistory/addHistoryLocation";
  String deleteLocationHistoryUrl = "LocationHistory/deleteHistoryLocation";
  String rejectEmergencyUrl = "Shipment/rejectEmergencyShipment";
  String getAllPaymentMethodUrl = "PaymentMethod/getAllPaymentMethod";
  String paymentGateWayPageUrl =
      "http://payment.angkut.com/v1/Ipay88Payment/Index";
  String paymentGateWayPageUrlDebug =
      "http://dev2.enerren.com/AngkutPaymentGateway/Ipay88Payment/Index";
  String invoiceGetIncomeUrl = "tagihan/getIncome";
  String invoiceGetOutcomeUrl = "tagihan/getOutcome";
  String getAllInsuranceUrl = "Insurance/getAllInsurances";
  String getAllInsuranceCategoryUrl = "Insurance/getAllInsurancesType";
  String uploadImageUrl = "";
  String uploadPODReceiverImageUrl = "Shipment/uploadFileReceiverPhoto";
  String uploadPODProductImageUrl = "Shipment/uploadFileProductPhoto";
  String deletePODProductImageUrl = "Shipment/deleteFileProductPhoto";
  String uploadPODSignatureUrl = "Shipment/uploadFileTTD";
  String voucherListUrl = "shipment/getVoucherList";
  String applyVoucherCodeUrl = "shipment/checkVoucherCode";
  String saveServiceTrackingLogUrl = "Log/addServiceTrackerLog";
  String notYetRatedShipmentUrl = "Shipment/getShipmentNotYetRated";
  String getChatListUrl = "Chatting/getChatList";
  String sendChatUrl = "Chatting/sendChat";
  String vehicleAttendanceFormUrl = "Attendance/getVehicleAttendanceForm";
  String checkVehicleAttendanceDailyUrl = "Attendance/checkVehicleAbsenceDaily";
  String addAttendaceUrl = "Attendance/addVehicleAttendance";
  String confirmAttendanceUrl = "Attendance/confirmationVehicleAttendance";
  String dailyAttendanceUrl = "Attendance/getVehicleAttendanceData";

  String get url {
    String endPoint;
    var x = ModeUtil.debugMode;
    if (x == true) {
      endPoint = baseUrlDebug;
    } else {
      endPoint = baseUrl;
    }
    print(endPoint);
    return endPoint;
  }

  String get vtsUrl {
    String endPoint;
    var x = ModeUtil.debugMode;
    if (x == true) {
      endPoint = vtsBaseUrlDebug;
    } else {
      endPoint = vtsBaseUrl;
    }
    print(endPoint);
    return endPoint;
  }

  String checkAccount({String username, bool isResetPassword = false}) {
    return this.url +
        "$checkAccountUrl?username=$username&isResetPassword=${isResetPassword ?? "false"}";
  }

  String uploadImage() {
    return this.url + "$uploadImageUrl";
  }

  String setPod() {
    return this.url + "$setPodUrl";
  }

  String getShipmentItemDescription({
    @required int tmsShipmentId,
    int detailShipmentId,
    bool isPod = false,
  }) {
    return this.url +
        "$getShipmentItemDescriptionUrl?tmsShipmentId=$tmsShipmentId&detailShipmentId=${detailShipmentId ?? ""}&isPOD=${isPod ?? ""}";
  }

  String addShipmentItemDescription() {
    return this.url + "$addShipmentItemDescriptionUrl";
  }

  String updateShipmentItemDescription() {
    return this.url + "$updateShipmentItemDescriptionUrl";
  }

  String updateSingleShipmentItemDescription() {
    return this.url + "$updateSingleShipmentItemDescriptionUrl";
  }

  String deleteShipmentItemDescription({@required int tmsShipmentId}) {
    return this.url +
        "$deleteShipmentItemDescriptionUrl?tmsShipmentId=$tmsShipmentId";
  }

  String loadingItemShipmentDescriotion({
    @required tmsShipmentId,
    @required detailDestinationId,
  }) {
    return this.url +
        "$loadingItemShipmentDescription?tmsShipmentId=$tmsShipmentId&detailDestinationId=${detailDestinationId ?? ""}";
  }

  String unloadingItemShipmentDescriotion({
    @required tmsShipmentId,
    @required detailDestinationId,
  }) {
    return this.url +
        "$unloadingItemShipmentDescription?tmsShipmentId=$tmsShipmentId&detailDestinationId=${detailDestinationId ?? ""}";
  }

  String changePassword() {
    return this.url + "$changePasswordUrl";
  }

  String validatePhoneNUmber({
    String phoneNum,
  }) {
    return this.url + "$validatePhoneNumberUrl?phoneNum=${phoneNum ?? ""}";
  }

  String createPassword() {
    return this.url + "$createPasswordUrl";
  }

  String login({String otpCode}) {
    return this.url + "$loginUrl?otpCode=${otpCode ?? ""}";
  }

  String register({String otpCode}) {
    return this.url + "$getRegisterUrl";
  }

  String setRating() {
    return this.url + "$setRatingUrl";
  }

  String getAllVehicleType() {
    return this.url + "$setVehicleType";
  }

  ///Generate MD5 hash
  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  static encrypMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  String getTmsShipmentSummary() {
    return this.url + "Shipment/getCountShipmentSummary";
  }

  String setTmsDeliveryPod({
    bool isPod,
  }) {
    return this.url + "$setTmsDeliveryPodUrl?isPOD=${isPod ?? "false"}";
  }

  String getTmsDeliveryPod({int destinationId}) {
    return this.url +
        "$getTmsDeliveryPodUrl?destinationId=${destinationId ?? ""}";
  }

  String getTmsLoadingPod({int destinationId}) {
    return this.url +
        "$getTmsLoadingPodUrl?detailDestinationId=${destinationId ?? ""}";
  }

  String getTmsUnloadingPod({int destinationId}) {
    return this.url +
        "$getTmsUnloadingPodUrl?detailDestinationId=${destinationId ?? ""}";
  }

  String tmsGetEmergency({
    int shipmentId,
    String emergencyId,
  }) {
    return this.url + "$getTmsDeliveryEmergencyUrl";
  }

  String tmsAddEmergency() {
    return this.url + "$setTmsDeliveryEmergencydUrl";
  }

  String setBackToPool({
    int driverId,
    int vehicleId,
    bool backToPool,
  }) {
    return this.url +
        "$setBackToPoolUrl?vehicleId=${vehicleId ?? ""}&driverId=${driverId ?? ""}&value=${backToPool ?? ""}";
  }

  String getTmsVehicleList({
    int vehicleStatus,
    int transporterId,
  }) {
    return this.url +
        "$getTmsListVehicleUrl?transporterId=${transporterId ?? ""}&vehicleStatus=${vehicleStatus ?? ""}";
  }

  String getAllShipment(
      {int shipmentId,
      int dataLimit,
      bool withRoute,
      bool isLowerThanId,
      int destinationId}) {
    return this.url +
        "$getAllShipmentUrl?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${withRoute ?? false}&isLowerThanId=${isLowerThanId ?? true}&destinationId=${destinationId ?? ""}";
  }

  String getUOMList() {
    return this.url + "$getUOMListUrl";
  }

  String getUangJalanList({String shipmentNumber}) {
    return this.url +
        "$getUangJalanListUrl?shipmentNumber=${shipmentNumber ?? ""}";
  }

  String getOppenedShipment(
      {int shipmentId,
      int dataLimit,
      bool withRoute,
      bool isLowerThanId,
      int destinationId}) {
    return this.url +
        "$getOpenedShipmentUrl?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${withRoute ?? false}&isLowerThanId=${isLowerThanId ?? true}&destinationId=${destinationId ?? ""}";
  }

  String addUangJalan({
    String shipmentNumber,
    double beginningBalance,
  }) {
    return this.url +
        "$addUangJalanUrl?shipmentNumber=${shipmentNumber ?? ""}&beginningBalance=${beginningBalance ?? ""}";
  }

  String addUangJalanExpense() {
    return this.url + "$addUangJalanExpenseUrl";
  }

  String deleteUangJalanExpense() {
    return this.url + "$deleteUangJalanExpenseUrl";
  }

  String setFinishUangJalan({@required int summaryId}) {
    return this.url + "$setFinishUangJalanUrl?summaryId=${summaryId ?? ""}";
  }

  String getProcessShipment(
      {int shipmentId,
      int dataLimit,
      bool withRoute,
      bool isLowerThanId,
      int destinationId}) {
    return this.url +
        "$getProcessShipmentUrl?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${withRoute ?? false}&isLowerThanId=${isLowerThanId ?? true}&destinationId=${destinationId ?? ""}";
  }

  String getShippedShipment(
      {int shipmentId,
      int dataLimit,
      bool withRoute,
      bool isLowerThanId,
      int destinationId}) {
    return this.url +
        "$getShippedShipmentUrl?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${withRoute ?? false}&isLowerThanId=${isLowerThanId ?? true}&destinationId=${destinationId ?? ""}";
  }

  String getFinishedShipment(
      {int shipmentId,
      int dataLimit,
      bool withRoute,
      bool isLowerThanId,
      int destinationId}) {
    return this.url +
        "$getFinishedShipmentUrl?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${withRoute ?? false}&isLowerThanId=${isLowerThanId ?? true}&destinationId=${destinationId ?? ""}";
  }

  String getNotYiedShipment(
      {int shipmentId,
      int dataLimit,
      bool withRoute,
      bool isLowerThanId,
      int destinationId}) {
    return this.url +
        "$getNotYieldShipmentUrl?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${withRoute ?? false}&isLowerThanId=${isLowerThanId ?? true}&destinationId=${destinationId ?? ""}";
  }

  String getCaceledShipment(
      {int shipmentId,
      int dataLimit,
      bool withRoute,
      bool isLowerThanId,
      int destinationId}) {
    return this.url +
        "$getCanceledShipmentUrl?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${withRoute ?? false}&isLowerThanId=${isLowerThanId ?? true}&destinationId=${destinationId ?? ""}";
  }

  String getShipmentByShipmentNumber({
    String shipmentNumber,
  }) {
    return this.url +
        "$getShipmentByShipmentNumberUrl?shipmentNumber=${shipmentNumber ?? ""}";
  }

  String getAcceptOrder({
    int shipmentId,
    int vehicleId,
    int driverId,
    double vehicleLat,
    double vehicleLon,
    int vehicleOdometer,
  }) {
    return this.url +
        "$getAcceptOrderUrl?shipmentId=${shipmentId ?? ""}&vehicleId=${vehicleId ?? ""}&driverId=${driverId ?? ""}&vehicleLat=${vehicleLat ?? ""}&vehicleLon=${vehicleLon ?? ""}&vehicleOdometer=${vehicleOdometer ?? ""}";
  }

  String pickupOrder({
    @required int shipmentId,
    @required int driverId,
    @required double vehicleLat,
    @required double vehicleLon,
    @required int vehicleOdometer,
  }) {
    return this.url +
        "$pickupOrderUrl?shipmentId=${shipmentId ?? ""}&driverId=${driverId ?? ""}&vehicleLat=${vehicleLat ?? ""}&vehicleLon=${vehicleLon ?? ""}&vehicleOdometer=${vehicleOdometer ?? ""}";
  }

  String submitDetailPickupOrder({
    @required int tmsshipmentId,
    @required int driverId,
  }) {
    return this.url +
        "$submitDetailPickupOrderUrl?tmsshipmentId=${tmsshipmentId ?? ""}&driverId=${driverId ?? ""}";
  }

  String finishDetailDestinationOrder(
      {@required int tmsshipmentId,
      @required int driverId,
      @required int detailShipmentId,
      $}) {
    return this.url +
        "$finishDetailDestinationOrderUrl?tmsshipmentId=${tmsshipmentId ?? ""}&driverId=${driverId ?? ""}&detailShipmentId=${detailShipmentId ?? ""}";
  }

  String createOder() {
    return this.url + "$getShipmentCreateOrderUrl";
  }

  String getCalculatePriceOrder() {
    return this.url + "$getCalculateShipmentUrl";
  }

  String cancelOrder({
    int shipmentId,
    double vehicleLat,
    double vehilceLon,
    int vehicleOdomener,
  }) {
    return this.url +
        "$getShipmentCancleOrderUrl?shipmentId=${shipmentId ?? ""}&vehicleLat=${vehicleLat ?? "0"}&vehicleLon=${vehilceLon ?? "0"}&vehicleOdometer=${vehicleOdomener ?? "0"}";
  }

  String getVtsPositionHistory({
    @required int vehicleId,
    @required DateTime fromDate,
    @required DateTime toDate,
  }) {
    return this.vtsUrl +
        "$getVtsPositionHistoryUrl?vehicleId=${vehicleId ?? ""}&fromDate=${fromDate != null ? DateFormat("yyyy-MM-dd HH:mm").format(fromDate) : ""}&toDate=${toDate != null ? DateFormat("yyyy-MM-dd HH:mm").format(toDate) : ""}";
  }

  String getVtsAllPosition({
    @required int userId,
    @required String token,
  }) {
    return this.vtsBaseUrl +
        "$getVtsAllPositionUrl?UserId=${userId ?? ""}&Token=${token ?? ""}";
  }

  String getVtsVehiclePosition({
    @required int vehicleId,
  }) {
    return this.vtsBaseUrl +
        "$getVtsVehiclePositionUrl?vehicleId=${vehicleId ?? ""}";
  }

  String getVtsAllFleets({
    @required int userId,
    @required String token,
  }) {
    return this.vtsBaseUrl +
        "$getVtsAllFleetUrl?UserId=${userId ?? ""}&Token=${token ?? ""}";
  }

  String addVehicleCheckDaily() {
    return this.url + "$addVehicleCheckDailyUrl";
  }

  String getVehicleCheckDaily({
    DateTime checkTime,
    bool isLowerThanId,
    String searchKey,
  }) {
    return this.url +
        "$getVehicleCheckDailyUrl?checkTime=${checkTime != null ? checkTime?.toIso8601String() : ""}&isLowerThanId=${isLowerThanId ?? ""}&searchKey=${searchKey ?? ""}";
  }

  String setToRest() {
    return this.url + "$setToRestUrl";
  }

  String setToActive() {
    return this.url + "$setToActiveUrl";
  }

  String driverScore() {
    return this.url + "$driverScoreUrl";
  }

  String logOut() {
    return this.url + "$logOutUrl";
  }

  String vehicleStatusSummary() {
    return this.url + "$getVehicleStatusSummaryUrl";
  }

  String getAllNotification({
    int notificationId,
    int dataLimit,
    bool lowerThan,
  }) {
    return this.url +
        "$getAllNotificationUrl?notificationId=${notificationId ?? 0}&datalimit=${dataLimit ?? ""}&isLowerThanId=${lowerThan ?? true}";
  }

  String loginInovaTrack({
    String otpCode,
    String memberCode,
    String userName,
    String token,
  }) {
    return this.baseUrl +
        "${this.loginUrl}?MemberCode=${memberCode ?? ""}&UserName=${userName ?? ""}&Token=${token ?? ""}";
  }

  String vehicleSummaryInovatrack({
    int userId,
  }) {
    return this.baseUrl + "$getVehicleStatusSummaryUrl?UserId=${userId ?? ""}";
  }

  String getDriverProfile() {
    return this.url + "$getDriverProfileUrl";
  }

  String updateDriverProfile() {
    return this.url + "$changeDriverProfileUrl";
  }

  String getCustomerProfile() {
    return this.url + "$getCustomerProfileUrl";
  }

  String updateCustomerProfile({String otpCode}) {
    return this.url + "$updateCustomerProfileUrl?otpCode=${otpCode ?? ""}";
  }

  String getTransporterProfile() {
    return this.url + "$getTransporterProfileUrl";
  }

  String thirdPartyLogin({String otpCode}) {
    return this.url + "$thirdPartyLoginUrl?otpCode=${otpCode ?? ""}";
  }

  String getLocationHistory({
    int customerId,
  }) {
    return this.url + "$getLocationHistoryUrl?customerId=${customerId ?? ""}";
  }

  String addLocationHistory() {
    return this.url + "$addLocationHistoryUrl";
  }

  String deleteLocationHistory({
    int customerId,
    int historyId,
  }) {
    return this.url +
        "$deleteLocationHistoryUrl?locHistoryId=${historyId ?? ""}&customerId=${customerId ?? ""}";
  }

  String rejectEmergencyShipment({
    @required int shipmentId,
    @required String reasonDesc,
  }) {
    return this.url +
        "$rejectEmergencyUrl?shipmentId=${shipmentId ?? ""}&reasonDesc=${reasonDesc ?? ""}";
  }

  String confirmWaiting({
    @required int shipmentId,
  }) {
    return this.url + "$confirmWaitingUrl?shipmentId=$shipmentId";
  }

  String checkVehicleAbsenceDaily() {
    return this.url + "$checkVehicleAbsenceDailyUrl";
  }

  String isShipmentPaid({
    @required tmsShipmentId,
  }) {
    return this.url + "$isShipmentPaidUrl?tmsShipmentId=${tmsShipmentId ?? ""}";
  }

  String setShipmentPaid({
    @required tmsShipmentId,
  }) {
    return this.url +
        "$setShipmentPaidUrl?tmsShipmentId=${tmsShipmentId ?? ""}";
  }

  String getPaymentMethod() {
    return this.url + "$getAllPaymentMethodUrl";
  }

  String getPaymentGateWayPage({
    int shipmentId,
    int methodeId,
  }) {
    if (ModeUtil.debugMode) {
      return "$paymentGateWayPageUrlDebug?shipmentId=${shipmentId ?? ""}&ipay88MethodId=${methodeId ?? ""}";
    } else {
      return "$paymentGateWayPageUrl?shipmentId=${shipmentId ?? ""}&ipay88MethodId=${methodeId ?? ""}";
    }
  }

  String invoiceGetIncome({
    @required DateTime startDate,
    @required DateTime endDate,
    int shipmentId,
    int destinationId,
    int datalimit,
    bool withRoute,
    bool isLowerThanId,
  }) {
    return this.url +
        "$invoiceGetOutcomeUrl?startDate=${startDate ?? ""}&endDate=${endDate ?? ""}&shipmentId=${shipmentId ?? ""}&destinationId=${destinationId ?? ""}&datalimit=${datalimit ?? ""}&withRoute=${withRoute ?? ""}&isLowerThanId=${isLowerThanId ?? ""}";
  }

  String invoiceGetOutCome({
    @required DateTime startDate,
    @required DateTime endDate,
    int shipmentId,
    int destinationId,
    int datalimit,
    bool withRoute,
    bool isLowerThanId,
  }) {
    return this.url +
        "$invoiceGetOutcomeUrl?startDate=${startDate ?? ""}&endDate=${endDate ?? ""}&shipmentId=${shipmentId ?? ""}&destinationId=${destinationId ?? ""}&datalimit=${datalimit ?? ""}&withRoute=${withRoute ?? ""}&isLowerThanId=${isLowerThanId ?? ""}";
  }

  String getAllInsurance({
    int insuranceTypeId,
    int insuranceId,
  }) {
    return this.url +
        "$getAllInsuranceUrl?insuranceId=${insuranceTypeId ?? ""}&insuranceId=${insuranceId ?? ""}";
  }

  String getAllInsuranceCategory() {
    return this.url + "$getAllInsuranceCategoryUrl";
  }

  String getPODUploadReceicerImage({
    @required int destinationId,
    bool isPod,
  }) {
    return this.url +
        "$uploadPODReceiverImageUrl?destinationId=${destinationId ?? ""}&isPOD=${isPod ?? ""}";
  }

  String getPODUploadProductImage({
    @required int destinationId,
    bool isPod,
  }) {
    return this.url +
        "$uploadPODProductImageUrl?destinationId=${destinationId ?? ""}&isPOD=${isPod ?? ""}";
  }

  String getDeletePODProductImage({
    @required int destinationId,
    @required dynamic imageId,
  }) {
    return this.url +
        "$deletePODProductImageUrl?destinationId=${destinationId ?? ""}&imageId=${imageId ?? ""}";
  }

  String getPODUploadSignature({
    @required int destinationId,
    bool isPod,
  }) {
    return this.url +
        "$uploadPODSignatureUrl?destinationId=${destinationId ?? ""}&isPOD=${isPod ?? ""}";
  }

  String getVoucherList() {
    return this.url + "$voucherListUrl";
  }

  String applyVoucher() {
    return this.url + "$applyVoucherCodeUrl";
  }

  String saveServiceTrackerLog() {
    return this.url + "$saveServiceTrackingLogUrl";
  }

  String notYetRattedShipment() {
    return this.url + "$notYetRatedShipmentUrl";
  }

  String getChatList({
    int tmsShipmentId,
  }) {
    return this.url + "$getChatListUrl?tmsShipmentId=${tmsShipmentId ?? ""}";
  }

  String sendChat() {
    return this.url + "$sendChatUrl";
  }

  String getVehicleAttendanceForm() {
    return this.url + "$vehicleAttendanceFormUrl";
  }

  String getcheckVehicleAttendanceDaily() {
    return this.url + "$checkVehicleAttendanceDailyUrl";
  }

  String addAttendance() {
    return this.url + "$addAttendaceUrl";
  }

  String confirmAttendance() {
    return this.url + "$confirmAttendanceUrl";
  }

  String dailyAttendace() {
    return this.url + "$dailyAttendanceUrl";
  }
}
