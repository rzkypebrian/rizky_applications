import 'package:component_icons/font_awesome.dart';
import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<ViewModel>(builder: (ctx, dt, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(),
            body: body(dt),
          );
        }));
  }

  Widget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${System.data.resource.allowance}",
      titleStyle: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
        fontSize: System.data.fontUtil.xl,
      ),
      backgroundColor: System.data.colorUtil.primaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
    );
  }

  Widget body(ViewModel vm) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              widget.showList ? headerTab(vm) : SizedBox(),
              bodyTab(vm),
            ],
          ),
        ),
        DecorationComponent.circularProgressDecoration(
          // margin: EdgeInsets.only(bottom: 55),
          // lightMode: false,
          controller: controller,
        )
      ],
    );
  }

  Widget headerTab(ViewModel vm) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: vm.controller,
        onTap: (val) {
          vm.indexController = val;
          vm.commint();
        },
        isScrollable: false,
        indicatorPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(color: System.data.colorUtil.primaryColor),
        tabs: <Widget>[
          Text(
            "${toBeginningOfSentenceCase(System.data.resource.input)}",
            style: System.data.textStyleUtil.linkLabel(
                color: vm.indexController == 0
                    ? System.data.colorUtil.lightTextColor
                    : System.data.colorUtil.primaryColor),
          ),
          Text(
            "${toBeginningOfSentenceCase(System.data.resource.list)}",
            style: System.data.textStyleUtil.linkLabel(
                color: vm.indexController == 1
                    ? System.data.colorUtil.lightTextColor
                    : System.data.colorUtil.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget bodyTab(ViewModel vm) {
    return Expanded(
      child: TabBarView(
        controller: vm.controller,
        children: <Widget>[
          inputData(vm),
          widget.showList ? listData(vm) : SizedBox(),
        ],
      ),
    );
  }

  Widget inputData(ViewModel vm) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      "${System.data.resource.shipmentNumber}",
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                  InputComponent.inputTextWithCorner(
                    controller: model.shimenpNumber,
                    corner: 5,
                    borderWidth: 1,
                    readOnly: widget.showList ? true : false,
                    fontSize: System.data.fontUtil.xl,
                    suffixIcon: widget.showSearchSipment
                        ? GestureDetector(
                            onTap: () {
                              if (widget.onTapSearchShipment != null) {
                                widget.onTapSearchShipment(super.model);
                              }
                            },
                            child: Icon(
                              FontAwesomeRegular(FontAwesomeId.fa_search),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "${System.data.resource.nominal}",
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                  InputComponent.inputTextWithCorner(
                    corner: 5,
                    borderWidth: 1,
                    controller: budget,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: saveData,
            child: Container(
              height: 42,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: System.data.colorUtil.primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  "${System.data.resource.send}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.lightTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget listData(ViewModel vm) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: ListDataComponent<TripAllowanceSummary>(
          controller: listDataController,
          getNewData: getNewUangJalanList,
          getOldData: getOldUangJalanList,
          loadingWidgetBuilder: ((controller) {
            return DecorationComponent.circularProgressDecoration(
              controller: controller,
            );
          }),
          itemBuilder: (shipment, i) {
            return DecorationComponent.listTileDecoretion(
              height: 130,
              widget: itemListData(ao: shipment, onTap: onSelectedData),
            );
          },
        ));
  }

  Widget shipped() {
    return ListDataComponent<TripAllowanceSummary>(
      controller: listDataController,
      getNewData: getNewUangJalanList,
      getOldData: getOldUangJalanList,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularProgressDecoration(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return DecorationComponent.listTileDecoretion(
          // height: 130,
          widget: itemListData(ao: shipment, onTap: onSelectedData),
        );
      },
    );
  }

  Widget itemListData(
      {TripAllowanceSummary ao, ValueChanged<TripAllowanceSummary> onTap}) {
    return GestureDetector(
      onTap: () => onSelectedData(ao),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: System.data.colorUtil.shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 105,
              decoration: BoxDecoration(
                color: System.data.colorUtil.lavenderColor,
                // borderRadius: BorderRadius.circular(5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.balance}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.lightTextColor,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: SvgPicture.asset(
                              "assets/barcode.svg",
                            )),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                        Container(
                          color: System.data.colorUtil.lightTextColor,
                          width: 3,
                          height: 7,
                          margin: EdgeInsets.only(right: 5, top: 2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(5),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              child: SvgPicture.asset(
                            "assets/angkut/listUangJalan.svg",
                            alignment: Alignment.center,
                          )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          toBeginningOfSentenceCase(
                                              "${ao.shipmentNumber ?? "-"}"),
                                          style: System.data.textStyleUtil
                                              .mainLabel(
                                            color: System
                                                .data.colorUtil.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          toBeginningOfSentenceCase(
                                              "${DateFormat('yyyy-MM-dd').format(ao.transactionDate)}"),
                                          style: System.data.textStyleUtil
                                              .mainLabel(
                                            color: System
                                                .data.colorUtil.primaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: System.data.colorUtil.primaryColor,
                                thickness: 1,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(ao.endingBalance)}"),
                                  style: System.data.textStyleUtil.mainLabel(
                                      color: System.data.colorUtil.primaryColor,
                                      fontSize: System.data.fontUtil.xxxl),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
