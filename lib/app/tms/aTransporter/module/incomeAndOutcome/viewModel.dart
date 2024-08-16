import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/DropDowns.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  List<DropDowns> listMonths = [
    DropDowns(
      id: DateTime.january,
      name: System.data.resource.january,
    ),
    DropDowns(
      id: DateTime.february,
      name: System.data.resource.february,
    ),
    DropDowns(
      id: DateTime.march,
      name: System.data.resource.march,
    ),
    DropDowns(
      id: DateTime.april,
      name: System.data.resource.april,
    ),
    DropDowns(
      id: DateTime.may,
      name: System.data.resource.may,
    ),
    DropDowns(
      id: DateTime.june,
      name: System.data.resource.june,
    ),
    DropDowns(
      id: DateTime.july,
      name: System.data.resource.july,
    ),
    DropDowns(
      id: DateTime.august,
      name: System.data.resource.august,
    ),
    DropDowns(
      id: DateTime.september,
      name: System.data.resource.september,
    ),
    DropDowns(
      id: DateTime.october,
      name: System.data.resource.october,
    ),
    DropDowns(
      id: DateTime.november,
      name: System.data.resource.november,
    ),
    DropDowns(
      id: DateTime.december,
      name: System.data.resource.december,
    ),
  ];

  DropDowns selectedMonth;
  int selectedYear;

  void selectYear(int i) {
    this.selectedYear = i;
    commit();
  }

  void selectMonth(DropDowns i) {
    this.selectedMonth = i;
    commit();
  }

  String infoOutcome =
      "* Pembayaran terakhir bulan April ke Admin tanggal 7 Mei 2020, Jika melewati batas waktu akun Anda akan disuspend dan tidak bisa menggunakan layanan";
  double totalToBePaid = 90000;

  DropDowns get getSelectedMonth => selectedMonth;
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
