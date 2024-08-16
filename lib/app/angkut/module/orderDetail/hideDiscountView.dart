//halaman ini dibuat untuk menyembunyikan discount dari drier
//tarif dasar ditampilkan dengan nilai yang sudah terpotong discount
//sub total ditampilkan dengan nilai uang sudah terpotong discount
//detail discount dihilangkan

import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'view.dart';

class HiddenDiscount extends View {
  @override
  Widget tarifDasar() {
    return detail(
        title:
            "${System.data.resource.rate} ( ${System.data.resource.distance} ${model.shipment.distancePickupToDestination?.ceil() ?? "-"} Km )",
        value:
            "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.basicPrice - model.shipment.discountAmount)}");
  }

  @override
  Widget discount() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget subTotal() {
    return detail(
        title: System.data.resource.subtotal,
        value:
            "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.subtotal - model.shipment.discountAmount)}",
        sValue: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.darkTextColor,
            fontSize: System.data.fontUtil.xxl));
  }
}
