import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/RowComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/WorkOrderModel.dart';
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
      title:
          Text(toBeginningOfSentenceCase(System.data.resource.detailWorkOrder),
              textAlign: TextAlign.center,
              style: System.data.textStyleUtil.mainTitle(
                color: System.data.colorUtil.lightTextColor,
              )),
      actions: [],
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: vm.workOrderModel.listMaintenanceScheduleModel == null
              ? []
              : List.generate(
                  vm.workOrderModel.listMaintenanceScheduleModel.length,
                  (index) {
                  WorkOrderModel _workOrderModel = WorkOrderModel(
                      noteForVendor: vm.workOrderModel.noteForVendor,
                      personInChargeModel:
                          vm.workOrderModel.personInChargeModel,
                      typeWorkOrder: vm.workOrderModel.typeWorkOrder,
                      vendorModel: vm.workOrderModel.vendorModel,
                      workOrderId: vm.workOrderModel.workOrderId,
                      stock: vm.workOrderModel.stock,
                      listMaintenanceScheduleModel: []);
                  _workOrderModel.listMaintenanceScheduleModel.add(
                      vm.workOrderModel.listMaintenanceScheduleModel[index]);
                  return itemWorkOrderModel(_workOrderModel);
                }),
        ),
      ),
    );
  }

  Widget itemWorkOrderModel(WorkOrderModel wo) {
    return GestureDetector(
      onTap: () => selectedWorkOrderModel(wo),
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
            RowComponent.rowTitleValue(
              title: System.data.resource.maintenanceId,
              widthTitle: 130,
              statusWidgetCenter: wo.typeWorkOrder == 3 ? true : false,
              widgetCenter: Container(
                padding: EdgeInsets.all(3),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: System.data.colorUtil.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: System.data.colorUtil.primaryColor),
                ),
                child: Center(
                  child: Icon(
                    FontAwesomeLight(FontAwesomeId.fa_check),
                    color: System.data.colorUtil.secondaryColor,
                    size: 10,
                  ),
                ),
              ),
              value: wo.listMaintenanceScheduleModel.first.maintenanceId,
            ),
            RowComponent.rowTitleValue(
              title: System.data.resource.activity,
              value: wo.listMaintenanceScheduleModel.first.maintenanceItemModel
                  .activity,
            ),
          ],
        ),
      ),
    );
  }
}
