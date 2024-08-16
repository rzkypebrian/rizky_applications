import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/WorkOrderModel.dart';
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
      title:
          Text(toBeginningOfSentenceCase(System.data.resource.listMaintenance),
              textAlign: TextAlign.center,
              style: System.data.textStyleUtil.mainTitle(
                color: System.data.colorUtil.lightTextColor,
              )),
      actions: [],
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(child: listMaintenance(vm));
  }

  Widget listMaintenance(ViewModel vm) {
    return Container(
      child: Column(
        children: List.generate(vm.personInChargeModel.length,
            (index) => itemList(vm.personInChargeModel[index])),
      ),
    );
  }

  Widget itemList(PersonInChargeModel pm) {
    return GestureDetector(
      onTap: () => onSelectedPersonInChargeModel(pm),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: System.data.colorUtil.secondaryColor),
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      child: Image.network(
                        "${pm.image}",
                        errorBuilder: (bb, o, st) => Container(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset("assets/erroImage.svg"),
                        ),
                      )),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        toBeginningOfSentenceCase("${pm.name}"),
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: pm.status
                            ? System.data.colorUtil.primaryColor
                            : System.data.colorUtil.yellowColor,
                        shape: BoxShape.circle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
