import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/RowComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/InputData.dart';
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
              bottomNavigationBar: bottomNavigationBar(vm),
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

  Widget bottomNavigationBar(ViewModel vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: BottonComponent.roundedButton(
        colorBackground: System.data.colorUtil.primaryColor,
        onPressed: () => null,
        child: Text(
          "${System.data.resource.save}",
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
                ],
        ),
      ),
    );
  }

  Widget header(ViewModel vm) {
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
            title: System.data.resource.workOrderNumber,
            value: vm.workOrderModel.workOrderId,
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.vendor,
            value: vm.workOrderModel.vendorModel.name,
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.note,
            value: vm.workOrderModel.noteForVendor,
            widthValue: 240,
          ),
        ],
      ),
    );
  }

  Widget maintenance(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Container(
            width: 90,
            child: Text(
              toBeginningOfSentenceCase(
                  "${System.data.resource.workIntruction}"),
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.darkTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          checkInstrucktio(vm),
          InputData.inputData(
            title: System.data.resource.obstacles,
            controller: vm.obstaclesController,
          ),
          GestureDetector(
            onTap: () => makePurchaseOfGoods(vm.workOrderModel),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 50,
              child: Text(
                toBeginningOfSentenceCase(
                    "${System.data.resource.makePurchaseOfGoods}"),
                style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget checkInstrucktio(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(left: 40, top: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
              vm.listInstuction.length,
              (index) => Container(
                    height: 20,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${vm.listInstuction[index].name}"),
                            textAlign: TextAlign.start,
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Checkbox(
                              checkColor: System.data.colorUtil.secondaryColor,
                              activeColor: System.data.colorUtil.primaryColor,
                              onChanged: (v) => vm.changeCheck(index),
                              value: vm.listInstuction[index].status),
                        ),
                      ],
                    ),
                  ))),
    );
  }
}
