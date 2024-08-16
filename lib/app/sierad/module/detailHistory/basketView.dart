import 'package:enerren/util/SystemUtil.dart';

import 'view.dart';
import 'package:flutter/material.dart';

mixin BasketViewGeneral on View {
  @override
  List<Widget> productItemDeail() {
    return <Widget>[
      noHatchery(),
      shipmentType(),
      basketCode(),
      trayCode(),
      stain(),
      Divider(
        color: System.data.colorUtil.darkTextColor,
        height: 10,
      ),
      detailDelivery(),
    ];
  }

  @override
  Widget numberOfShipmentDelivery() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget numberOfBonusDelivery() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget bonusReceived() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget brokenOrDeadReceived() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget numberOfReceived() {
    return Container(
      height: 0,
      width: 0,
    );
  }
}

class BasketView extends View with BasketViewGeneral {}
