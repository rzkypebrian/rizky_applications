import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'presenter.dart';

class AngkutBillingView extends State<Presenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: System.data.colorUtil.greyColor,
      body: billingView(),
    );
  }

  Widget appBar() {
    return BottonComponent.customAppBar1(
        context: context,
        elevetion: 0,
        backgroundColor: System.data.colorUtil.blueColor,
        titleColor: System.data.colorUtil.lightTextColor,
        title: System.data.resource.bill,
        actionText: System.data.resource.back);
  }

  Widget billingView() {
    String billNumber = "XXXXXX";
    double billSum = 2500000;
    double billPPN = 2500;
    double billAmount = 2502500;
    DateTime dueDate = DateTime.now();
    DateTime paymentDate = DateTime.now();

    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: 30,
              margin: EdgeInsets.only(top: 15, left: 13),
              child: Row(
                children: <Widget>[
                  Text(
                    "No Tagihan $billNumber",
                    style: System.data.textStyleUtil.mainLabel(
                        fontSize: System.data.fontUtil.m,
                        color: System.data.colorUtil.blueColor),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(
                top: 12,
                left: 13,
                right: 13,
              ),
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${System.data.resource.billSum} ",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              fontSize: System.data.fontUtil.m,
                                              color: System
                                                  .data.colorUtil.blueColor),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 18),
                                    child: Text(
                                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(billSum)}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blackColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    //margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      "${System.data.resource.billPPN} ",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blueColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(billPPN)}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blackColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            child: Divider(
                              color: System.data.colorUtil.borderInputColor,
                              indent: 200,
                              endIndent: 0,
                              thickness: 1.0,
                            ),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${System.data.resource.billAmount} ",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blueColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(billAmount)}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.errorColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${System.data.resource.duaDate} ",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blueColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        DateFormat(
                                                System.data.resource.dateFormat,
                                                System.data.resource.locale)
                                            .format(dueDate),
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color:
                                              System.data.colorUtil.blackColor,
                                          fontSize: System.data.fontUtil.m,
                                        ),
                                      )),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${System.data.resource.paymentDate} ",
                                      style:
                                          System.data.textStyleUtil.mainLabel(
                                        color: System.data.colorUtil.blueColor,
                                        fontSize: System.data.fontUtil.m,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        DateFormat(
                                                System.data.resource.dateFormat,
                                                System.data.resource.locale)
                                            .format(paymentDate),
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color:
                                              System.data.colorUtil.blackColor,
                                          fontSize: System.data.fontUtil.m,
                                        ),
                                      )),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: SvgPicture.asset(
                                      "assets/angkut/notpayed.svg",
                                      width: 126,
                                      height: 40,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
