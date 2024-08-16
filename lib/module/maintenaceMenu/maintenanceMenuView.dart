import 'package:enerren/module/menuList/main.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class MaintenanceMenuView extends View with MaintenanceMenuPresenter {
  VoidCallback onTapMaintenanceItem;
  VoidCallback onTapMaintenanceSchedule;
  VoidCallback onTapWorkOrder;
  VoidCallback onTapHistory;

  MaintenanceMenuView({
    this.onTapMaintenanceItem,
    this.onTapMaintenanceSchedule,
    this.onTapWorkOrder,
    this.onTapHistory,
  });

  @override
  List<Widget> menuItems() {
    return [
      itemMenu(
          title: System.data.resource.listOfVehicleMaintenance,
          pathSvgIcon: "assets/miantenanceList.svg",
          onTap: onTapMaintenanceItem),
      itemMenu(
          title: System.data.resource.maintenanceSchedule,
          pathSvgIcon: "assets/shceduleMaintenance.svg",
          onTap: onTapMaintenanceSchedule),
      itemMenu(
          title: System.data.resource.workOrderLetter,
          pathSvgIcon: "assets/miantenanceTool.svg",
          onTap: onTapWorkOrder),
      itemMenu(
          title: System.data.resource.historyMaintenance,
          pathSvgIcon: "assets/miantenanceTime.svg",
          onTap: onTapHistory),
    ];
  }
}
