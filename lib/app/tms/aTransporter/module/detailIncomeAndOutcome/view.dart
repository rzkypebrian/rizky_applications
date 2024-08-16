import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            iom(vm),
            totalResult(vm),
            shipment(vm),
          ],
        ),
      ),
    );
  }

  Widget iom(ViewModel vm) {
    return Container(
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
      padding: EdgeInsets.all(19),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          information(vm),
          transaction(vm),
          customer(vm),
          income(vm),
        ],
      ),
    );
  }

  Widget information(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 15),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.blueColor,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              toBeginningOfSentenceCase(
                  "${System.data.resource.recipientInformation}"),
              style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.darkTextColor,
                  fontSize: System.data.fontUtil.m,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.recipientInformation}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${vm.getIncomeAndOutcomeModel?.statusPayment?.name}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
              ],
            ),
          ),
          vm.getIncomeAndOutcomeModel.typeProcess == 2
              ? Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.dueDate}"),
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontSize: System.data.fontUtil.m),
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${DateFormat('yyyy-MM-dd').format(vm.getIncomeAndOutcomeModel.dateTime)}"),
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontSize: System.data.fontUtil.m),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget transaction(ViewModel vm) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 15),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.blueColor,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              toBeginningOfSentenceCase(
                  "${System.data.resource.detailTransaction}"),
              style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.darkTextColor,
                  fontSize: System.data.fontUtil.m,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.travelingExpenses}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.travelExpense ?? 0)}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.helpPeople}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.helpPeople ?? 0)}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.miscellaneousExpense}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.miscellaneousExpense ?? 0)}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.blueColor,
                  width: 1,
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.insuranceFee}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.insurangFee ?? 0)}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customer(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.totalPaidByCustomer}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.totalPaidByCustomer ?? 0)}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.serviceFee}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                      fontSize: System.data.fontUtil.m,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.serviceFee ?? 0)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                      fontSize: System.data.fontUtil.m,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.blueColor,
                  width: 1,
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.insuranceFee}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                      fontSize: System.data.fontUtil.m,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.insurangFee ?? 0)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                      fontSize: System.data.fontUtil.m,
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

  Widget income(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.totalYourIncome}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.l),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.total ?? 0)}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.redColor,
                        fontSize: System.data.fontUtil.xl),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget shipment(ViewModel vm) {
    return Container(
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
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(19),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.blueColor,
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.deliverySummary}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.seeDetail}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.blueColor,
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.transporter}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${vm.tmsShipmentDestinationModel.transporterName}"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: SvgPicture.asset(
                      "assets/distanceOriginToDestination.svg"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${vm.tmsShipmentDestinationModel.distanceOriginToDestination} Km"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 6),
                  child: SvgPicture.asset("assets/clock.svg"),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${vm.tmsShipmentDestinationModel.distanceOriginToDestination} Km"),
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        child: SvgPicture.asset("assets/trolley.svg"),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.pickUpLocation}"),
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.primaryColor,
                                fontSize: System.data.fontUtil.m),
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
                        width: 20,
                        child: Icon(
                          FontAwesomeLight(FontAwesomeId.fa_ellipsis_v),
                          color: System.data.colorUtil.primaryColor,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${vm.tmsShipmentDestinationModel.originAddress}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                        color:
                                            System.data.colorUtil.darkTextColor,
                                        fontSize: System.data.fontUtil.m),
                                  ),
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${DateFormat('yyyy-MM-dd H:m').format(vm.tmsShipmentDestinationModel.arrivalETAToDestination)}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                        color:
                                            System.data.colorUtil.darkTextColor,
                                        fontSize: System.data.fontUtil.m),
                                  ),
                                ),
                              ],
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
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        child: SvgPicture.asset("assets/pointMaps.svg"),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.destination}"),
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.primaryColor,
                                fontSize: System.data.fontUtil.m),
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
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${vm.tmsShipmentDestinationModel.originAddress}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                        color:
                                            System.data.colorUtil.darkTextColor,
                                        fontSize: System.data.fontUtil.m),
                                  ),
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${DateFormat('yyyy-MM-dd H:m').format(vm.tmsShipmentDestinationModel.arrivalETAToDestination)}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                        color:
                                            System.data.colorUtil.darkTextColor,
                                        fontSize: System.data.fontUtil.m),
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }

  Widget totalResult(ViewModel vm) {
    return Container(
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
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.totalYourIncome}"),
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                          fontSize: System.data.fontUtil.l,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      toBeginningOfSentenceCase(
                          "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(vm.getIncomeAndOutcomeModel.total ?? 0)}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.redColor,
                        fontSize: System.data.fontUtil.xl,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: invoice,
            child: Container(
              height: 70,
              color: System.data.colorUtil.primaryColor,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.incoive}"),
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.secondaryColor,
                          fontSize: System.data.fontUtil.m,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: Icon(
                      FontAwesomeLight(FontAwesomeId.fa_chevron_right),
                      color: System.data.colorUtil.secondaryColor,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
