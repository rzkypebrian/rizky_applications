import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  TabController controller;
  int currentProcess = 1;
  int doneProcess = 2;
  int rejectProcess = 3;
}
