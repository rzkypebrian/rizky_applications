import 'package:enerren/app/angkut/aDriver/module/doPhoto/HomeViewer.dart';
import 'package:enerren/app/angkut/aDriver/module/doPhoto/view.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import '../../../../../util/SystemUtil.dart';
import 'DoPhotoFinish.dart';

class DoPhotoFinishView extends View with DoPhotoFinish {
  final AngkutShipmentModel shipment;
  final VoidCallback onTapDO;
  final ValueChanged<AngkutShipmentModel> onTapNext;
  final VoidCallback onTapPhoto;
  final int idDestination;

  DoPhotoFinishView({
    this.shipment,
    this.onTapDO,
    this.onTapNext,
    this.onTapPhoto,
    this.idDestination,
  }) {
    super.idDestination = this.idDestination;
    super.onTapNext = this.onTapNext;
    super.shipment = this.shipment;
    super.model.commit();
  }

  PreferredSizeWidget appBar(HomeViewer dt) {
    return BottonComponent.customAppBar1(
        title: System.data.resource.goodsReceipt,
        context: context,
        actionText: "",
        titleColor: System.data.colorUtil.secondaryColor,
        backButtonColor: System.data.colorUtil.lightTextColor,
        actionTextStyle: System.data.textStyleUtil.mainLabel(),
        actionTextColor: System.data.colorUtil.secondaryColor,
        titleStyle: System.data.textStyleUtil.mainTitle(),
        backgroundColor: System.data.colorUtil.primaryColor,
        rightWidget: null);
  }

  @override
  Widget topContent(HomeViewer dt) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              list(
                  pathImg: "assets/angkut/camera.svg",
                  name: "${System.data.resource.photoReceiverAndItem}",
                  onTap: () {
                    onTapPhoto();
                  }),
              list(
                  pathImg: "assets/angkut/boxss.svg",
                  name: "${System.data.resource.checkFormDo}",
                  onTap: () {
                    onTapDO();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget sumbitData(HomeViewer dt) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: submitDoPhotoFinish,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: System.data.colorUtil.primaryColor,
          ),
          width: double.infinity,
          height: 42,
          margin: EdgeInsets.only(bottom: 37, left: 16, right: 16),
          child: Center(
            child: Text(
              "${System.data.resource.next}",
              style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.secondaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
  
}
