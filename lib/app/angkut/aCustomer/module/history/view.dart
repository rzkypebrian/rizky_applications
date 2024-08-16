import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'presenter.dart';

class View extends PresenterState {
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
      title: System.data.resource.history,
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

  Widget home() {
    return Container(
      child: Column(
        children: <Widget>[
          headerTab(),
          bodyTab(),
        ],
      ),
    );
  }

  Widget headerTab() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: model.controller,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: System.data.colorUtil.primaryColor,
        onTap: (val) => {},
        labelPadding: EdgeInsets.all(0),
        tabs: <Widget>[
          Text(
            "${toBeginningOfSentenceCase(System.data.resource.searchVehicle)}",
            textAlign: TextAlign.center,
            style: System.data.textStyleUtil.linkLabel(),
          ),
          Text(
            "${toBeginningOfSentenceCase(System.data.resource.currentProcess)}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
          Text(
            "${toBeginningOfSentenceCase(System.data.resource.shipped)}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
          Text(
            "${toBeginningOfSentenceCase(System.data.resource.doneProcess)}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
          Text(
            "${toBeginningOfSentenceCase(System.data.resource.cancel)}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
        ],
      ),
    );
  }

  Widget bodyTab() {
    return Expanded(
      child: TabBarView(
        controller: model.controller,
        children: <Widget>[
          getOpen(),
          getProcess(),
          shipped(),
          finish(),
          cancel(),
        ],
      ),
      // ),
    );
  }

  Widget getProcess() {
    return ListDataComponent<AngkutShipmentModel>(
      controller: listDataCurrentProcessController,
      getNewData: getNewProcessShipment,
      getOldData: getOldProcessShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return contents(
          data: shipment,
          onTap: onSelected,
        );
      },
    );
  }

  Widget getOpen() {
    return ListDataComponent<AngkutShipmentModel>(
      controller: listDataCurrentNewController,
      getNewData: getOpenShipment,
      getOldData: getOldOpenShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return contents(
          data: shipment,
          onTap: onSelected,
        );
      },
    );
  }

  Widget shipped() {
    return ListDataComponent<AngkutShipmentModel>(
      controller: listDataDoneController,
      getNewData: getNewShippedShipment,
      getOldData: getOldShippedShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return contents(
          data: shipment,
          onTap: onSelected,
        );
      },
    );
  }

  Widget finish() {
    return ListDataComponent<AngkutShipmentModel>(
      controller: listDataShippedController,
      getNewData: getNewFinishShipment,
      getOldData: getOldFinishShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return contents(
          data: shipment,
          onTap: onSelected,
        );
      },
    );
  }

  Widget cancel() {
    return ListDataComponent<AngkutShipmentModel>(
      controller: listDataRejectController,
      getNewData: getNewCancelShipment,
      getOldData: getOldCancelShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return contents(
          data: shipment,
          onTap: onSelected,
        );
      },
    );
  }

  Widget contents({
    AngkutShipmentModel data,
    ValueChanged<AngkutShipmentModel> onTap,
  }) {
    return DecorationComponent.listShipmentContent(
      data: data,
      onTap: onTap,
      showPaymentStatus: true,
      showPrice: widget.showPrice,
      showExtraPeople: widget.showExtraPeople,
    );
    // return GestureDetector(
    //   onTap: () {
    //     onTap(data);
    //   },
    //   child: Stack(
    //     children: <Widget>[
    //       Align(
    //         alignment: Alignment(-1.04, -1.04),
    //         child: data.needAcction != null && data.needAcction
    //             ? Icon(
    //                 FontAwesomeSolid(FontAwesomeId.fa_question_circle),
    //                 color: System.data.colorUtil.orangeColor,
    //               )
    //             : Container(),
    //       ),
    //       Align(
    //         child: Container(
    //           margin: EdgeInsets.only(left: 25, right: 25, top: 12),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Container(
    //                 padding: EdgeInsets.only(bottom: 5),
    //                 decoration: BoxDecoration(
    //                   border: Border(
    //                     bottom: BorderSide(
    //                       color: ColorUtil().primaryColor,
    //                       style: BorderStyle.solid,
    //                     ),
    //                   ),
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: <Widget>[
    //                     Text(
    //                       toBeginningOfSentenceCase("${data.shipmentNumber}"),
    //                       style: System.data.textStyleUtil.mainLabel(
    //                           color: ColorUtil().primaryColor,
    //                           fontFamily: FontUtil().primary),
    //                     ),
    //                     Text(
    //                         "${DateFormat('EEEE, yyyy-MM-dd').format(data.shipmentDate)}",
    //                         style: System.data.textStyleUtil
    //                             .mainLabel(color: ColorUtil().primaryColor)),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(top: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Container(
    //                       width: 20,
    //                       alignment: Alignment.centerLeft,
    //                       child: SvgPicture.asset(
    //                         "assets/angkut/box_solid.svg",
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Container(
    //                         child: Text(
    //                             toBeginningOfSentenceCase(
    //                                 "${data.deliveryDescription}"),
    //                             style: System.data.textStyleUtil.mainLabel(
    //                                 color: ColorUtil().primaryColor)),
    //                       ),
    //                     ),
    //                     Container(
    //                       margin: EdgeInsets.only(right: 5),
    //                       child: Text(
    //                           toBeginningOfSentenceCase(
    //                               "${data.tmsShipmentDestinationList.first.driverName.isEmpty ? '-' : data.tmsShipmentDestinationList.first.driverName}"),
    //                           style: System.data.textStyleUtil
    //                               .mainLabel(color: ColorUtil().primaryColor)),
    //                     ),
    //                     Container(
    //                       alignment: Alignment.centerLeft,
    //                       child: Icon(
    //                         FontAwesomeRegular(FontAwesomeId.fa_steering_wheel),
    //                         color: System.data.colorUtil.primaryColor,
    //                         size: 15,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(top: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Container(
    //                       width: 20,
    //                       alignment: Alignment.centerLeft,
    //                       child: SvgPicture.asset(
    //                         "assets/angkut/icon_delivery.svg",
    //                       ),
    //                     ),
    //                     Text(
    //                         toBeginningOfSentenceCase(
    //                             "${data.isInstant ? System.data.resource.instantCourier : System.data.resource.scheduled}"),
    //                         style: System.data.textStyleUtil
    //                             .mainLabel(color: ColorUtil().primaryColor))
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(top: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Container(
    //                       width: 20,
    //                       alignment: Alignment.centerLeft,
    //                       child: SvgPicture.asset(
    //                         "assets/angkut/price.svg",
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Container(
    //                         child: Text(
    //                             "Rp ${NumberFormat("#,##0").format(data.totalPrice)}",
    //                             style: System.data.textStyleUtil.mainLabel(
    //                                 color: ColorUtil().redColor,
    //                                 fontSize: FontUtil().l)),
    //                       ),
    //                     ),
    //                     Container(
    //                       // width: 20,
    //                       alignment: Alignment.centerLeft,
    //                       child: SvgPicture.asset(
    //                         data.payed != null && data.payed
    //                             ? "assets/angkut/payed.svg"
    //                             : "assets/angkut/notpayed.svg",
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
