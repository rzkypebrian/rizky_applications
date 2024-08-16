import 'package:component_icons/font_awesome.dart';
import 'package:enerren/util/EnumUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../component/tmsDecorationComponent.dart';
import '../../../../../util/InputData.dart';
import '../../../../../util/SystemUtil.dart';
import '../../../model/IncomeAndOutcomeModel.dart';
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
      aligment: Alignment.topCenter,
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(toBeginningOfSentenceCase(System.data.resource.income),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            inputData(vm),
            vm.getOverLay ? overlay(vm) : Container(),
            widget.enumUtil == EnumUtil.Income
                ? listIncome(vm)
                : listOutcome(vm),
          ],
        ),
      ),
    );
  }

  Widget overlay(ViewModel vm) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 13),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
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
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: InputData.inputData(
                        context: context,
                        widTitle: 50,
                        typeInput: TypeInput.Date,
                        title: System.data.resource.from,
                        controller: vm.fromController,
                        sufix: Container(
                          color: System.data.colorUtil.primaryColor,
                          child: Icon(
                            FontAwesomeLight(FontAwesomeId.fa_calendar_alt),
                            color: System.data.colorUtil.secondaryColor,
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: InputData.inputData(
                      widTitle: 50,
                      typeInput: TypeInput.Dropdown,
                      title: System.data.resource.courier,
                      list: vm.listCourier,
                      selectedItem: vm.selectedCourier,
                      onChangeds: vm.changeDropDown,
                      hint: System.data.resource.select,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 176,
                  margin: EdgeInsets.only(bottom: 16, top: 16),
                  child: InputData.inputData(
                      context: context,
                      widTitle: 50,
                      typeInput: TypeInput.Date,
                      title: System.data.resource.until,
                      controller: vm.toController,
                      sufix: Container(
                        color: System.data.colorUtil.primaryColor,
                        child: Icon(
                          FontAwesomeLight(FontAwesomeId.fa_calendar_alt),
                          color: System.data.colorUtil.secondaryColor,
                        ),
                      )),
                ),
                Expanded(
                  child: widget.enumUtil == EnumUtil.OutCome
                      ? Container(
                          margin: EdgeInsets.only(left: 5),
                          child: InputData.inputData(
                            widTitle: 50,
                            typeInput: TypeInput.Dropdown,
                            title: System.data.resource.status,
                            list: vm.listStatus,
                            selectedItem: vm.selectedStatus,
                            onChangeds: vm.changeDropDownStatus,
                            hint: System.data.resource.select,
                          ),
                        )
                      : Container(),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 8, top: 8),
                  width: 88,
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    toBeginningOfSentenceCase("${System.data.resource.apply}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.secondaryColor,
                        fontSize: System.data.fontUtil.m),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget inputData(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(bottom: 13),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: InputData.inputData(
                typeInput: TypeInput.Text,
                hint: "",
                controller: vm.inputController,
              ),
            ),
          ),
          GestureDetector(
            onTap: vm.setOverLayV,
            child: Container(
              margin: EdgeInsets.only(left: 16),
              width: 25,
              child: Icon(
                FontAwesomeLight(FontAwesomeId.fa_sliders_v),
                color: vm.getOverLay
                    ? System.data.colorUtil.shadowColor
                    : System.data.colorUtil.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listIncome(ViewModel vm) {
    return Container(
      child: Column(
        children: List.generate(vm.listOrderIncome.length,
            (index) => item(vm.listOrderIncome[index])),
      ),
    );
  }

  Widget listOutcome(ViewModel vm) {
    return Container(
      child: Column(
        children: List.generate(vm.listOrderOutcome.length,
            (index) => item(vm.listOrderOutcome[index])),
      ),
    );
  }

  Widget item(IncomeAndOutcomeModel om) {
    return GestureDetector(
      onTap: () => ontapDetailIncomeAndOutcome(om),
      child: Container(
        margin: EdgeInsets.only(bottom: 13),
        child: Stack(
          children: [
            Align(
              child: SvgPicture.asset(
                "assets/tms/billListReceiver.svg",
                fit: BoxFit.fitHeight,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 12),
                width: MediaQuery.of(context).size.width / 1.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: System.data.colorUtil.shadowColor))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              toBeginningOfSentenceCase("${om.orderNumber}"),
                              style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                  fontSize: System.data.fontUtil.s),
                            ),
                          ),
                          Container(
                            child: Text(
                              toBeginningOfSentenceCase(
                                  "${DateFormat("dd MMM yyyy", System.data.resource.dateLocalFormat).format(om.dateTime)}"),
                              style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                  fontSize: System.data.fontUtil.s),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        toBeginningOfSentenceCase("${om.customerName}"),
                        style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                            fontSize: System.data.fontUtil.m),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              toBeginningOfSentenceCase(
                                  "${System.data.resource.totalReceived} Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(om.total)}"),
                              style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                  fontSize: System.data.fontUtil.m),
                            ),
                          ),
                          om.typeProcess == 2
                              ? Container(
                                  child: SvgPicture.asset(
                                    "assets/tms/notPayed.svg",
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
