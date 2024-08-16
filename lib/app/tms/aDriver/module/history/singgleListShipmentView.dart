import 'package:enerren/app/tms/aDriver/module/history/singgleListShipmentPresenter.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class SinggleListShipmentView<T> extends SinggleListShipmentPresenter {
  List<TmsShipmentModel<T>> data;

  SinggleListShipmentView({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
      appBar: appBar(),
      body: home(),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: widget.title,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.scafoldColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.secondaryColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget home() {
    return Container(
      child: ListView(
        children: List.generate(data.length, (i) {
          return DecorationComponent.listTileDecoretion(
            height: 100,
            widget: DecorationComponent.shipmentContents<T>(
              data: data[i],
              onTap: widget.onSelected,
              withHeader: false,
            ),
          );
        }),
      ),
    );
  }
}
