import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:component_icons/font_awesome.dart';

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
                children: [body(vm), circularProgressIndicatorDecoration(vm)],
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
          Text(toBeginningOfSentenceCase(System.data.resource.driverSpareMoney),
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
          tabHeader(vm),
          tabContent(vm),
        ],
      ),
    );
  }

  Widget tabHeader(ViewModel vm) {
    return Container(
      width: double.infinity,
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
      child: TabBar(
        controller: vm.tabController,
        indicatorColor: System.data.colorUtil.primaryColor,
        labelStyle:
            System.data.textStyleUtil.titleTable(fontWeight: FontWeight.bold),
        labelColor: System.data.colorUtil.darkTextColor,
        labelPadding: EdgeInsets.only(left: 5, right: 5),
        indicatorSize: TabBarIndicatorSize.label,
        onTap: vm.setVCurrentIndexTab,
        tabs: [
          Tab(text: toBeginningOfSentenceCase(System.data.resource.balance)),
          Tab(text: toBeginningOfSentenceCase(System.data.resource.seep)),
          Tab(text: toBeginningOfSentenceCase(System.data.resource.incentive)),
        ],
      ),
    );
  }

  Widget tabContent(ViewModel vm) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: TabBarView(
          controller: vm.tabController,
          children: [
            tabBalance(vm),
            tabSeep(vm),
            tabIncentif(vm),
          ],
        ),
      ),
    );
  }

  Widget tabBalance(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 100,
                      color: Colors.red,
                      child: SvgPicture.asset(
                        "assets/tms/asBalance.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text(
                              toBeginningOfSentenceCase(
                                  "${System.data.resource.remainingBalance}"),
                              style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              toBeginningOfSentenceCase(
                                  "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getRemainceBalance)}"),
                              style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.primaryColor,
                                fontSize: System.data.fontUtil.font26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: System.data.colorUtil.secondaryColor,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: System.data.colorUtil.shadowColor))),
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.history}"),
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    color: System.data.colorUtil.secondaryColor,
                    child: Column(
                      children: vm.listBalance.stocks.length > 0
                          ? List.generate(
                              vm.listBalance.stocks.length,
                              (index) {
                                final HistoryStockModel _hsm =
                                    HistoryStockModel(
                                  dateTime: vm.listBalance.dateTime,
                                  vehicle: vm.listBalance.vehicle,
                                  pokect: vm.listBalance.pokect,
                                  stocks: [],
                                );
                                _hsm.stocks.add(vm.listBalance.stocks[index]);
                                return itemBalance(_hsm);
                              },
                            )
                          : [],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBalance(HistoryStockModel hsm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.shadowColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          right: 10,
                        ),
                        child: Icon(
                            FontAwesomeSolid(hsm.stocks.first.flowBalance == 1
                                ? FontAwesomeId.fa_arrow_alt_right
                                : FontAwesomeId.fa_arrow_alt_left),
                            color: hsm.stocks.first.flowBalance == 1
                                ? System.data.colorUtil.primaryColor
                                : System.data.colorUtil.redColor),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(hsm
                                      .stocks.first.flowBalance ==
                                  1
                              ? ""
                              : "${System.data.resource.prNumber} : ${hsm.stocks.first.prNumber}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${DateFormat('yyyy-MM-dd').format(hsm.dateTime)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(hsm.stocks.first.flowBalance == 1 ? hsm.stocks.first.incomeBalance : hsm.stocks.first.outcomeBalance)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (hsm.stocks.first.flowBalance == 1)
                      onTapHeroImage(
                          name: "${hsm.stocks.first.prNumber}",
                          path: "${hsm.stocks.first.image}");
                    else
                      onTapDetail(hsm);
                  },
                  child: hsm.stocks.first.flowBalance == 1
                      ? Container(
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: Image.network(
                            "${hsm.stocks.first.image}",
                            fit: BoxFit.fitHeight,
                            errorBuilder: (bb, o, st) => Container(
                              width: 28,
                              height: 16,
                              child:
                                  SvgPicture.asset("assets/erroImage.svg"),
                            ),
                          ),
                        )
                      : Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.detail}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.primaryColor,
                            ),
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tabSeep(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/tms/asRembes.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text(
                              toBeginningOfSentenceCase(
                                  "${System.data.resource.seep}"),
                              style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              toBeginningOfSentenceCase(
                                  "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getRemainceSeep)}"),
                              style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.primaryColor,
                                fontSize: System.data.fontUtil.font26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: System.data.colorUtil.secondaryColor,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: System.data.colorUtil.shadowColor))),
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.history}"),
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    color: System.data.colorUtil.secondaryColor,
                    child: Column(
                      children: vm.listSeep.stocks.length > 0
                          ? List.generate(vm.listSeep.stocks.length, (index) {
                              final HistoryStockModel _hsm = HistoryStockModel(
                                dateTime: vm.listBalance.dateTime,
                                vehicle: vm.listBalance.vehicle,
                                pokect: vm.listBalance.pokect,
                                stocks: [],
                              );
                              _hsm.stocks.add(vm.listBalance.stocks[index]);
                              return itemSeep(_hsm);
                            })
                          : [],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemSeep(HistoryStockModel hsm) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.shadowColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.prNumber} : ${hsm.stocks.first.prNumber}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${DateFormat('yyyy-MM-dd').format(hsm.stocks.first.dateTime)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(hsm.stocks.first.remainingBalance)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      onTapDetail(hsm);
                    },
                    child: Container(
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.detail}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.primaryColor,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          hsm.stocks.first.seepStatus == 2
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.datePay} : ${DateFormat('yyyy-MM-dd').format(hsm.stocks.first.dateTime)}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.finish}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.secondaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget tabIncentif(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
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
                        "assets/tms/asIncentif.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      margin: EdgeInsets.only(top: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: toBeginningOfSentenceCase(
                                        "${System.data.resource.point}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.darkTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "1 ${System.data.resource.point} = Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.listInsentif?.multiplePoint)}",
                                    style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.darkTextColor,
                                      fontSize: System.data.fontUtil.s,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 14,
                            ),
                            child: Text(
                              toBeginningOfSentenceCase(
                                  "${NumberFormat("#,###.#", System.data.resource.locale).format(vm.listInsentif?.getTotalProcessClaim)}"),
                              style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: System.data.fontUtil.font26),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${System.data.resource.minimalClaim} ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.listInsentif?.minimClaimPoin)}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                        color: System
                                            .data.colorUtil.darkTextColor),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: vm.claimPoint,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                        color:
                                            System.data.colorUtil.primaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      toBeginningOfSentenceCase(
                                          "${System.data.resource.claim}"),
                                      style:
                                          System.data.textStyleUtil.mainLabel(
                                        color: System
                                            .data.colorUtil.secondaryColor,
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
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(16),
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
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.history}"),
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Row(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor:
                                          System.data.colorUtil.primaryColor,
                                      hoverColor:
                                          System.data.colorUtil.shadowColor,
                                      autofocus: true,
                                      onChanged: vm.setChangeValue,
                                      value: 0,
                                      groupValue: vm.groupValue,
                                    ),
                                    Container(
                                      child: Text(
                                        toBeginningOfSentenceCase(
                                            "${System.data.resource.point}"),
                                        style: System.data.textStyleUtil
                                            .mainLabel(
                                                color: System.data.colorUtil
                                                    .darkTextColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor:
                                          System.data.colorUtil.primaryColor,
                                      hoverColor:
                                          System.data.colorUtil.shadowColor,
                                      onChanged: vm.setChangeValue,
                                      value: 1,
                                      groupValue: vm.groupValue,
                                    ),
                                    Container(
                                      child: Text(
                                        toBeginningOfSentenceCase(
                                            "${System.data.resource.claim}"),
                                        style: System.data.textStyleUtil
                                            .mainLabel(
                                                color: System.data.colorUtil
                                                    .darkTextColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    child: vm.groupValue == 0 ? listPoints(vm) : listClaim(vm),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listPoints(ViewModel vm) {
    var _listPoint = vm.listInsentif.pointModels;
    return Container(
      child: Column(
        children: List.generate(
          _listPoint.length,
          (index) => Container(
            margin: EdgeInsets.only(bottom: 14),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 6),
                  margin: EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: System.data.colorUtil.shadowColor,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.orderNumber} : ${_listPoint[index].numberOder}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${DateFormat('yyyy-MM-dd').format(_listPoint[index].dateTime)}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${_listPoint[index].customer}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => detailPoint(_listPoint[index]),
                        child: Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.detail}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${_listPoint[index].desc}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${NumberFormat("#,###.#", System.data.resource.locale).format(_listPoint[index].totalPoint)}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
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
      ),
    );
  }

  Widget listClaim(ViewModel vm) {
    var _detailClaimModel = vm.listInsentif.claimModels;
    return Container(
      child: Column(
        children: List.generate(
          _detailClaimModel.length,
          (index) => Container(
            margin: EdgeInsets.only(bottom: 14),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 6),
                  margin: EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: System.data.colorUtil.shadowColor,
                      ),
                    ),
                  ),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${DateFormat('yyyy-MM-dd').format(_detailClaimModel[index].dateTime)}"),
                    textAlign: TextAlign.end,
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.point} ${NumberFormat("#,###.#", System.data.resource.locale).format(_detailClaimModel[index].point)}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      _detailClaimModel[index].status == 1
                          ? Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: System.data.colorUtil.yellowColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.only(bottom: 6),
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${System.data.resource.claimProcess}"),
                                textAlign: TextAlign.end,
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.secondaryColor,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.totalAmount} : ${NumberFormat("#,###.#", System.data.resource.locale).format(_detailClaimModel[index].amount)}"),
                    textAlign: TextAlign.start,
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                _detailClaimModel[index].status == 2
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 6),
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${System.data.resource.datePay} : ${DateFormat('yyyy-MM-dd').format(_detailClaimModel[index].dateTime)}"),
                                textAlign: TextAlign.end,
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: System.data.colorUtil.primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.only(bottom: 6),
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${System.data.resource.finish}"),
                                textAlign: TextAlign.end,
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
