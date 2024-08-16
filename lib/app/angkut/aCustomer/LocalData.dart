import 'package:enerren/app/angkut/model/AngkutCreateOrderModel.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/model/RegisterModel.dart';

class LocalData {
  CustomerModel user;
  AngkutCreateOrderModel newOrder = new AngkutCreateOrderModel();
  RegisterModel registerModel = new RegisterModel();
  bool isConfirmOrderSuccess = false;
}
