import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/HistoryStockModel.dart';
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
      title: Text(toBeginningOfSentenceCase(System.data.resource.maintenance),
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
          children: List.generate(vm.listDetailBalanceModel.length,
              (index) => itemBalance(vm.listDetailBalanceModel[index])),
        ),
      ),
    );
  }

  Widget itemBalance(HistoryStockModel hsm) {
    return GestureDetector(
      onTap: () => onTapDetailHistoryStock(hsm),
      child: Container(
        margin: EdgeInsets.only(bottom: 5, top: 5),
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
            Container(
              child: SvgPicture.asset(
                "assets/tms/asBalance.svg",
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width / 1.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: System.data.colorUtil.shadowColor,
                          ),
                        ),
                      ),
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${DateFormat("yyyy/MM/dd", System.data.resource.dateLocalFormat).format(hsm.dateTime)}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.driver} : ${hsm.vehicle.driverName}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.balance} : ${NumberFormat("#,###.#", System.data.resource.locale).format(hsm.getRemainceBalance)}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        textAlign: TextAlign.end,
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

  Widget tabSeep(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: List.generate(vm.listDetailSeepModel.length,
              (index) => itemSeep(vm.listDetailSeepModel[index])),
        ),
      ),
    );
  }

  Widget itemSeep(HistoryStockModel hsm) {
    return GestureDetector(
      onTap: () => onTapDetailHistoryStock(hsm),
      child: Container(
        margin: EdgeInsets.only(bottom: 5, top: 5),
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
            Container(
              child: SvgPicture.asset(
                "assets/tms/asRembes.svg",
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width / 1.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: System.data.colorUtil.shadowColor,
                          ),
                        ),
                      ),
                      child: Text(
                        toBeginningOfSentenceCase(
                            " ${DateFormat("yyyy/MM/dd", System.data.resource.dateLocalFormat).format(hsm.dateTime)}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.driver} : ${hsm.vehicle.driverName}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.balance} : ${NumberFormat("#,###.#", System.data.resource.locale).format(hsm.getRemainceBalance)}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        textAlign: TextAlign.end,
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

  Widget tabIncentif(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: List.generate(vm.listDetailInsentifModel.length,
              (index) => itemInsentif(vm.listDetailInsentifModel[index])),
        ),
      ),
    );
  }

  Widget itemInsentif(HistoryStockModel hsm) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5),
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
          Container(
            child: SvgPicture.asset(
              "assets/tms/asIncentif.svg",
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
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
                                "${hsm.vehicle.driverName}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${DateFormat("yyyy/MM/dd", System.data.resource.dateLocalFormat).format(hsm.dateTime)}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.point} : ${NumberFormat("#,###.#", System.data.resource.locale).format(hsm.getTotalProcessClaim)}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (hsm.latestClaimStatus == 1)
                          onTapDetailHistoryStock(hsm);
                      },
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: hsm.latestClaimStatus == 2
                                ? System.data.colorUtil.greyColor
                                : System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${hsm.latestClaimStatus == 2 ? System.data.resource.finish : System.data.resource.pay}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: hsm.latestClaimStatus == 2
                                  ? System.data.colorUtil.darkTextColor
                                  : System.data.colorUtil.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
