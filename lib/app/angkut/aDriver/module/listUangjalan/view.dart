import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart'
    as sieradDecoration;
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Viewer>(
      create: (BuildContext context) => model,
      child: Consumer<Viewer>(
        builder: (ctx, dt, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(dt),
            body: home(dt),
          );
        },
      ),
    );
  }

  PreferredSizeWidget appBar(Viewer dt) {
    return BottonComponent.customAppBar1(
        title: System.data.resource.allowance,
        context: context,
        actionText: "",
        titleColor: System.data.colorUtil.secondaryColor,
        backButtonColor: System.data.colorUtil.lightTextColor,
        actionTextStyle: System.data.textStyleUtil.mainLabel(),
        actionTextColor: System.data.colorUtil.secondaryColor,
        titleStyle: System.data.textStyleUtil.mainTitle(),
        backgroundColor: System.data.colorUtil.primaryColor,
        rightWidget: null);
  }

  Widget angkutDecorationComponent() {
    return DecorationComponent.circularLOadingIndicator(
      controller: model.loadingController,
    );
  }

  Widget home(Viewer dt) {
    return Container(
      color: System.data.colorUtil.scaffoldBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          getListUangJalan(),
          angkutDecorationComponent(),
        ],
      ),
    );
  }

  Widget getListUangJalan() {
    return Container(
      // margin: EdgeInsets.only(top: 10),F
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(0),
            child: sieradDecoration.DecorationComponent.serachHistoryDecoration(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(bottom: 10, top: 10),
              colorBackground: Colors.transparent,
              controller: searchController,
              onChange: onSearchChange,
            ),
          ),
          Expanded(
            child: ListDataComponent<TripAllowanceSummary>(
              controller: listDataController,
              getNewData: getNewUangJalanList,
              getOldData: getOldUangJalanList,
              loadingWidgetBuilder: ((controller) {
                return DecorationComponent.circularLOadingIndicator(
                  controller: controller,
                );
              }),
              itemBuilder: (shipment, i) {
                return Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: itemListData(ao: shipment, onTap: onSelected));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemListData(
      {TripAllowanceSummary ao, ValueChanged<TripAllowanceSummary> onTap}) {
    return GestureDetector(
      onTap: () => onTap(ao),
      child: Container(
        height: 120,
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
                              "assets/angkut/barcode.svg",
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
                                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(ao.beginningBalance)}"),
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
