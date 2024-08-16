import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/util/listExtention.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Consumer<ViewModel>(
        builder: (ctx, dt, child) {
          return Scaffold(
              appBar: appBar(),
              backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
              body: home());
        },
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.shipmentStatus,
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
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            status(
              // sended: ,
              // accepted: false,
              finished: false,
            ),
            detailStatus(),
          ],
        ),
      ),
    );
  }

  Widget status({
    bool sended = true,
    bool accepted = true,
    bool finished = true,
  }) {
    return Container();
    // String _send;
    // String _accept;
    // String _finish;
    // Color _line1;
    // Color _line2;

    // if (sended) {
    //   _send = "assets/track_1.svg";
    // } else {
    //   _send = "assets/track_4.svg";
    // }
    // if (accepted) {
    //   _accept = "assets/track_2.svg";
    //   _line1 = System.data.colorUtil.orangeColor;
    // } else {
    //   _accept = "assets/track_5.svg";
    //   _line1 = System.data.colorUtil.secondaryColor;
    // }
    // if (finished) {
    //   _finish = "assets/track_3.svg";
    //   _line2 = System.data.colorUtil.orangeColor;
    // } else {
    //   _finish = "assets/track_6.svg";
    //   _line2 = System.data.colorUtil.secondaryColor;
    // }

    // return Container(
    //   child: DecorationComponent.listTileDecoretion(
    //     widget: Container(
    //       width: 300,
    //       child: Center(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             SvgPicture.asset(
    //               _send,
    //             ),
    //             Container(
    //               width: 54,
    //               height: 2,
    //               decoration: BoxDecoration(
    //                 color: _line1,
    //                 border: Border.all(
    //                   color: _line1,
    //                 ),
    //               ),
    //             ),
    //             SvgPicture.asset(
    //               _accept,
    //             ),
    //             Container(
    //               width: 54,
    //               height: 2,
    //               decoration: BoxDecoration(
    //                 color: _line2,
    //                 border: Border.all(
    //                   color: _line2,
    //                 ),
    //               ),
    //             ),
    //             SvgPicture.asset(
    //               _finish,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget detailStatus() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 14,
              bottom: 14,
              left: 27,
              right: 27,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    onTapDeatilShipment();
                  },
                  child: Text(
                    "${widget.shipmentNumber != null ? "#${widget.shipmentNumber}" : System.data.resource.shipmentHistory}",
                    style: System.data.textStyleUtil.linkLabel(),
                  ),
                ),
                widget.showButtonMap == true
                    ? buttonMap()
                    : Container(
                        width: 0,
                        height: 0,
                      ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 150,
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
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: ListView(
                reverse: false,
                children: List.generate(
                    super.model.data == null ? 0 : super.model.data.length,
                    (i) {
                  return detailShipmentHistory(
                    buttom: super.model.data.length - 1 - i == 0 ? false : true,
                    points: (super.model.data - i).trackingDate != null
                        ? true
                        : false,
                    header: super.model.data.length - 1 - i ==
                            super.model.data.length - 1
                        ? false
                        : true,
                    detailShipment: System.data.resource.lang == "id-ID"
                        ? (super.model.data - i).messageId
                        : (super.model.data - i).messageEn,
                    estimeteDate: (super.model.data - i).trackingEta,
                    currentDate: (super.model.data - i).trackingDate,
                  );
                })),
          ),
        ],
      ),
    );
  }

  Widget buttonMap() {
    return GestureDetector(
      onTap: () => liveMaps(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Icon(
              FontAwesomeSolid(FontAwesomeId.fa_map_marker_alt),
              color: System.data.colorUtil.redColor,
            ),
          ),
          Text(
            "${System.data.resource.liveMap}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
        ],
      ),
    );
  }

  Widget detailShipmentHistory(
      {bool header = true,
      bool buttom = true,
      bool points = true,
      bool headerLine = true,
      bool buttonLine = true,
      DateTime estimeteDate,
      DateTime currentDate,
      String detailShipment}) {
    double _heights;
    double _marginTop;
    if (header) {
      _heights = 120;
      _marginTop = 20;
    } else {
      _heights = 120;
      _marginTop = 20;
    }
    return Container(
      height: _heights,
      margin: EdgeInsets.only(
        left: 27,
        right: 27,
      ),
      child: Stack(
        children: <Widget>[
          header
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(right: 150),
                    height: 80,
                    width: 3,
                    decoration: BoxDecoration(
                      color: headerLine
                          ? System.data.colorUtil.primaryColor
                          : System.data.colorUtil.greyColor,
                    ),
                  ),
                )
              : Container(),
          buttom
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(right: 150),
                    height: 80,
                    width: 3,
                    decoration: BoxDecoration(
                      color: buttonLine
                          ? System.data.colorUtil.primaryColor
                          : System.data.colorUtil.greyColor,
                    ),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                estimeteDate == null
                    ? "- (ETA)"
                    : "${DateFormat('HH : mm').format(estimeteDate)} (ETA)",
                style: System.data.textStyleUtil.linkLabel(
                  color: points
                      ? System.data.colorUtil.darkTextColor
                      : System.data.colorUtil.greyColor,
                  fontSize: System.data.fontUtil.s,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(right: 150),
              child: point(active: points),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 250,
              margin: EdgeInsets.only(
                left: 130,
                top: _marginTop,
              ),
              child: detailShipment != null || currentDate != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          detailShipment == null
                              ? "-"
                              : "${toBeginningOfSentenceCase(detailShipment)}",
                          style: System.data.textStyleUtil.linkLabel(),
                        ),
                        Text(
                          currentDate == null
                              ? "-"
                              : "${DateFormat('EEEE, ${System.data.resource.dateFormat} HH:mm', System.data.resource.dateLocalFormat).format(currentDate)}",
                          style: System.data.textStyleUtil.linkLabel(
                            color: points
                                ? System.data.colorUtil.darkTextColor
                                : System.data.colorUtil.greyColor,
                            fontSize: System.data.fontUtil.s,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("-"),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget point({bool active = true}) {
    return Container(
      width: 20,
      height: 20,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 20,
              decoration: BoxDecoration(
                color: active
                    ? System.data.colorUtil.primaryColor
                    : System.data.colorUtil.greyColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 14,
              decoration: BoxDecoration(
                color: System.data.colorUtil.secondaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            child: Container(
              width: 9,
              decoration: BoxDecoration(
                color: active
                    ? System.data.colorUtil.primaryColor
                    : System.data.colorUtil.greyColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void tapShipmentDetail() {
    if (widget.onTapDetailShipment != null) {
      widget.onTapDetailShipment();
    }
  }
}
