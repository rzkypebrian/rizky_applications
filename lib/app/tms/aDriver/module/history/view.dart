import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
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
      child: Column(
        children: <Widget>[
          DecorationComponent.serachHistoryDecoration(
            controller: searchController,
            onChange: onSearchChange,
          ),
          widget.tabs.length > 1
              ? headerTab()
              : Container(
                  height: 0,
                  width: 0,
                ),
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
        color: System.data.colorUtil.scafoldColor,
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
        tabs: List.generate(widget.tabs.length, (i) {
          return createTabBarHeader(widget.tabs[i]);
        }),
      ),
    );
  }

  Widget createTabBarHeader(TabName tabName) {
    switch (tabName) {
      case TabName.Process:
        return Text(
            "${toBeginningOfSentenceCase(System.data.resource.currentProcess)}",
            style: System.data.textStyleUtil.linkLabel());
        break;
      case TabName.Finish:
        return Text("${toBeginningOfSentenceCase(System.data.resource.finish)}",
            style: System.data.textStyleUtil.linkLabel());
        break;
      case TabName.Cancel:
        return Text("${toBeginningOfSentenceCase(System.data.resource.cancel)}",
            style: System.data.textStyleUtil.linkLabel());
        break;
      default:
        return Container(width: 0, height: 0);
    }
  }

  Widget bodyTab() {
    return Expanded(
      child: TabBarView(
        controller: controller,
        children: List.generate(widget.tabs.length, (i) {
          return createTabBody(widget.tabs[i]);
        }),
      ),
      // ),
    );
  }

  Widget createTabBody(TabName tabName) {
    switch (tabName) {
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
        return Container(width: 0, height: 0);
    }
  }

  Widget currentProcesss() {
    return ListDataComponent<TmsShipmentModel<T>>(
      controller: listDataCurrentProcessController,
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
    );
  }

  Widget doneProcesss() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 80,
            width: double.infinity,
            child: ListDataComponent<TmsShipmentModel<T>>(
              controller: listDataDoneController,
              getNewData: getNewDoneShipment,
              getOldData: getOldDoneShipment,
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
            ),
          ),
        )
      ],
    );
  }

  Widget rejectProcesss() {
    return ListDataComponent<TmsShipmentModel<T>>(
      controller: listDataRejectController,
      getNewData: getNewRejectShipment,
      getOldData: getOldRejectShipment,
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
    );
  }
}
