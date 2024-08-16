import 'package:enerren/util/ApiEndPointUtil.dart';

extension ApiEndPointUtilExtension on ApiEndPointUtil {
  ApiEndPointUtil sampleApiEndPoint() {
    this.baseUrl = "http://dev2.enerren.com/angkutapidriver/api/";
    this.baseUrlDebug = "http://dev2.enerren.com/angkutapidriver/api/";
    this.loginUrl = "Auth/Driver-login";
    return this;
  }

  ApiEndPointUtil sampleCustomerApiEndPoimt() {
    sampleApiEndPoint();
    this.baseUrl = "http://dev2.enerren.com/angkutapicustomer/api/";
    this.baseUrlDebug = "http://dev2.enerren.com/angkutapicustomer/api/";
    return this;
  }

  ApiEndPointUtil sampleDriverApiEndPoimt() {
    sampleApiEndPoint();
    return this;
  }
}
