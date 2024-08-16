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
      title: Text(toBeginningOfSentenceCase("${System.data.resource.income} & ${System.data.resource.outCome}"),
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
          menu(
              pathIcon: "assets/tms/billReceived.svg",
              callback: ontapReceived,
              title: System.data.resource.income),
          menu(
              pathIcon: "assets/tms/billPay.svg",
              callback: ontapPay,
              title: System.data.resource.outCome),
        ],
      ),
    );
  }

  Widget menu({String pathIcon, Function callback, String title}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: System.data.colorUtil.shadowColor,
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
                  "$pathIcon",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  toBeginningOfSentenceCase("$title"),
                  style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                      fontSize: System.data.fontUtil.xxl,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
