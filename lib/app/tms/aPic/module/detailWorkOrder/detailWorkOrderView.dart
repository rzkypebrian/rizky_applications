import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class DetailWorkOrderView extends View {
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
              bottomSheet: bottomNavigationBar(vm),
            ),
          );
        },
      ),
    );
  }

  Widget bottomNavigationBar(ViewModel vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: BottonComponent.roundedButton(
        colorBackground: vm.workOrderModel.typeWorkOrder == 3
            ? System.data.colorUtil.primaryColor
            : System.data.colorUtil.colorD1D1D1,
        onPressed: () {},
        child: Text(
          "${System.data.resource.send}",
          style: System.data.textStyleUtil.mainTitle(
            color :
            vm.workOrderModel.typeWorkOrder == 3
            ? System.data.colorUtil.secondaryColor
            : System.data.colorUtil.darkTextColor
          ),
        ),
      ),
    );
  }
}
