import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class InventoryActivityView extends View {
  final VoidCallback onTapBuyStock;
  final VoidCallback onTapTakeStock;

  InventoryActivityView({this.onTapBuyStock, this.onTapTakeStock});

  @override
  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(toBeginningOfSentenceCase(System.data.resource.activity),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  @override
  Widget body(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          itemMenu(
              title: System.data.resource.buyProduct,
              pathSvgIcon: "assets/tms/miantenanceTrolly.svg",
              onTap: onTapBuyStock),
          itemMenu(
              title: System.data.resource.takeFromStock,
              pathSvgIcon: "assets/tms/miantenanceLToolBox.svg",
              onTap: onTapTakeStock),
        ],
      ),
    );
  }
}
