import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/RowComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
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
              bottomSheet: vm.workOrderModel.typeWorkOrder == 4
                  ? Container(
                      margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
                      child: BottonComponent.roundedButton(
                          colorBackground: System.data.colorUtil.primaryColor,
                          onPressed: workorder,
                          text: toBeginningOfSentenceCase(
                              "${System.data.resource.createNewWorkOrder}")),
                    )
                  : null,
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

  Widget historyStock(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
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
              title: System.data.resource.detailPurchase,
              value: "",
              widthTitle: 150),
          RowComponent.rowTitleValue(
              title: System.data.resource.purchase,
              value: vm.workOrderModel.stock.prNumber),
          RowComponent.rowTitleValue(
              title: System.data.resource.uploadProofOfPurchase,
              widthTitle: 150,
              value: vm.workOrderModel.stock.image,
              enumTypeFormatValue: EnumTypeFormat.Image,
              valueChanged: (v) => onTapHeroImage(name: v, path: v)),
          RowComponent.rowTitleValue(
            title: System.data.resource.productName,
            value: "",
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            child: Column(
              children: List.generate(
                vm.workOrderModel.stock.products.length,
                (index) => RowComponent.rowTitleValue(
                  titleAsValue: true,
                  title:
                      "${vm.workOrderModel.stock.products[index].productName} (x${NumberFormat("#,###.#", System.data.resource.locale).format(vm.workOrderModel.stock.products[index].totalProduct)})",
                  value:
                      vm.workOrderModel.stock.products[index].productType == 1
                          ? System.data.resource.stock
                          : vm.workOrderModel.stock.products[index].buyingPrice,
                  enumTypeFormatValue:
                      vm.workOrderModel.stock.products[index].productType == 1
                          ? EnumTypeFormat.String
                          : EnumTypeFormat.Number,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: System.data.colorUtil.darkTextColor,
                ),
              ),
            ),
            child: RowComponent.rowTitleValue(
              title: System.data.resource.subtotal,
              value: vm.workOrderModel.stock.totalPriceDisposable,
              enumTypeFormatValue: EnumTypeFormat.Number,
            ),
          ),
          RowComponent.rowTitleValue(
            widthTitle: 120,
            title: System.data.resource.serviceFee,
            value: vm.workOrderModel.stock.service,
            enumTypeFormatValue: EnumTypeFormat.Number,
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.discount,
            value: vm.workOrderModel.stock.discount * -1,
            enumTypeFormatValue: EnumTypeFormat.Number,
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: System.data.colorUtil.darkTextColor,
                ),
              ),
            ),
            child: RowComponent.rowTitleValue(
              title: System.data.resource.total,
              value: vm.workOrderModel.stock.totalDisposable,
              enumTypeFormatValue: EnumTypeFormat.Number,
            ),
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.balance,
            value: vm.workOrderModel.stock.balance,
            enumTypeFormatValue: EnumTypeFormat.Number,
          ),
          RowComponent.rowTitleValue(
            title: System.data.resource.remainingBalance,
            value: vm.workOrderModel.stock.remainingBalanceDisposable,
            enumTypeFormatValue: EnumTypeFormat.Number,
          ),
        ],
      ),
    );
  }
}
