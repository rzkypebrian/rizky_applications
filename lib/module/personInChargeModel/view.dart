import 'package:enerren/component/tmsDecorationComponent.dart';
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
              bottomSheet: GestureDetector(
                onTap: vm.removePersonInChargeModel,
                child: Container(
                  margin: EdgeInsets.all(13),
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    toBeginningOfSentenceCase("${System.data.resource.remove}"),
                    textAlign: TextAlign.center,
                    style: System.data.textStyleUtil.mainTitle(
                      color: System.data.colorUtil.lightTextColor,
                    ),
                  ),
                ),
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
      title: Text(
        toBeginningOfSentenceCase(System.data.resource.detailVendor),
        textAlign: TextAlign.center,
        style: System.data.textStyleUtil.mainTitle(
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
      actions: [],
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(child: itemList(vm));
  }

  Widget itemList(ViewModel vm) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: System.data.colorUtil.secondaryColor),
      margin: EdgeInsets.only(bottom: 10),
      child: vm.personInChargeModel == null
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 10),
                  margin: EdgeInsets.only(bottom: 13),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: System.data.colorUtil.shadowColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        child: Image.network(
                          "${vm.personInChargeModel.image}",
                          errorBuilder: (bb, o, st) => Container(
                            width: 70,
                            height: 70,
                            child: SvgPicture.asset("assets/erroImage.svg"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.personInChargeModel.name}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.address}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${vm.personInChargeModel.address}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.phone}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${vm.personInChargeModel.phoneNumber}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.email}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.personInChargeModel.email}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                          textAlign: TextAlign.end,
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
