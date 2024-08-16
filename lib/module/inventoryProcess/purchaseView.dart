import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'view.dart';
import 'presenter.dart';

class PurchaseView extends View {
  @override
  void initState() {
    super.initState();
    super.inputDataItem = super
        .inputDataItem
        .where((x) =>
            <InputDataField>[
              InputDataField.MaintenanceId,
              InputDataField.ProductSource,
              InputDataField.ProductStatus,
            ].contains(x) ==
            false)
        .toList();
  }

  @override
  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(
          widget.processTitle ??
              toBeginningOfSentenceCase(System.data.resource.purchase),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }
}
