import 'package:enerren/module/menuList/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'inventoryMenuPresenter.dart';
import 'package:flutter/material.dart';

class InventoryMenuView extends View with InventoryMenuPresenter {
  VoidCallback onTapPurchase;
  VoidCallback onTapStock;
  VoidCallback onTapHistory;

  InventoryMenuView({
    this.onTapPurchase,
    this.onTapStock,
    this.onTapHistory,
  });

  @override
  List<Widget> menuItems() {
    return [
      itemMenu(
          title: System.data.resource.purchase,
          pathSvgIcon: "assets/inventoryTrolly.svg",
          onTap: onTapPurchase),
      itemMenu(
          title: System.data.resource.stock,
          pathSvgIcon: "assets/inventoryWareHouse.svg",
          onTap: onTapStock),
      itemMenu(
          title: System.data.resource.history,
          pathSvgIcon: "assets/inventoryTime.svg",
          onTap: onTapHistory),
    ];
  }
}
