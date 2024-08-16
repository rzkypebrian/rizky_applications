import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => viewModel,
      child: Consumer<ViewModel>(
        builder: (ctx, vm, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
              appBar: appBar(),
              body: Stack(
                children: [body(vm), circularProgressIndicatorDecoration(vm)],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget circularProgressIndicatorDecoration(ViewModel vm) {
    return DecorationComponent.circularLOadingIndicator(
      controller: vm.controller,
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
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
              title: System.data.resource.listOfVehicleMaintenance,
              pathSvgIcon: "assets/tms/miantenanceList.svg",
              onTap: onTapLitVehicle),
          itemMenu(
              title: System.data.resource.activityMaintenance,
              pathSvgIcon: "assets/tms/miantenanceTool.svg",
              onTap: onTapActivities),
          itemMenu(
              title: System.data.resource.stockMaintenanceMaintenance,
              pathSvgIcon: "assets/tms/miantenanceWarehouse.svg",
              onTap: onTapStock),
          itemMenu(
              title: System.data.resource.historyMaintenance,
              pathSvgIcon: "assets/tms/miantenanceTime.svg",
              onTap: onTapHistory),
        ],
      ),
    );
  }

  Widget itemMenu({String title, VoidCallback onTap, String pathSvgIcon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 79,
        margin: EdgeInsets.only(top: 7, bottom: 7),
        decoration: BoxDecoration(
          color: System.data.colorUtil.secondaryColor,
          boxShadow: <BoxShadow>[
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
          // shadowColor
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  child: SvgPicture.asset("$pathSvgIcon"),
                ),
                Container(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      toBeginningOfSentenceCase(title),
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                          fontSize: System.data.fontUtil.m,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: double.infinity,
                child: SvgPicture.asset(
                  "assets/tms/miantenanceBg.svg",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
