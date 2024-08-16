import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/TmsVoucherModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'viewModel.dart';
import 'presenter.dart';
import 'package:flutter/material.dart';

class View extends PresenterState {
  @override
  Widget build(Object context) {
    return Center(
      child: ChangeNotifierProvider<ViewModel>(
        create: (_) => super.model,
        child: Scaffold(
          appBar: BottonComponent.customAppBar1(
            context: context,
            actionText: "",
            title: System.data.resource.voucher,
            backgroundColor: System.data.colorUtil.primaryColor,
            backButtonColor: System.data.colorUtil.lightTextColor,
            titleStyle: System.data.textStyleUtil.pageTitle(),
          ),
          body: body(),
          bottomNavigationBar: bottomNavigationBar(),
        ),
      ),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          child: Column(
            children: [
              voucherItem(model.voucher),
              Expanded(
                child: termAndCondition(),
              )
            ],
          ),
        ),
        circularProgressIndicatorDecoration(),
      ],
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  Widget voucherItem(TmsVoucherModel voucher) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
      child: Center(
        child: SvgPicture.network(
          voucher.imageVoucher,
          fit: BoxFit.fitWidth,
          placeholderBuilder: (_) {
            return Text(
              voucher.discountCode ?? "",
              style: System.data.textStyleUtil
                  .mainLabel(fontSize: System.data.fontUtil.xxlPlus),
            );
          },
        ),
      ),
    );
  }

  Widget termAndCondition() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 30,
            margin: EdgeInsets.all(15),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              System.data.resource.termAndCondition,
              textAlign: TextAlign.left,
              style: System.data.textStyleUtil.mainLabel(
                fontWeight: FontWeight.bold,
                fontSize: System.data.fontUtil.xl,
              ),
            ),
          ),
          Divider(
            height: 2,
            color: System.data.colorUtil.darkTextColor,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    model.voucher.getTermAndCondition.length,
                    (index) {
                      return termAndConditionItem(
                        model.voucher.getTermAndCondition[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget termAndConditionItem(String text) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          height: 15,
          width: 15,
          child: Icon(
            Icons.brightness_1,
            size: System.data.fontUtil.m,
          ),
        ),
        Expanded(
          child: Container(
            child: Text(text),
          ),
        )
      ],
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      height: 65,
      padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10),
      width: double.infinity,
      child: BottonComponent.roundedButton(
        text: System.data.resource.useVoucher,
        textstyle: System.data.textStyleUtil.mainTitle(),
        onPressed: () {
          onTapApplay();
        },
      ),
    );
  }
}
