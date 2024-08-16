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
              bottomNavigationBar: Container(
                height: 95,
                margin: EdgeInsets.only(left: 14, right: 14, bottom: 10),
                width: double.infinity,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: vm.removeMaintenanceItemModel,
                      child: Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(left: 14, right: 14, bottom: 14),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: System.data.colorUtil.colorD1D1D1,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.remove}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          selectedMaintenancesModel(vm.maintenancesModel),
                      child: Container(
                        margin: EdgeInsets.only(left: 14, right: 14),
                        padding: EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: System.data.colorUtil.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.edit}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
      title: Text(
          toBeginningOfSentenceCase(System.data.resource.detailMaintenance),
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
          children: vm.maintenancesModel == null
              ? []
              : [
                  RowComponent.rowTitleValue(
                    widthTitle: 120,
                    title: System.data.resource.maintenanceId,
                    value: vm.maintenancesModel?.maintenanceId,
                  ),
                  RowComponent.rowTitleValue(
                    title: System.data.resource.activity,
                    value: vm.maintenancesModel?.activity,
                  ),
                  RowComponent.rowTitleValue(
                    title: System.data.resource.priority,
                    value: vm.maintenancesModel?.priority?.name,
                  ),
                  RowComponent.rowTitleValue(
                    title: System.data.resource.finalLimit,
                    value: vm.maintenancesModel?.threshHoldModel
                                ?.maintenanceItemId ==
                            1
                        ? "${DateFormat('yyyy-MM-dd').format(vm.maintenancesModel?.thresholdDate)}"
                        : "${NumberFormat("#,###.#", System.data.resource.locale).format(vm.maintenancesModel?.threshold)} ${vm.maintenancesModel?.threshHoldModel?.maintenanceItemId == 2 ? System.data.resource.hours : System.data.resource.km}",
                  ),
                  RowComponent.rowTitleValue(
                    title: System.data.resource.asset,
                    value: vm.maintenancesModel.asset.name,
                  ),
                  RowComponent.rowTitleValue(
                    title: System.data.resource.assetNo,
                    value: vm.maintenancesModel.assetsModel.name,
                  ),
                  RowComponent.rowTitleValue(
                      title: System.data.resource.category,
                      value: vm.maintenancesModel.catergory.name),
                  RowComponent.rowTitleValue(
                    widthValue: MediaQuery.of(context).size.width /2,
                      title: System.data.resource.workIntruction,
                      enumTypeFormatValue: EnumTypeFormat.List,
                      value: vm.maintenancesModel.instructionModels),
                ],
        ),
      ),
    );
  }
}
