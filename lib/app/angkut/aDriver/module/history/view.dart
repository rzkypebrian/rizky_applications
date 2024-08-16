import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
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
      title: System.data.resource.orderStatus,
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
          tabs: List.generate(widget.tabs.length, (i) {
            return createTab(widget.tabs[i]);
          })),
    );
  }

  Widget createTab(TabName tabName) {
    switch (tabName) {
      case TabName.Open:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.newProcess)}",
          style: System.data.textStyleUtil.linkLabel(),
        );
        break;

      case TabName.Process:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.currentProcess)}",
          style: System.data.textStyleUtil.linkLabel(),
        );
        break;

      case TabName.Finish:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.doneProcess)}",
          style: System.data.textStyleUtil.linkLabel(),
        );
        break;

      case TabName.Cancel:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.rejectProcess)}",
          style: System.data.textStyleUtil.linkLabel(),
        );
        break;

      default:
        return Text(
          "${toBeginningOfSentenceCase(System.data.resource.unDefined)}",
          style: System.data.textStyleUtil.linkLabel(),
        );
    }
  }

  Widget bodyTab() {
    return Expanded(
      child: TabBarView(
          controller: model.controller,
          children: List.generate(widget.tabs.length, (i) {
            return createTabContent(widget.tabs[i]);
          })),
    );
  }

  Widget createTabContent(TabName tabName) {
    switch (tabName) {
      case TabName.Open:
        return newProcesss();
        break;

      case TabName.Process:
        return currentProcesss();
        break;

      case TabName.Finish:
        return doneProcesss();
        break;

      case TabName.Cancel:
        return rejectProcesss();
        break;

      default:
        return Container(
          child: Text(
            System.data.resource.unDefined,
          ),
        );
    }
  }

  Widget currentProcesss() {
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
        return contents(data: shipment, onTap: onSelected);
      },
    );
  }

  Widget newProcesss() {
    return ListDataComponent<AngkutShipmentModel>(
      controller: listDataCurrentNewController,
      getNewData: getNewShipment,
      getOldData: getOldShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return contents(
            data: shipment, onTap: onSelected, showShipmentNumber: false);
      },
    );
  }

  Widget doneProcesss() {
    return ListDataComponent<AngkutShipmentModel>(
      controller: listDataDoneController,
      getNewData: getNewDoneShipment,
      getOldData: getOldDoneShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return contents(data: shipment, onTap: onSelected);
      },
    );
  }

  Widget rejectProcesss() {
    return ListDataComponent<AngkutShipmentModel>(
      controller: listDataRejectController,
      getNewData: getNewRejectShipment,
      getOldData: getOldRejectShipment,
      loadingWidgetBuilder: ((controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      }),
      itemBuilder: (shipment, i) {
        return contents(data: shipment, onTap: onSelected);
      },
    );
  }

  Widget contents({
    AngkutShipmentModel data,
    ValueChanged<AngkutShipmentModel> onTap,
    bool showShipmentNumber = true,
  }) {
    return DecorationComponent.listShipmentContent(
      data: data,
      onTap: onTap,
      showPaymentStatus: widget.showPaidStatus,
      showShipmentNumber: showShipmentNumber,
      showExtraPeople: widget.showExtraPeople,
      showPrice: widget.showPrice,
    );
  }
}
