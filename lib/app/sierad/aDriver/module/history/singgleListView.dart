import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/app/sierad/aDriver/module/history/singgleListPresenter.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class SinggleListView extends SinggleListState {
  TmsShipmentModel<SieradShipmentDetailHatcheryModel> data;

  SinggleListView({
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
      title: widget.title ?? System.data.resource.history,
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
        children: List.generate(data.tmsShipmentDestinationList.length, (i) {
          var single =
              TmsShipmentModel.fromJson<SieradShipmentDetailHatcheryModel>(
                  data.toJson(), childReader: (json) {
            return SieradShipmentDetailHatcheryModel.fromJson(json);
          });
          single.tmsShipmentDestinationList =
              <TmsShipmentDestinationModel<SieradShipmentDetailHatcheryModel>>[
            data.tmsShipmentDestinationList[i]
          ];

          GeolocatorUtil.getAddress(
                  single.tmsShipmentDestinationList.first.destinationLat,
                  single.tmsShipmentDestinationList.first.destinationLat)
              .then((onValue) {
            single.tmsShipmentDestinationList.first.destinationAddress = onValue;
          });

          return DecorationComponent.listTileDecoretion(
            height: 100,
            widget: DecorationComponent.shipmentContents(
                data: single,
                onTap: widget.onSelected,
                subTitle: DecorationComponent.futureBuilderAdress(
                  lat: single.tmsShipmentDestinationList.first.destinationLat,
                  lon: single.tmsShipmentDestinationList.first.destinationLong,
                )),
          );
        }),
      ),
    );
  }
}
