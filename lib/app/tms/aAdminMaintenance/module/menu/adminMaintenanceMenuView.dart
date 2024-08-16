import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:enerren/module/maintenaceMenu/main.dart';

import 'main.dart';

class AdminMaintenanceMenuView extends MaintenanceMenuView {
  @override
  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(toBeginningOfSentenceCase(System.data.resource.maintenance),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  Widget body(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          itemMenu(
              title: System.data.resource.makeListVehicleMaintenance,
              pathSvgIcon: "assets/ListMaintenance.svg",
              onTap: onTapMaintenanceSchedule),
          itemMenu(
              title: System.data.resource.maintenanceSchedule,
              pathSvgIcon: "assets/shceduleMaintenance.svg",
              onTap: onTapWorkOrder),
          itemMenu(
              title: System.data.resource.workOderHistory,
              pathSvgIcon: "assets/historyMaintenance.svg",
              onTap: onTapHistory),
        ],
      ),
    );
  }
}
