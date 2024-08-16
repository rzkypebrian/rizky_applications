import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'viewModel.dart';
import 'package:enerren/util/StringExtention.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => super.data,
      child: Consumer<ViewModel>(
        builder: (ctx, dt, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(),
            body: body(),
            bottomNavigationBar:
                data.isFinish == true && data.message.isNullOrEmpty()
                    ? bottomDetail()
                    : Container(
                        height: 0,
                        width: 0,
                      ),
          );
        },
      ),
    );
  }

  Widget appBar() {
    return BottonComponent.customAppBar1(
        context: context,
        actionText: "",
        title: "${System.data.resource.processOrder}",
        titleStyle: System.data.textStyleUtil.mainLabel(
          color: System.data.colorUtil.lightTextColor,
          fontSize: System.data.fontUtil.xl,
        ),
        backgroundColor: System.data.colorUtil.blueColor);
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: System.data.colorUtil.scaffoldBackgroundColor,
        padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 180),
        margin: EdgeInsets.only(top: 0, bottom: 0),
        //alignment: Alignment.topCenter,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            confirmAnimation(),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: Text(
                  "${data.isFinish == true ? !data.message.isNullOrEmpty() ? System.data.resource.error : System.data.resource.orderConfirmedSuccess : ""}",
                  style: TextStyle(
                    fontSize: System.data.fontUtil.xxl,
                    color: data.message.isNullOrEmpty()
                        ? System.data.colorUtil.blueColor
                        : System.data.colorUtil.redColor,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            data.message.isNullOrEmpty()
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : Text(
                    "${data.message}",
                    style: System.data.textStyleUtil.mainLabel(),
                    textAlign: TextAlign.center,
                  ),
            Container(
              // height: 130,
              child: data.isFinish == true && data.message.isNullOrEmpty()
                  ? detailOrder(data.shipmentModel)
                  : Container(
                      height: 0,
                      width: 0,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmAnimation() {
    return Container(
      alignment: Alignment.topCenter,
      width: 250,
      height: 300,
      padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
      margin: EdgeInsets.only(
        top: 20,
        bottom: 0,
      ),
      //decoration: BoxDecoration(),
      child: FlareActor(
        data.isFinish
            ? data.message.isNullOrEmpty()
                ? 'assets/flares/angkut/success_angkut.flr'
                : "assets/flares/angkut/error_angkut.flr"
            : widget.animationAssets ??
                'assets/flares/angkut/confirm_order.flr',
        fit: BoxFit.contain,
        animation: widget.animationName ?? "play",
      ),
    );
  }

  Widget detailOrder(AngkutShipmentModel data) {
    return DecorationComponent.listShipmentContent(
      data: data,
      showPaymentStatus: false,
      showPrice: widget.showPrize,
      showExtraPeople: widget.showExtraPeople,
    );
    // return Container(
    //   child: Stack(
    //     children: <Widget>[
    //       Container(
    //         alignment: Alignment.topLeft,
    //         child: SvgPicture.asset(
    //           "assets/angkut/bg_node_gray.svg",
    //         ),
    //         decoration: BoxDecoration(
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.grey.withOpacity(0.3),
    //               blurRadius: 3,
    //               spreadRadius: -10 // soften the shadow
    //             )
    //           ],
    //         ),

    //       ),
    //       //ini baris untuk order number
    //       Container(
    //         margin: EdgeInsets.only(left: 30, right: 30, top: 15),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Container(
    //               child: Text(
    //                 "${data.shipmentNumber}",
    //                 style: TextStyle(
    //                   color: Colors.blue,
    //                   fontSize: System.data.fontUtil.m,
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               child: Text(
    //                 ("${DateFormat("dd MMM yyyy HH:mm").format(data.shipmentDate)}"),
    //                 style: TextStyle(
    //                   color: Colors.blue,
    //                   fontSize: System.data.fontUtil.m,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         margin: EdgeInsets.only(top: 30),
    //         child: Divider(
    //           color: Colors.blue[600],
    //           thickness: 1.0,
    //           indent: 30,
    //           endIndent: 30,
    //         ),
    //       ),
    //       //ini baris perlengkapan rumah
    //       Container(
    //         margin: EdgeInsets.only(left: 30, top: 45, right: 30),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Container(
    //               margin: EdgeInsets.only(right: 10),
    //               child: Row(
    //                 children: <Widget>[
    //                   Container(
    //                     child: SvgPicture.asset(
    //                       "assets/angkut/box_gray.svg",
    //                       alignment: Alignment.bottomCenter,
    //                       color: Colors.blue,
    //                     ),
    //                   ),
    //                   Container(
    //                     padding: EdgeInsets.only(left: 10),
    //                     child: Text(
    //                       "${data.deliveryDescription}",
    //                       style: TextStyle(
    //                         color: Colors.blue,
    //                         fontSize: System.data.fontUtil.m,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               child: Row(
    //                 children: <Widget>[
    //                   Container(
    //                     padding: EdgeInsets.only(right: 10),
    //                     child: Text(
    //                       "-",
    //                       style: System.data.textStyleUtil.mainLabel(
    //                         color: System.data.colorUtil.blueColor,
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     height: 15,
    //                     width: 15,
    //                     child: SvgPicture.asset(
    //                       "assets/angkut/icon_driver.svg",
    //                       alignment: Alignment.bottomCenter,
    //                       color: Colors.blue,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       //ini untuk = baris antara container

    //       //Ini baris choice curir
    //       Container(
    //         margin: EdgeInsets.only(right: 10, left: 20, top: 70),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //             Container(
    //               child: Container(
    //                 height: 15,
    //                 width: 15,
    //                 margin: EdgeInsets.only(left: 10),
    //                 child: SvgPicture.asset(
    //                   "assets/angkut/icon_delivery.svg",
    //                   alignment: Alignment.bottomCenter,
    //                   color: Colors.blue,
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               padding: EdgeInsets.only(left: 10),
    //               child: Text(
    //                 "${data.isInstant ? System.data.resource.instant : System.data.resource.scheduled}", //untuk get data dari data  viewModel
    //                 style: TextStyle(
    //                   color: Colors.blue,
    //                   fontSize: System.data.fontUtil.m,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       //Ini untuk price
    //       Container(
    //         margin: EdgeInsets.only(right: 10, left: 20, top: 100),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //             Container(
    //               child: Container(
    //                 height: 15,
    //                 width: 15,
    //                 margin: EdgeInsets.only(left: 10),
    //                 child: SvgPicture.asset(
    //                   "assets/angkut/price.svg",
    //                   alignment: Alignment.bottomCenter,
    //                   color: Colors.blue,
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               padding: EdgeInsets.only(left: 10),
    //               child: Text(
    //                 "Rp. ${NumberFormat("#,##0").format(data.totalPrice)}", //untuk get data dari data dummy viewModel
    //                 style: TextStyle(
    //                   color: Colors.red,
    //                   fontSize: System.data.fontUtil.m,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget bottomDetail() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: BottonComponent.roundedButton(
        colorBackground: Colors.blue,
        height: 50,
        width: 230,
        text:
            "${widget.buttonFinishTitle ?? System.data.resource.viewYourOrder}",
        fontSize: 16,
        onPressed: onTapViewOrder,
      ),
    );
  }
}
