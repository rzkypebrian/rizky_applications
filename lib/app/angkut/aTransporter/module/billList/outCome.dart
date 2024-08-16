import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/BottonComponent.dart';

import 'main.dart';

class OutCome extends View {
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

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            searchengine(vm),
            listData(vm.filteredInvoice),
          ],
        ),
      ),
    );
  }

  @override
  Widget inOutCome(AngkutShipmentModel data) {
    return super.totalInOutCome(
      status: data.shipmentInvoice.billPayStatus,
      amount: data.takeHomePayAngkut,
    );
  }
}
