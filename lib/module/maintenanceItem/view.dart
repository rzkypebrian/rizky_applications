import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
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
                children: [
                  body(vm),
                  circularProgressIndicatorDecoration(vm),
                ],
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
      title: Text(toBeginningOfSentenceCase(System.data.resource.listMaintenance),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
      actions: [
        GestureDetector(
          onTap: addNewMaintenance,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    FontAwesomeLight(FontAwesomeId.fa_plus),
                    size: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    toBeginningOfSentenceCase("${System.data.resource.add}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.secondaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(child: listMaintenance(vm));
  }

  Widget listMaintenance(ViewModel vm) {
    return Container(
      child: Column(
        children: List.generate(vm.maintenancesModel.length,
            (index) => itemList(vm.maintenancesModel[index])),
      ),
    );
  }

  Widget itemList(MaintenanceItemModel mm) {
    return GestureDetector(
      onTap: () => detailNewMaintenance(mm),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: System.data.colorUtil.secondaryColor),
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: System.data.colorUtil.shadowColor))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      toBeginningOfSentenceCase("${mm.maintenanceId}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${DateFormat("dd-MM-yyyy", System.data.resource.dateLocalFormat).format(mm.dateTime)}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      toBeginningOfSentenceCase("${mm.activity}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      toBeginningOfSentenceCase("${mm.priority?.name}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: mm.priority?.id == 1
                            ? System.data.colorUtil.primaryColor
                            : mm.priority?.id == 2
                                ? System.data.colorUtil.yellowColor
                                : System.data.colorUtil.redColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                toBeginningOfSentenceCase("${mm.assetsModel.name}"),
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.darkTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
