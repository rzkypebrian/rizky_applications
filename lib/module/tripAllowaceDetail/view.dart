import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/HeroComponent.dart';
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
        create: (BuildContext context) => data,
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
      title: "${System.data.resource.travelingExpenses}",
      titleStyle: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
        fontSize: System.data.fontUtil.xl,
      ),
      backgroundColor: System.data.colorUtil.primaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
    );
  }

  Widget body(ViewModel vm) {
    return Container(
      child: Column(
        children: <Widget>[
          itemListData(widget.tripAllowanceSummary),
          vehicle(widget.tripAllowanceSummary),
          expand(widget.tripAllowanceSummary),
        ],
      ),
    );
  }

  Widget vehicle(TripAllowanceSummary ao) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: System.data.colorUtil.shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.vehicle}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      toBeginningOfSentenceCase("${ao.vehicleName}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.vehicleNumber}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      toBeginningOfSentenceCase("${ao.vehicleNumber}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.vehicle}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      toBeginningOfSentenceCase("${ao.transporterName}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: detailVehicle,
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Text(
                        toBeginningOfSentenceCase(
                            "${System.data.resource.detail}"),
                        style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.primaryColor,
                            textDecoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget expand(TripAllowanceSummary ao) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${System.data.resource.vehicleType}",
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Text(
                    "${System.data.resource.price}",
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.primaryColor,
                    ),
                  ),
                )),
                Container(
                  child: Text(
                    "${System.data.resource.photo}",
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: System.data.colorUtil.disableColor,
          ),
          Column(
            children: List.generate(ao.uangJalanDetailExpense.length, (i) {
              return itemExpanded(
                title: ao.uangJalanDetailExpense[i].expenseDescription,
                amount: ao.uangJalanDetailExpense[i].expenseValue,
                photo: ao.uangJalanDetailExpense[i].expenseFile,
              );
            }),
          ),
          Divider(
            color: System.data.colorUtil.disableColor,
          ),
          itemExpanded(
            title: System.data.resource.total,
            amount: ao.totalExpense,
            photo: "",
          )
        ],
      ),
    );
  }

  Widget itemExpanded({String title, double amount, String photo}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  toBeginningOfSentenceCase("$title"),
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: Text(
                "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(amount)}",
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.primaryColor,
                ),
              ),
            )),
            GestureDetector(
              onTap: () {
                if (photo != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return HeroComponent(
                          pathImage: '$photo',
                          tagImage: "belajraHero",
                        );
                      },
                    ),
                  );
                }
              },
              child: Image.network(
                '$photo',
                height: 20,
                width: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemListData(TripAllowanceSummary ao) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(20),
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
                                        style:
                                            System.data.textStyleUtil.mainLabel(
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
                                        style:
                                            System.data.textStyleUtil.mainLabel(
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
    );
  }
}
