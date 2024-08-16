import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class OutcomeView extends View {
  @override
  PreferredSizeWidget appBar({ViewModel vm}) {
    return BottonComponent.customAppBar1(
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "",
      context: context,
      backButtonColor: System.data.colorUtil.lightTextColor,
      title: System.data.resource.outCome,
      titleStyle: System.data.textStyleUtil.mainTitle(),
    );
  }

  @override
  Widget totalInOutCome({int status, double amount}) {
    return super.totalInOutCome(
      status: status,
      amount: model.invoice.takeHomePayAngkut,
    );
  }

  @override
  Widget havePayToAngkut() {
    return rowData(
      title: "${System.data.resource.totalPaindToAngkut}",
      titleColor: System.data.colorUtil.primaryColor,
      valueColor: System.data.colorUtil.redColor,
      valueStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.redColor,
        fontWeight: FontWeight.bold,
      ),
      titleFontWeight: FontWeight.bold,
      valueFontWeight: FontWeight.bold,
      value:
          "Rp ${NumberFormat("#,###", System.data.resource.locale).format(model.invoice.takeHomePayAngkut ?? 0)}",
    );
  }

  Widget bottomComponent({
    String label,
    double amount,
    String pathFile,
  }) {
    return super.bottomComponent(
      amount: model.invoice.takeHomePayAngkut,
      label: System.data.resource.totalPaindToAngkut,
    );
  }
}
