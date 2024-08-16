import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:flutter/material.dart';

class ViewModelLiveMap extends ChangeNotifier{
  AngkutShipmentModel shipmentModel;

  void commit(){
    notifyListeners();
  }
}