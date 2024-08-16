import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/InputData.dart';
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
              bottomSheet: GestureDetector(
                onTap: () {
                  vm.saveMaintenance(onFinisLoading: () {
                    if (vm.enumType == EnumType.EditData)
                      backToList();
                    else if (vm.enumType == EnumType.InputData)
                      sandMaintenancesModel(vm.maintenancesModel);
                  });
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(13),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${vm.enumType == EnumType.EditData ? System.data.resource.edit : System.data.resource.save}"),
                    textAlign: TextAlign.center,
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.secondaryColor,
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
                    width: 130,
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.maintenanceId}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase("${vm.maintenaceId}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InputData.inputData(
              title: System.data.resource.activity,
              controller: vm.activitesController,
              widTitle: 90,
            ),
            InputData.inputData(
              typeInput: TypeInput.Dropdown,
              title: System.data.resource.priority,
              widTitle: 90,
              list: vm.listPriority,
              onChangeds: vm.onChangedPriority,
              selectedItem: vm.priorityModel,
              hint: System.data.resource.select,
            ),
            InputData.inputData(
              typeInput: TypeInput.Dropdown,
              title: System.data.resource.finalLimit,
              widTitle: 90,
              list: vm.listThreshHold,
              onChangeds: vm.onChangedThreshHold,
              selectedItem: vm.threshHoldModel,
              hint: System.data.resource.select,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: InputData.inputData(
                          context: context,
                          title: "",
                          controller: vm.thresholdController,
                          widTitle: 90,
                          typeInput: vm.threshHoldModel.maintenanceItemId == 1
                              ? TypeInput.Date
                              : TypeInput.Text,
                          sufix: vm.threshHoldModel.maintenanceItemId == 1
                              ? Container(
                                  child: Icon(
                                    FontAwesomeLight(
                                        FontAwesomeId.fa_calendar_week),
                                    color: System.data.colorUtil.primaryColor,
                                  ),
                                )
                              : null,
                          keyboardType:
                              vm.threshHoldModel.maintenanceItemId == 1
                                  ? TextInputType.datetime
                                  : TextInputType.number),
                    ),
                  ),
                  vm.threshHoldModel.maintenanceItemId == 1
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${vm.threshHoldModel.maintenanceItemId == 2 ? System.data.resource.hours : System.data.resource.km}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: 90,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.repeat}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Checkbox(
                              activeColor: System.data.colorUtil.primaryColor,
                              value: vm.repeat,
                              onChanged: vm.changeRepaet),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: 90,
                  ),
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase("${System.data.resource.show}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: InputData.inputData(
                        typeInput: TypeInput.Dropdown,
                        list: vm.listShowbefore,
                        onChangeds: vm.onChangedShowBeforeModel,
                        selectedItem: vm.selectedShowBeforeModel,
                        hint: System.data.resource.select,
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${vm.getThreshHoldModel.maintenanceItemId == 1 ? System.data.resource.day : vm.getThreshHoldModel.maintenanceItemId == 2 ? System.data.resource.hours : System.data.resource.km} ${System.data.resource.beforeDeadline}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InputData.inputData(
              typeInput: TypeInput.Dropdown,
              title: System.data.resource.asset,
              controller: vm.activitesController,
              widTitle: 90,
              list: vm.assetModels,
              onChangeds: vm.changedassetModel,
              selectedItem: vm.assetModel,
              hint: System.data.resource.select,
            ),
            InputData.inputData(
              typeInput: TypeInput.Dropdown,
              title: System.data.resource.assetNo,
              controller: vm.activitesController,
              widTitle: 90,
              list: vm.assetsModels,
              onChangeds: vm.changedAssetModel,
              selectedItem: vm.assetsModel,
              hint: System.data.resource.select,
            ),
            InputData.inputData(
              typeInput: TypeInput.Dropdown,
              title: System.data.resource.category,
              controller: vm.activitesController,
              widTitle: 90,
              list: vm.listCategoryModel,
              onChangeds: vm.changedCategoryModel,
              selectedItem: vm.categoryModel,
              hint: System.data.resource.select,
            ),
            workIntruction(vm),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: vm.addInstruction,
                    child: Container(
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.add}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget workIntruction(ViewModel vm) {
    return Container(
      child: Column(
        children: List.generate(
          vm.intructionController.length,
          (index) => Row(
            children: [
              Expanded(
                child: InputData.inputData(
                  title: index == 0 ? System.data.resource.workIntruction : "",
                  controller: vm.intructionController[index],
                  widTitle: 90,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (vm.statusAddInstruction) {
                    vm.removeInstruction(vm.intructionController[index]);
                  }
                },
                child: vm.statusAddInstruction
                    ? Container(
                        width: 30,
                        child: Icon(
                          FontAwesomeLight(FontAwesomeId.fa_times),
                          color: System.data.colorUtil.darkTextColor,
                          size: 15,
                        ),
                      )
                    : Container(
                        width: 30,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
