import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/PendingDataModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/module/pendingData/view.dart';
import 'tmsPresenter.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/sierad/util/ConstanUtil.dart' as constant;
import 'package:enerren/util/StringExtention.dart';
import 'package:enerren/util/DateTimeExtention.dart';
// import 'package:enerren/component/tmsDecorationComponent.dart';

class TmsView extends View with TmsPresenter {
  @override
  Widget itemHeader(PendingDataModel pendingDataModel) {
    TmsShipmentModel shipmentModel = TmsShipmentModel.fromJson(
      (pendingDataModel.rawData
              .decode()[constant.SubPandingDataType.shipmentData] as String)
          .decode(),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("${shipmentModel.shipmentNumber}"),
        Text(shipmentModel.shipmentDate.toLocalFormat())
      ],
    );
  }

  @override
  double itemHeight(PendingDataModel pendingDataModel) {
    return super.model.messageStatus[pendingDataModel.id].isNullOrEmpty()
        ? 120
        : 135;
  }

  @override
  EdgeInsets itemMargin() {
    return EdgeInsets.all(0);
  }

  @override
  Widget pendingDataItem(PendingDataModel pendingDataModel, int index) {
    return DecorationComponent.listTileDecoretion(
      height: super.model.messageStatus[pendingDataModel.id].isNullOrEmpty()
          ? 120
          : 135,
      widget: super.pendingDataItem(pendingDataModel, index),
    );
  }

  @override
  Widget messageContainer(PendingDataModel pendingDataModel) {
    return Container(
      margin: EdgeInsets.only(left: 65),
      child: super.messageContainer(pendingDataModel),
    );
  }

  @override
  BoxDecoration itemDecoration() {
    return BoxDecoration(
      color: Colors.transparent,
    );
  }

  @override
  Widget itemBody(PendingDataModel pendingDataModel) {
    TmsShipmentModel shipmentModel = TmsShipmentModel.fromJson(
      (pendingDataModel.rawData
              .decode()[constant.SubPandingDataType.shipmentData] as String)
          .decode(),
    );
    return DecorationComponent.shipmentContents(
      data: shipmentModel,
      withHeader: false,
      showTrailing: false,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
    );
  }
}
