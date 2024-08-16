import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class PicMaintenanceMenuView extends MaintenanceMenuView {
  @override
  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(
        toBeginningOfSentenceCase(System.data.resource.maintenance),
        textAlign: TextAlign.center,
        style: System.data.textStyleUtil.mainTitle(
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }

  @override
  Widget body(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          itemMenu(
            title: System.data.resource.historyMaintenance,
            pathSvgIcon: "assets/tms/miantenanceTime.svg",
            onTap: onTapHistory,
          ),
        ],
      ),
    );
  }
}
