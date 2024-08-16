import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  List<int> month = [
    DateTime.january,
    DateTime.february,
    DateTime.march,
    DateTime.april,
    DateTime.may,
    DateTime.june,
    DateTime.july,
    DateTime.august,
    DateTime.september,
    DateTime.october,
    DateTime.november,
    DateTime.december,
  ];

  int selectedMonth;
  int selectedYear;

  int get getSelectedMonth => selectedMonth;
  int get getSelectedYear => selectedYear;

  List<int> listYears({int start, int end}) {
    List<int> month = [];
    int _start = start ?? DateTime.now().year;
    int _end = end ?? (DateTime.now().year - 20);
    for (int i = _start; i >= _end; i--) {
      month.add(i);
    }
    return month;
  }
}
