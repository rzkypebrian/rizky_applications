import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/InputData.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:enerren/model/MutationModel.dart';

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
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(toBeginningOfSentenceCase(System.data.resource.stock),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            periode(vm),
            search(vm),
            listMutasi(vm),
          ],
        ),
      ),
    );
  }

  Widget periode(ViewModel vm) {
    return Container(
      width: double.infinity,
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 13),
            child: Text(
              toBeginningOfSentenceCase(System.data.resource.period),
              style: System.data.textStyleUtil.mainTitle(
                color: System.data.colorUtil.darkTextColor,
              ),
            ),
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: InputData.inputData(
                      widTitle: 50,
                      title: System.data.resource.start,
                      controller: vm.startController,
                      context: context,
                      typeInput: TypeInput.Date,
                      sufix: Icon(
                        FontAwesomeLight(FontAwesomeId.fa_calendar_alt),
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: InputData.inputData(
                      widTitle: 50,
                      title: System.data.resource.end,
                      controller: vm.endController,
                      context: context,
                      typeInput: TypeInput.Date,
                      sufix: Icon(
                        FontAwesomeLight(FontAwesomeId.fa_calendar_alt),
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget search(vm) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 8, right: 8),
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
      child: InputData.inputData(
          colorBorder: Colors.transparent,
          borderWidth: 0,
          isBorder: false,
          controller: vm.searchController,
          hint: "${System.data.resource.search}",
          contentPadding: EdgeInsets.only(top: 15),
          prefix: Container(
              child: GestureDetector(
            onTap: () => null,
            child: Container(
              child: Icon(
                FontAwesomeLight(FontAwesomeId.fa_search),
                color: System.data.colorUtil.primaryColor,
              ),
            ),
          ))),
    );
  }

  Widget listMutasi(ViewModel vm) {
    return Container(
      child: Column(
        children: List.generate(vm.listMutation.length,
            (index) => itemMutasi(mm: vm.listMutation[index])),
      ),
    );
  }

  Widget itemMutasi({MutationModel mm}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: System.data.colorUtil.darkTextColor,
                ),
              ),
            ),
            child: Text(
              toBeginningOfSentenceCase("${mm.title}"),
              textAlign: TextAlign.center,
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.darkTextColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.mutationIn} : ${NumberFormat("#,###.#", System.data.resource.locale).format(mm.inputs)}"),
                    textAlign: TextAlign.center,
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.earlyStock} : ${NumberFormat("#,###.#", System.data.resource.locale).format(mm.lasts)}"),
                    textAlign: TextAlign.center,
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.mutationOut} : ${NumberFormat("#,###.#", System.data.resource.locale).format(mm.outs)}"),
                    textAlign: TextAlign.center,
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: mm.finals == 0
                        ? System.data.colorUtil.redColor
                        : System.data.colorUtil.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.lastStock} : ${NumberFormat("#,###.#", System.data.resource.locale).format(mm.finals)}"),
                    textAlign: TextAlign.center,
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
