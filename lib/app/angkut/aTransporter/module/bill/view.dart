import 'package:enerren/app/angkut/model/AngkutBill.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TextStyleUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:enerren/component/BottonComponent.dart';

import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<ViewModel>(builder: (ctx, vm, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(vm: vm),
            body: body(vm),
          );
        }));
  }

  PreferredSizeWidget appBar({ViewModel vm}) {
    return BottonComponent.customAppBar1(
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "",
      context: context,
      backButtonColor: System.data.colorUtil.lightTextColor,
      title: System.data.resource.bill,
      titleStyle: System.data.textStyleUtil.mainTitle(),
    );
  }

  Widget body(ViewModel vm) {
    return Container(
      margin: EdgeInsets.all(0),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: List.generate(
          vm.listAngkutBill.length,
          (i) {
            ModeUtil.debugPrint(i);
            return listBill(vm.listAngkutBill[i]);
          },
        ),
      ),
    );
  }

  Widget listBill(AngkutBill angkutBill) {
    return GestureDetector(
      onTap: angkutBill.status ? incoming : payment,
      child: Container(
        margin: EdgeInsets.only(right: 14, left: 14, top: 4, bottom: 4),
        height: 120,
        decoration: BoxDecoration(
            color: System.data.colorUtil.scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
               BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
            ]),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: SvgPicture.asset(
                  angkutBill.status
                      ? 'assets/angkut/incoming.svg'
                      : 'assets/angkut/payment.svg',
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(left: 40, bottom: 4),
                child: Text(
                  angkutBill.typeBill != 'debt'
                      ? System.data.resource.credit
                      : System.data.resource.debt,
                  style: TextStyleUtil().mainLabel(
                      color: System.data.colorUtil.lightTextColor,
                      fontSize: System.data.fontUtil.xxlPlus,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
