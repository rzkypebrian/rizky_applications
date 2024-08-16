// import 'package:enerren/app/angkut/model/AngkutBill.dart';
// import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
// import 'package:enerren/util/TextStyleUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:enerren/component/BottonComponent.dart';

import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<ViewModel>(builder: (ctx, vm, child) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
                appBar: appBar(vm: vm),
                body: body(vm),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: circularProgressIndicatorDecoration(),
              )
            ],
          );
        }));
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
      controller: model.loadingController,
    );
  }

  PreferredSizeWidget appBar({ViewModel vm}) {
    return BottonComponent.customAppBar1(
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "",
      context: context,
      backButtonColor: System.data.colorUtil.lightTextColor,
      title: System.data.resource.incomingSummary,
      titleStyle: System.data.textStyleUtil.mainTitle(),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            incomingSummary(vm),
          ],
        ),
      ),
    );
  }

  Widget incomingSummary(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(
        30,
      ),
      decoration: BoxDecoration(
          color: System.data.colorUtil.lightTextColor,
          boxShadow: <BoxShadow>[
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "${System.data.resource.monthSelection}",
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                        fontSize: System.data.fontUtil.m),
                  ),
                ),
                mounthDropDown(),
                yearDropDown(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 120,
            child: Stack(
              children: <Widget>[
                Align(
                  child: SvgPicture.asset(
                    'assets/angkut/totalIcoming.svg',
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 40, right: 15),
                    child: Text(
                      "${System.data.resource.totalYouGet}",
                      style: System.data.textStyleUtil.mainLabel(
                          fontSize: System.data.fontUtil.xxxl,
                          color: System.data.colorUtil.lightTextColor),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, right: 15),
                    child: Text(
                      "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.sumTakeHoePayAngkut)}",
                      style: System.data.textStyleUtil.mainLabel(
                          fontSize: System.data.fontUtil.xxxl,
                          color: System.data.colorUtil.lightTextColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          listIncomes(),
        ],
      ),
    );
  }

  Widget listIncomes() {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 30),
      child: BottonComponent.roundedButton(
        onPressed: gotoList,
        colorBackground: System.data.colorUtil.primaryColor,
        radius: 5,
        text: "${System.data.resource.listInCome}",
        textColor: Colors.red,
        textstyle: System.data.textStyleUtil
            .mainTitle(color: System.data.colorUtil.lightTextColor),
      ),
    );
  }

  Widget mounthDropDown() {
    return Container(
      child: DropdownButton<int>(
        items: List.generate(11, (i) {
          return DropdownMenuItem<int>(
            child: Text(
                "${DateFormat("MMMM", System.data.resource.dateLocalFormat).format(DateTime(1990, i + 1))}"),
            value: i + 1,
          );
        }),
        onChanged: (value) {
          model.setMonth(value);
          getOutComeSummary();
        },
        value: model.month,
      ),
    );
  }

  Widget yearDropDown() {
    return Container(
      child: DropdownButton<int>(
        items: List.generate(11, (i) {
          return DropdownMenuItem<int>(
            child: Text("${DateTime.now().year - i}"),
            value: DateTime.now().year - i,
          );
        }),
        onChanged: (value) {
          model.setYear(value);
          getOutComeSummary();
        },
        value: model.year,
      ),
    );
  }
}
