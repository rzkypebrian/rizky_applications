import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';
import 'package:enerren/model/MutationModel.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  InputComponentTextEditingController startController =
      InputComponentTextEditingController();
  InputComponentTextEditingController endController =
      InputComponentTextEditingController();
  InputComponentTextEditingController searchController =
      InputComponentTextEditingController();

  List<MutationModel> listMutation = [
    MutationModel(title: "ban", inputs: 1, outs: 2, lasts: 2, finals: 0),
    MutationModel(title: "oli", inputs: 1, outs: 2, lasts: 2, finals: 10),
    MutationModel(title: "ban", inputs: 1, outs: 2, lasts: 2, finals: 0),
    MutationModel(title: "busi", inputs: 1, outs: 2, lasts: 2, finals: 10),
    MutationModel(title: "ban", inputs: 1, outs: 2, lasts: 2, finals: 0),
    MutationModel(
        title: "kampas rem", inputs: 1, outs: 2, lasts: 2, finals: 10),
  ];
}
