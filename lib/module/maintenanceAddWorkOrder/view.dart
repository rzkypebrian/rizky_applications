import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/MaintenanceItemModel.dart';

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
              // floatingActionButton: Container(
              //   margin: EdgeInsets.only(bottom: 40),
              //   child: FloatingActionButton(
              //     backgroundColor: System.data.colorUtil.primaryColor,
              //     onPressed: vm.addMaintenancesModel,
              //     child: Icon(
              //       FontAwesomeLight(FontAwesomeId.fa_plus),
              //       color: System.data.colorUtil.secondaryColor,
              //     ),
              //   ),
              // ),
              bottomSheet: GestureDetector(
                onTap: () => showBottomSheet(vm),
                child: Container(
                  margin: EdgeInsets.all(16),
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      toBeginningOfSentenceCase("${System.data.resource.send}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showBottomSheet(ViewModel vm) {
    ModalComponent.bottomModalWithCorner(
      context,
      corner: 20,
      height: 250,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              InputData.inputData(
                typeInput: TypeInput.Text,
                title: System.data.resource.vendor,
                controller: vm.vendorController,
                widTitle: 70,
                sufix: GestureDetector(
                  onTap: getVendorModel,
                  child: Container(
                    child: Icon(
                      FontAwesomeLight(FontAwesomeId.fa_search),
                      color: System.data.colorUtil.shadowColor,
                      size: 15,
                    ),
                  ),
                ),
              ),
              InputData.inputData(
                typeInput: TypeInput.Text,
                title: System.data.resource.note,
                controller: vm.noteVendorController,
                widTitle: 70,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        vm.sendMaintenance(
                            onFinishLoading: widget.onSubmitSuccess);
                        System.data.routes.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 2.4,
                        decoration: BoxDecoration(
                          color: System.data.colorUtil.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.send}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => System.data.routes.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 2.4,
                        decoration: BoxDecoration(
                          color: System.data.colorUtil.colorD1D1D1,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.cancel}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      title: Text(toBeginningOfSentenceCase(System.data.resource.workOrder),
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
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.workOrderNumber}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase("${vm.workOrderNumber}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                )
              ],
            )),
            InputData.inputData(
              typeInput: TypeInput.Text,
              title: System.data.resource.personInCharge,
              controller: vm.picController,
              widTitle: 130,
              sufix: GestureDetector(
                onTap: getPersonInChargeModel,
                child: Container(
                  child: Icon(
                    FontAwesomeLight(FontAwesomeId.fa_search),
                    color: System.data.colorUtil.shadowColor,
                    size: 15,
                  ),
                ),
              ),
            ),
            InputData.inputData(
              typeInput: TypeInput.Text,
              title: System.data.resource.maintenanceId,
              controller: vm.maintenanceController,
              widTitle: 130,
              sufix: GestureDetector(
                onTap: getMaintenancesModel,
                child: Container(
                  child: Icon(
                    FontAwesomeLight(FontAwesomeId.fa_search),
                    color: System.data.colorUtil.shadowColor,
                    size: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: BottonComponent.roundedButton(
                    height: 40,
                    width: 40,
                    radius: 40,
                    child: Icon(
                      Icons.add,
                      color: System.data.colorUtil.lightTextColor,
                    ),
                    colorBackground: System.data.colorUtil.primaryColor,
                    onPressed: () {
                      print("add work order");
                      vm.addMaintenancesModel();
                    },
                    textColor: System.data.colorUtil.lightTextColor,
                    textstyle: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.lightTextColor,
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: System.data.colorUtil.shadowColor))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      toBeginningOfSentenceCase("${System.data.resource.id}"),
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.activity}"),
                        style: System.data.textStyleUtil.mainLabel(
                          fontWeight: FontWeight.w500,
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase("${System.data.resource.edit}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            listMaintenance(vm),
          ],
        ),
      ),
    );
  }

  Widget listMaintenance(ViewModel vm) {
    return Container(
      child: vm.workOrderModel.listMaintenanceScheduleModel == null
          ? Container()
          : Column(
              children: List.generate(
                vm.workOrderModel.listMaintenanceScheduleModel?.length,
                (index) => itemMaintenance(
                  vm.workOrderModel.listMaintenanceScheduleModel[index]
                      .maintenanceItemModel,
                ),
              ),
            ),
    );
  }

  Widget itemMaintenance(MaintenanceItemModel mm) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100,
            child: Text(
              toBeginningOfSentenceCase("${mm.maintenanceId}"),
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.darkTextColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                toBeginningOfSentenceCase("${mm.activity}"),
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.darkTextColor,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => viewModel.removeMaintenance(mm),
            child: Container(
              child: Icon(
                FontAwesomeLight(FontAwesomeId.fa_trash_alt),
                color: System.data.colorUtil.shadowColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
