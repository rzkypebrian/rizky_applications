import 'dart:async';

import 'package:component_icons/font_awesome.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  Duration duration = Duration(milliseconds: 1000);

  bool showTrafic = false;
  int currentPage = 0;
  double detailBoxInfoHeight = 30;
  bool infoBoxStatus = false;
  bool detail = false;
  bool isLoaded = false;
  IconData iconDetail = FontAwesomeLight(FontAwesomeId.fa_chevron_double_up);
  double currentIndex = 0;
  int currentIndexTab = 0;
  int lengthTab = 3;
  int get currentIndexInt => currentIndex.toInt();
  Timer timer;
  bool startTimer = false;
  double boxHeight = 0;

  List<VtsPositionModel> listVtsPositionModel = [];

  double minSlider = 0;
  double get maxSlider => listVtsPositionModel.length.toDouble() - 1;
  int get totalListAll => listVtsPositionModel.length;

  void commit() {
    notifyListeners();
  }
}
