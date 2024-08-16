import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/InputData.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:enerren/util/EnumUtil.dart';

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
      title: Text(
          toBeginningOfSentenceCase(widget.enumUtil == EnumUtil.Income
              ? System.data.resource.income
              : System.data.resource.outCome),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  Widget body(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          dateWidget(vm),
          Container(
            decoration: BoxDecoration(
              color: System.data.colorUtil.shadowColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      widget.enumUtil == EnumUtil.Income
                          ? "assets/tms/billReceived.svg"
                          : "assets/tms/billPay.svg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width /
                        (widget.enumUtil == EnumUtil.Income ? 2 : 1.2),
                    margin: EdgeInsets.only(
                        top: widget.enumUtil == EnumUtil.Income ? 42 : 30),
                    child: widget.enumUtil == EnumUtil.Income
                        ? Container(
                            child: Text(
                              toBeginningOfSentenceCase(
                                  "${System.data.resource.income}"),
                              style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                  fontSize: System.data.fontUtil.xxl,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      "${System.data.resource.totalToBePaid}"),
                                  style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.darkTextColor,
                                      fontSize: System.data.fontUtil.xl,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      "rp ${NumberFormat("#,##0", System.data.resource.locale).format(vm.totalToBePaid)}"),
                                  style: System.data.textStyleUtil.mainLabel(
                                      color: System.data.colorUtil.redColor,
                                      fontSize: System.data.fontUtil.xxl,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
              children: [
                widget.enumUtil == EnumUtil.OutCome
                    ? Container(
                        decoration: BoxDecoration(
                          color: System.data.colorUtil.secondaryColor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: System.data.colorUtil.shadowColor
                                  .withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Text(
                          "${vm.infoOutcome}",
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontSize: System.data.fontUtil.m,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () => ontapNext(
                    year: viewModel.selectedYear ?? DateTime.now().year,
                    month: viewModel.selectedMonth?.id ?? DateTime.now().month,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 30, left: 10, bottom: 40, right: 10),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: System.data.colorUtil.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "${System.data.resource.next}",
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.secondaryColor,
                          fontSize: System.data.fontUtil.m,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dateWidget(ViewModel vm) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 3, left: 3),
              child: InputData.inputData(
                  widTitle: 40,
                  typeInput: TypeInput.Dropdown,
                  title: "${System.data.resource.month} ",
                  list: vm.listMonths,
                  onChangeds: (v) => vm.selectMonth(v),
                  hint:
                      "${System.data.resource.select} ${System.data.resource.month}",
                  selectedItem: vm.selectedMonth),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 3, right: 3),
              child: InputData.inputData(
                  widTitle: 40,
                  typeInput: TypeInput.Dropdown,
                  title: "${System.data.resource.year}",
                  list: vm.listYears(),
                  onChangeds: (v) => vm.selectYear(v),
                  hint:
                      "${System.data.resource.select} ${System.data.resource.year}",
                  getNames: false,
                  selectedItem: vm.selectedYear),
            ),
          ),
        ],
      ),
    );
  }
}
