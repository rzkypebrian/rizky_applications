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
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(toBeginningOfSentenceCase(System.data.resource.maintenance),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  Widget body(ViewModel vm) {
    return Container(child: Column(children: menuItems()));
  }

  List<Widget> menuItems() {
    return [
      itemMenu(
          title: System.data.resource.maintenance,
          pathSvgIcon: "assets/tms/miantenanceList.svg",
          onTap: () {}),
      itemMenu(
          title: System.data.resource.activityMaintenance,
          pathSvgIcon: "assets/tms/miantenanceTool.svg",
          onTap: () {}),
    ];
  }

  Widget itemMenu(
      {String title,
      VoidCallback onTap,
      String pathSvgIcon,
      String background}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 79,
        margin: EdgeInsets.only(bottom: 14),
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
            Align(
              alignment: Alignment.center,
              child: Container(
                child: SvgPicture.asset(
                 background == null ? "assets/backgroundCmms.svg" : "$background",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  child: SvgPicture.asset("$pathSvgIcon"),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        toBeginningOfSentenceCase(title),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.secondaryColor,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
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
