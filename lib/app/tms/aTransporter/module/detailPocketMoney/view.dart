import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/util/InputData.dart';
import 'package:enerren/util/ModeUtil.dart';
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
              bottomSheet: vm.historyStock.pokect == 1
                  ? GestureDetector(
                      onTap: () => showDetailVehicle(vm),
                      child: Container(
                        padding: EdgeInsets.only(top: 12, bottom: 12),
                        width: double.infinity,
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.addBalance}"),
                          textAlign: TextAlign.center,
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.secondaryColor,
                          ),
                        ),
                      ),
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
    return SingleChildScrollView(
        child: vm.historyStock.pokect == 1
            ? tabBalance(vm)
            : vm.historyStock.pokect == 2
                ? tabSeep(vm)
                : tabIncentif(vm));
  }

  Widget tabBalance(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
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
                  margin: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.vehicleType}"),
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.historyStock.vehicle.vehicleTypeName}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.vehicleNumber}"),
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.historyStock.vehicle.vehicleNumber}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.driverName}"),
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.historyStock.vehicle.driverName}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => onTapDetailVehicle(vm.historyStock.vehicle),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.detail}"),
                      textAlign: TextAlign.end,
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
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.65,
                    margin: EdgeInsets.only(top: 20, right: 20),
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
                                "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.historyStock.getRemainceBalance)}"),
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
                  margin: EdgeInsets.only(bottom: 100),
                  color: System.data.colorUtil.secondaryColor,
                  child: Column(
                      children: List.generate(
                    vm.historyStock.stocks.length,
                    (index) {
                      final HistoryStockModel _hsm = HistoryStockModel(
                        dateTime: vm.historyStock.dateTime,
                        vehicle: vm.historyStock.vehicle,
                        pokect: vm.historyStock.pokect,
                        stocks: [],
                      );
                      _hsm.stocks.add(vm.historyStock.stocks[index]);
                      return itemBalance(_hsm);
                    },
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBalance(HistoryStockModel hsm) {
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
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          right: 10,
                        ),
                        child: Icon(
                            FontAwesomeSolid(hsm.stocks.first.flowBalance == 1
                                ? FontAwesomeId.fa_arrow_alt_left
                                : FontAwesomeId.fa_arrow_alt_right),
                            color: hsm.stocks.first.flowBalance == 1
                                ? System.data.colorUtil.redColor
                                : System.data.colorUtil.primaryColor),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(hsm
                                      .stocks.first.flowBalance ==
                                  1
                              ? "${System.data.resource.prNumber} : ${hsm.stocks.first.prNumber}"
                              : ""),
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
                        "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(hsm.stocks.first.balance)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (hsm.stocks.first.typeProcessIo == 1) {
                      onTapDetail(hsm);
                    } else
                      onTapHeroImage(
                          name: "${hsm.stocks.first.prNumber}",
                          path: "${hsm.stocks.first.image}");
                  },
                  child: hsm.stocks.first.typeProcessIo == 1
                      ? Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.detail}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.primaryColor,
                            ),
                          ),
                        )
                      : Container(
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
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
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
                  margin: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.vehicleType}"),
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.historyStock.vehicle.vehicleTypeName}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.vehicleNumber}"),
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.historyStock.vehicle.vehicleNumber}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.driverName}"),
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.historyStock.vehicle.driverName}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => onTapDetailVehicle(vm.historyStock.vehicle),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.detail}"),
                      textAlign: TextAlign.end,
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
                                "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.historyStock.getRemainceBalance)}"),
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
                    children:
                        List.generate(vm.historyStock.stocks.length, (index) {
                      final HistoryStockModel _hsm = HistoryStockModel(
                        dateTime: vm.historyStock.dateTime,
                        vehicle: vm.historyStock.vehicle,
                        pokect: vm.historyStock.pokect,
                        stocks: [],
                      );
                      _hsm.stocks.add(vm.historyStock.stocks[index]);
                      return itemSeep(_hsm, index: index);
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemSeep(HistoryStockModel hsm, {int index}) {
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
                        "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(hsm.stocks.first.remainingBalance)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () => onTapDetail(hsm),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => onTapHeroImage(
                            name: "${hsm.stocks.first.prNumber}",
                            path: "${hsm.stocks.first.image}"),
                        child: Container(
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
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: System.data.colorUtil.primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${System.data.resource.finish}"),
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${System.data.resource.datePay} : ${DateFormat('yyyy-MM-dd').format(hsm.dateTime)}"),
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    ModeUtil.debugPrint(
                        "message ${hsm.stocks.first.remainingBalance} $index");
                    showSeep(viewModel, index: index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: System.data.colorUtil.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.pay}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.secondaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
              margin: EdgeInsets.only(bottom: 10, top: 10),
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
                    margin: EdgeInsets.only(bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.vehicleType}"),
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${vm.historyStock.vehicle.vehicleTypeName}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.vehicleNumber}"),
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${vm.historyStock.vehicle.vehicleNumber}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.driverName}"),
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${vm.historyStock.vehicle.driverName}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onTapDetailVehicle(vm.historyStock.vehicle),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.detail}"),
                        textAlign: TextAlign.end,
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
                                        "1 ${System.data.resource.point} = Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.historyStock.multiplePoint)}",
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
                                  "${NumberFormat("#,###.#", System.data.resource.locale).format(vm.historyStock.getTotalProcessClaim)}"),
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
                                        "${System.data.resource.minimalClaim} ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.historyStock.minimClaimPoin)}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                        color: System
                                            .data.colorUtil.darkTextColor),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => showClaim(viewModel),
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
                                            "${System.data.resource.claim} "),
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
    var _listPoint = vm.historyStock.pointModels;
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
                        onTap: () => null, //detailPoint(_listPoint[index]),
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
    var _detailClaimModel = vm.historyStock.claimModels;
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

  showDetailVehicle(ViewModel vm) {
    ModalComponent.bottomModalWithCorner(
      context,
      height: 300,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: InputData.inputData(
                typeInput: TypeInput.Text,
                title: "${System.data.resource.balance}",
                controller: vm.addBalanceController,
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              child: InputData.inputData(
                  typeInput: TypeInput.Text,
                  title: "${System.data.resource.uploadProofOfPayement}",
                  controller: vm.imageController,
                  sufix: GestureDetector(
                      onTap: () {
                        vm.imagePickerController
                            .getImages(camera: true, imageQuality: 30)
                            .then((value) {
                          if (value) {
                            vm.imageController.text =
                                vm.imagePickerController.getFileName();
                            vm.commit();
                          }
                        });
                      },
                      child: Container(
                        child: Icon(
                          FontAwesomeSolid(FontAwesomeId.fa_camera_alt),
                          color: System.data.colorUtil.primaryColor,
                        ),
                      ))),
            ),
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        vm.addBalance();
                        System.data.routes.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 6),
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "${System.data.resource.balance}",
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => System.data.routes.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(left: 6),
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.yellowColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "${System.data.resource.cancel}",
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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

  showSeep(ViewModel vm, {int index}) {
    ModalComponent.bottomModalWithCorner(
      context,
      height: 300,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("${System.data.resource.balance}"),
                  ),
                  Container(
                    child: Text(
                        "${NumberFormat("#,###.#", System.data.resource.locale).format(vm.historyStock.stocks[index].remainingBalance * -1)}"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 13),
              child: InputData.inputData(
                typeInput: TypeInput.Text,
                title: "${System.data.resource.uploadProofOfPayement}",
                controller: vm.imageController,
                sufix: GestureDetector(
                  onTap: () {
                    vm.imagePickerController
                        .getImages(camera: true, imageQuality: 30)
                        .then((value) {
                      if (value) {
                        ModeUtil.debugPrint(
                            " vm.imagePickerController.getFileName() ${vm.historyStock.stocks[index]}");
                        vm.imageController.text =
                            vm.imagePickerController.getFileName();
                        vm.commit();
                      }
                    });
                  },
                  child: Container(
                    child: Icon(
                      FontAwesomeSolid(FontAwesomeId.fa_camera_alt),
                      color: System.data.colorUtil.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        vm.addSeep(index: index);
                        System.data.routes.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 6),
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "${System.data.resource.pay} ",
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => System.data.routes.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(left: 6),
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.yellowColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "${System.data.resource.cancel}",
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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

  showClaim(ViewModel vm) {
    ModalComponent.bottomModalWithCorner(
      context,
      height: 300,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(toBeginningOfSentenceCase(
                        "${System.data.resource.point}")),
                  ),
                  Container(
                    child: Text(
                        "${NumberFormat("#,###.#", System.data.resource.locale).format(vm.historyStock.getTotalProcessClaim)}"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(toBeginningOfSentenceCase(
                        "${System.data.resource.balance}")),
                  ),
                  Container(
                    child: Text(toBeginningOfSentenceCase(
                        "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.historyStock.getTotalProcessClaim * vm.historyStock.multiplePoint)}")),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 13),
              child: InputData.inputData(
                typeInput: TypeInput.Text,
                title: "${System.data.resource.uploadProofOfPayement}",
                controller: vm.imageController,
                sufix: GestureDetector(
                  onTap: () {
                    vm.imagePickerController
                        .getImages(camera: true, imageQuality: 30)
                        .then((value) {
                      if (value) {
                        vm.imageController.text =
                            vm.imagePickerController.getFileName();
                        vm.commit();
                      }
                    });
                  },
                  child: Container(
                    child: Icon(
                      FontAwesomeSolid(FontAwesomeId.fa_camera_alt),
                      color: System.data.colorUtil.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        vm.claimPoint();
                        System.data.routes.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 6),
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.pay}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => System.data.routes.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(left: 6),
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.yellowColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "${System.data.resource.cancel}",
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
}
