import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/module/do/DoHomeViewer.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class ViewOnly extends View {
  @override
  void initState() {
    super.initState();
    getDo();
  }

  @override
  PreferredSizeWidget appBar(DoHomeViewer dt) {
    return BottonComponent.customAppBar1(
      title: System.data.resource.goodsDetail,
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

  @override
  Widget home(DoHomeViewer dt) {
    return Container(
      color: System.data.colorUtil.scaffoldBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          listDo(dt),
          angkutDecorationComponent(),
        ],
      ),
    );
  }

  @override
  Widget description() {
    return Container(
      child: Text(
        "${System.data.resource.thereIsNoItemList}",
        style: System.data.textStyleUtil.mainLabel(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
