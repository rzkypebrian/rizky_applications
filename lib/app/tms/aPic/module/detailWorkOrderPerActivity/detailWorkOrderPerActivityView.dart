import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/RowComponent.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class DetailWorkOrderPerActivityView extends View {
  final ValueChanged<WorkOrderModel> newWorkOrder;

  DetailWorkOrderPerActivityView({
    this.newWorkOrder,
  });

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
              bottomSheet: vm.workOrderModel.typeWorkOrder == 1
                  ? bottomNavigationBar(vm)
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget bottomNavigationBar(ViewModel vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: BottonComponent.roundedButton(
        colorBackground: System.data.colorUtil.primaryColor,
        onPressed: () => newWorkOrder(vm.workOrderModel),
        child: Text(
          "${System.data.resource.start}",
          style: System.data.textStyleUtil
              .mainTitle(color: System.data.colorUtil.secondaryColor),
        ),
      ),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: vm.workOrderModel.listMaintenanceScheduleModel == null
              ? []
              : [
                  header(vm),
                  maintenance(vm),
                  vm.workOrderModel.typeWorkOrder == 3
                      ? historyStock(vm)
                      : Container(),
                ],
        ),
      ),
    );
  }

  Widget maintenance(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          RowComponent.rowTitleValue(
              widthTitle: 130,
              title: System.data.resource.personInCharge,
              value: vm.workOrderModel.personInChargeModel.name,
              widthValue: 130),
          RowComponent.rowTitleValue(
            widthTitle: 130,
            title: System.data.resource.maintenanceId,
            value: vm.workOrderModel.listMaintenanceScheduleModel.first
                .maintenanceId,
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.activity,
            value: vm.workOrderModel.listMaintenanceScheduleModel.first
                .maintenanceItemModel.activity,
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.priority,
            value: vm.workOrderModel.listMaintenanceScheduleModel.first
                .maintenanceItemModel.priority?.name,
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.finalLimit,
            value: vm
                        .workOrderModel
                        .listMaintenanceScheduleModel
                        .first
                        ?.maintenanceItemModel
                        ?.threshHoldModel
                        ?.maintenanceItemId ==
                    1
                ? "${DateFormat('yyyy-MM-dd').format(vm.workOrderModel.listMaintenanceScheduleModel.first.maintenanceItemModel.thresholdDate)}"
                : "${NumberFormat("#,###.#", System.data.resource.locale).format(vm.workOrderModel.listMaintenanceScheduleModel.first.maintenanceItemModel.threshold)} ${vm.workOrderModel.listMaintenanceScheduleModel.first.maintenanceItemModel.threshHoldModel?.maintenanceItemId == 2 ? System.data.resource.hours : System.data.resource.km}",
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.asset,
            value: vm.workOrderModel.listMaintenanceScheduleModel.first
                .maintenanceItemModel.asset.name,
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.assetNo,
            value: vm.workOrderModel.listMaintenanceScheduleModel.first
                .maintenanceItemModel.assetsModel.name,
          ),
          RowComponent.rowTitleValue(
              title: System.data.resource.category,
              value: vm.workOrderModel.listMaintenanceScheduleModel.first
                  .maintenanceItemModel.catergory.name),
          RowComponent.rowTitleValue(
              title: System.data.resource.workIntruction,
              enumTypeFormatValue: EnumTypeFormat.List,
              value: vm.workOrderModel.listMaintenanceScheduleModel.first
                  .maintenanceItemModel.instructionModels,
              widthValue: 150),
        ],
      ),
    );
  }
}
