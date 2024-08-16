import 'package:enerren/app/angkut/model/AngkutBill.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<ViewModel>(builder: (ctx, vm, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: AppBar(),
            body: body(vm),
          );
        }));
  }

  // PreferredSizeWidget appBar({ViewModel vm, BuildContext context}) {
  //   return BottonComponent.customAppBar1(
  //     backgroundColor: System.data.colorUtil.primaryColor,
  //     actionText: "",
  //     context: context,
  //     backButtonColor: System.data.colorUtil.lightTextColor,
  //     title: System.data.resource.bill,
  //     titleStyle: System.data.textStyleUtil.mainTitle(),
  //   );
  // }

  Widget body(ViewModel vm) {
    return Container(
      child: ListView(
        children: List.generate(
          vm.listAngkutBill.length,
          (i) {
            ModeUtil.debugPrint(i);
            // return listBillCredit(vm.listAngkutBill[i]);
            return listBillDebt(vm.listAngkutBill[i]);
          },
        ),
      ),
    );
  }

  Widget listBillCredit(AngkutBill angkutBill) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 14, right: 14),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: System.data.colorUtil.lightTextColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: System.data.colorUtil.greyColor,
          ),
          boxShadow: <BoxShadow>[
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            itemData(
                title: "No Tagihan XXXXXXX",
                value: angkutBill.billNumber,
                valueType: DataType.String),
            Divider(
              thickness: 2,
            ),
            itemData(
                title: "Jumlah Tagihan",
                value: angkutBill.debtAmount,
                valueType: DataType.Double),
            itemData(
                title: "PPN",
                value: angkutBill.ppn,
                valueType: DataType.Double),
            Container(
              width: 200,
              child: Divider(
                thickness: 2,
              ),
            ),
            itemData(
                title: "Total Tagihan",
                value: angkutBill.debtTotal,
                valueType: DataType.Double,
                color: System.data.colorUtil.redColor),
            itemData(
                title: "Tanggal Jatuh Tempo",
                value: angkutBill.dateTimeDue,
                valueType: DataType.Date),
            itemData(
                title: "Tanggal Pembayaran",
                value: angkutBill.datePay,
                valueType: DataType.Date),
            itemData(
                title: "",
                value: angkutBill.status ? "lunas" : "belumbayar",
                valueType: DataType.Svg),
          ],
        ));
  }

  Widget listBillDebt(AngkutBill angkutBill) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 14, right: 14),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: System.data.colorUtil.lightTextColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: System.data.colorUtil.greyColor,
          ),
          boxShadow: <BoxShadow>[
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            itemData(
                title: "No Tagihan XXXXXXX",
                value: angkutBill.billNumber,
                valueType: DataType.String),
            Divider(
              thickness: 2,
            ),
            itemData(
                title: "Pendapatan",
                value: angkutBill.income,
                valueType: DataType.Double),
            itemData(
                title: "Fee Angkut",
                value: angkutBill.fee,
                valueType: DataType.Double),
            Container(
              width: 200,
              child: Divider(
                thickness: 2,
              ),
            ),
            itemData(
                title: "Total Tagihan",
                value: angkutBill.debtTotal,
                valueType: DataType.Double,
                color: System.data.colorUtil.redColor),
            itemData(
                title: "Tanggal Pembayaran",
                value: angkutBill.datePay,
                valueType: DataType.Date),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () => {},
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: angkutBill.status
                                ? System.data.colorUtil.greyColor
                                : System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            "${System.data.resource.paynow}",
                            style: System.data.textStyleUtil.mainLabel(
                                fontWeight: FontWeight.bold,
                                color: System.data.colorUtil.lightTextColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                          "assets/angkut/${angkutBill.status ? "lunas" : "belumbayar"}.svg"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget itemData({String title, var value, DataType valueType, Color color}) {
    color = color ?? System.data.colorUtil.blackColor;
    var resVvalue;
    if (valueType == DataType.String) {
      resVvalue = Text(
        "$value",
        style: System.data.textStyleUtil.mainLabel(color: color),
      );
    } else if (valueType == DataType.Bool) {
      resVvalue = Text(
        "$value",
        style: System.data.textStyleUtil.mainLabel(color: color),
      );
    } else if (valueType == DataType.Int || valueType == DataType.Double) {
      resVvalue = Text(
        "${NumberFormat("#,###.#", System.data.resource.locale).format(value)}",
        style: System.data.textStyleUtil.mainLabel(color: color),
      );
    } else if (valueType == DataType.Date) {
      resVvalue = Text(
        "${DateFormat('yyyy-MM-dd').format(value)}",
        style: System.data.textStyleUtil.mainLabel(color: color),
      );
    } else if (valueType == DataType.Svg) {
      resVvalue = SvgPicture.asset("assets/angkut/$value.svg");
    }
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "$title",
                style: System.data.textStyleUtil
                    .mainLabel(color: System.data.colorUtil.primaryColor),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: resVvalue,
            ),
          ),
        ],
      ),
    );
  }
}
