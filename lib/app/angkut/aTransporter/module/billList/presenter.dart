import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:enerren/component/dateTImePicker.dart';
import 'package:enerren/util/ModeUtil.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<AngkutShipmentModel> onTapBill;
  final List<AngkutShipmentModel> invoice;
  final DateTime firstDate;
  final DateTime lastDate;

  const Presenter({
    Key key,
    this.view,
    this.onTapBill,
    this.invoice,
    this.firstDate,
    this.lastDate,
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

  @override
  void initState() {
    super.initState();
    model.invoices = widget.invoice ?? [];
    model.filter();
  }

  void searchButton() {
    var textSearch = model.searchController.text.trim();
    ModeUtil.debugPrint("$textSearch");
  }

  selectDate(BuildContext context) {
    showDateTimePicker(
      context,
      mode: PickerMode.Date,
      datePickerSetting: DatePickerSetting(
        initialDate: widget.firstDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
      ),
    ).then((date) {
      if (date != null) model.selectedDate = date;
      model.dateController.text = "${date.day}/${date.month}/${date.year}";
      model.filter();
    }).catchError((onError) {});
  }

  void onTapBill(AngkutShipmentModel invoice) {
    if (widget.onTapBill != null) {
      widget.onTapBill(invoice);
    } else {
      ModeUtil.debugPrint("on tap bill tapped");
    }
  }
}
