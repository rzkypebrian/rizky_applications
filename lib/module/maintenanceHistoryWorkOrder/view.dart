import 'package:enerren/component/RowComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
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
      title:
          Text(toBeginningOfSentenceCase(System.data.resource.historyWorkOrder),
              textAlign: TextAlign.center,
              style: System.data.textStyleUtil.mainTitle(
                color: System.data.colorUtil.lightTextColor,
              )),
      actions: [],
    );
  }

  Widget body(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          headerTab(vm),
          bodyTab(vm),
        ],
      ),
    );
  }

  Widget headerTab(ViewModel vm) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: vm.tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: System.data.colorUtil.primaryColor,
        onTap: vm.changeIndexTab,
        labelPadding: EdgeInsets.all(0),
        tabs: List.generate(
          widget.tabName.length,
          (i) {
            return createTab(widget.tabName[i]);
          },
        ),
      ),
    );
  }

  Widget createTab(TabName tabName) {
    switch (tabName) {
      case TabName.New:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.newProcess)}",
          style: System.data.textStyleUtil.linkLabel(
            color: System.data.colorUtil.darkTextColor,
          ),
        );
        break;

      case TabName.Process:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.currentProcess)}",
          style: System.data.textStyleUtil.linkLabel(
            color: System.data.colorUtil.darkTextColor,
          ),
        );
        break;

      case TabName.Finish:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.doneProcess)}",
          style: System.data.textStyleUtil.linkLabel(
            color: System.data.colorUtil.darkTextColor,
          ),
        );
        break;

      case TabName.Postponed:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.postponed)}",
          style: System.data.textStyleUtil.linkLabel(
            color: System.data.colorUtil.darkTextColor,
          ),
        );
        break;

      default:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.unDefined)}",
          style: System.data.textStyleUtil.linkLabel(
            color: System.data.colorUtil.darkTextColor,
          ),
        );
    }
  }

  Widget bodyTab(ViewModel vm) {
    return Expanded(
      child: TabBarView(
          controller: vm.tabController,
          children: List.generate(widget.tabName.length, (i) {
            return createTabContent(widget.tabName[i], vm);
          })),
    );
  }

  Widget createTabContent(TabName tabName, ViewModel vm) {
    switch (tabName) {
      case TabName.New:
        return newTab(vm);
        break;

      case TabName.Process:
        return processTab(vm);
        break;

      case TabName.Finish:
        return finishTab(vm);
        break;

      case TabName.Postponed:
        return postponedTab(vm);
        break;

      default:
        return Container(
          child: Text(
            System.data.resource.unDefined,
          ),
        );
    }
  }

  Widget newTab(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: vm.newWo == null
              ? []
              : List.generate(vm.newWo.length,
                  (index) => itemWorkOrderModel(vm.newWo[index])),
        ),
      ),
    );
  }

  Widget processTab(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: vm.processWo == null
              ? []
              : List.generate(vm.processWo.length,
                  (index) => itemWorkOrderModel(vm.processWo[index])),
        ),
      ),
    );
  }

  Widget finishTab(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: vm.finishWo == null
              ? []
              : List.generate(vm.finishWo.length,
                  (index) => itemWorkOrderModel(vm.finishWo[index])),
        ),
      ),
    );
  }

  Widget postponedTab(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: vm.postponeWo == null
              ? []
              : List.generate(vm.postponeWo.length,
                  (index) => itemWorkOrderModel(vm.postponeWo[index])),
        ),
      ),
    );
  }

  Widget itemWorkOrderModel(WorkOrderModel wo) {
    return GestureDetector(
      onTap: () => selecetedWorkOrderModel(wo),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: System.data.colorUtil.secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: System.data.colorUtil.darkTextColor,
                  ),
                ),
              ),
              child: RowComponent.rowTitleValue(
                titleAsValue: true,
                title: wo.workOrderId,
                value: wo.listMaintenanceScheduleModel.first.dateTime,
                enumTypeFormatValue: EnumTypeFormat.Date,
                statusWidgetCenter: wo.totalActitity > 1 ? true : false,
                widgetCenter: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: System.data.colorUtil.primaryColor),
                  ),
                  child: Center(
                    child: Text(
                      toBeginningOfSentenceCase("${wo.totalActitity}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            RowComponent.rowTitleValue(
                titleAsValue: true,
                title: wo.vendorModel.name,
                value: wo.listMaintenanceScheduleModel.first
                    .maintenanceItemModel.priority.name,
                colorValue: System.data.colorUtil.secondaryColor,
                decorationValue: BoxDecoration(
                  color: wo.listMaintenanceScheduleModel.first
                              .maintenanceItemModel.priority.id ==
                          1
                      ? System.data.colorUtil.yellowColor
                      : wo.listMaintenanceScheduleModel.first
                                  .maintenanceItemModel.priority.id ==
                              2
                          ? System.data.colorUtil.primaryColor
                          : System.data.colorUtil.redColor,
                ),
                paddingValue: EdgeInsets.all(5),
                textAlignValue: TextAlign.center),
            Container(
              child: Text(
                toBeginningOfSentenceCase("${wo.personInChargeModel.name}"),
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
