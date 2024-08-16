import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'presenter.dart';

class View<T> extends PresenterState {
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
          DecorationComponent.serachHistoryDecoration(
              controller: searchController, onChange: onSearchChange),
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
        color: Colors.white,
        boxShadow: [
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: System.data.colorUtil.primaryColor,
        onTap: (val) => {},
        labelPadding: EdgeInsets.all(0),
        tabs: <Widget>[
          Text("${toBeginningOfSentenceCase(System.data.resource.process)}",
              style: System.data.textStyleUtil.linkLabel()),
          // Text(
          //   "${toBeginningOfSentenceCase(System.data.resource.shipped)}",
          //   style: System.data.textStyleUtil.linkLabel(),
          // ),
          Text(
            "${toBeginningOfSentenceCase(System.data.resource.finish)}",
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
        controller: controller,
        children: <Widget>[
          listProcess(),
          // listShipped(),
          listFinish(),
          listCancel(),
        ],
      ),
      // ),
    );
  }

  Widget listProcess() {
    return ListDataComponent<TmsShipmentModel<T>>(
      controller: listDataProcessController,
      getNewData: getNewProcessShipment,
      getOldData: getOldProcessShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularProgressDecoration(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return DecorationComponent.listTileDecoretion(
          height: 100,
          widget: DecorationComponent.shipmentContents(
              data: shipment, onTap: onSelected),
        );
      },
      scrollToTop: scrollTop,
    );
  }

  Widget listShipped() {
    return ListDataComponent<TmsShipmentModel<T>>(
      controller: listDataShippedController,
      getNewData: getNewShippedShipment,
      getOldData: getOldShippedShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularProgressDecoration(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return DecorationComponent.listTileDecoretion(
          height: 100,
          widget: DecorationComponent.shipmentContents(
              data: shipment, onTap: onSelected),
        );
      },
      scrollToTop: scrollTop,
    );
  }

  Widget listFinish() {
    return ListDataComponent<TmsShipmentModel<T>>(
      controller: listDataFinishController,
      getNewData: getNewFinishShipment,
      getOldData: getOldFinishShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularProgressDecoration(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return DecorationComponent.listTileDecoretion(
            height: 100,
            widget: DecorationComponent.shipmentContents(
                data: shipment, onTap: onSelected));
      },
      scrollToTop: scrollTop,
    );
  }

  Widget listCancel() {
    return ListDataComponent<TmsShipmentModel<T>>(
      controller: listDataFinishController,
      getNewData: getNewCancelShipment,
      getOldData: getOldCancelShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularProgressDecoration(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return DecorationComponent.listTileDecoretion(
            height: 100,
            widget: DecorationComponent.shipmentContents(
                data: shipment, onTap: onSelected));
      },
      scrollToTop: scrollTop,
    );
  }

  Widget scrollTop(ScrollController scrollController) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: System.data.colorUtil.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: IconButton(
          icon: Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
          onPressed: () {
            scrollController.animateTo(
              1,
              curve: Curves.easeIn,
              duration: Duration(seconds: 1),
            );
          },
        ),
      ),
    );
  }
}
