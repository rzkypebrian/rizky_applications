import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'readOnlyPresenter.dart';

import 'view.dart';

class ReadOnlyView extends View with ReadOnlyPresenter {
  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.color009789,
      title: System.data.resource.detailAttendance,
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
        fontSize: System.data.fontUtil.lPlus,
      ),
    );
  }

  @override
  List<Widget> itemList() {
    return [
      detailDriverAttendance(),
      SizedBox(
        height: 10,
      ),
      attendanceItemForm(
        readOnly: true,
      ),
      SizedBox(
        height: 50,
      ),
    ];
  }

  Widget detailDriverAttendance() {
    return Container(
      height: 125,
      color: System.data.colorUtil.secondaryColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 23, top: 15, right: 18, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelItem(label: "Pengemudi"),
                Text("${model.attendanceModel.driverName}")
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 23, top: 15, right: 18, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelItem(label: "Jenis Mobil"),
                Text("${model.attendanceModel.vehicleTypeName ?? "-"}")
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 23, top: 15, right: 18, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelItem(label: "Plat Nomor"),
                Text("${model.attendanceModel.vehicleNumber ?? "-"}")
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget confirmationCheck() {
    return null;
  }

  @override
  Widget submitButton({String label}) {
    return widget.onSubmited != null
        ? super.submitButton(
            label: System.data.resource.startCheck,
          )
        : SizedBox();
  }
}
