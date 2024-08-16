import 'package:enerren/model/VtsPositionModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier{
VtsPositionModel vtsPositionModel;
bool autoRefresh;

ViewModel({
  this.autoRefresh = false,
});

void commit() {
    notifyListeners();
 }
}