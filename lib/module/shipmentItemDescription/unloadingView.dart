import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/module/shipmentItemDescription/unloadigPresenter.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'unloadigPresenter.dart';
import 'view.dart';

class UnloadingView extends View with UnloadingPresenter {
  UnloadingView();

  @override
  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.unloadingDetail,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.secondaryColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }
}
