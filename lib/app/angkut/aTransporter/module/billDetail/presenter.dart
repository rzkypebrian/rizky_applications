import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/dateTImePicker.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/ModeUtil.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final AngkutShipmentModel invoice;
  final ValueChanged<AngkutShipmentModel> onTapShipmentDetail;

  const Presenter({
    Key key,
    this.view,
    this.invoice,
    this.onTapShipmentDetail,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = ViewModel();
  void listIncome() {}
  InputComponentTextEditingController searchController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController dateController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController courierController =
      new InputComponentTextEditingController();
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    model.invoice = widget.invoice ?? null;
    createFileOfPdfUrl().then((f) {
      model.pathFile = f.path;
    });
  }

  void searchButton() {
    var textSearch = searchController.text.trim();
    ModeUtil.debugPrint("$textSearch");
  }

  selectDate(BuildContext context) {
    showDateTimePicker(
      context,
      mode: PickerMode.Date,
      datePickerSetting: System.data.themeUtil.datePickerTheme(
        initialDate: DateTime.now(),
      ),
    ).then((date) {
      if (date != null) selectedDate = date;
      dateController.text = "${date.day}/${date.month}/${date.year}";
    }).catchError((onError) {});
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "http://africau.edu/images/default/sample.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
