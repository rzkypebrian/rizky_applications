import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/angkut/aTransporter/localData.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (BuildContext context) => model,
      child: Consumer<ViewModel>(
        builder: (ctx, vm, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(vm: vm),
            body: body(vm),
            bottomNavigationBar: bottomComponent(),
          );
        },
      ),
    );
  }

  PreferredSizeWidget appBar({ViewModel vm}) {
    return BottonComponent.customAppBar1(
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "",
      context: context,
      backButtonColor: System.data.colorUtil.lightTextColor,
      title: System.data.resource.incomingSummary,
      titleStyle: System.data.textStyleUtil.mainTitle(),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[order(vm), infoIncome(vm), shipment(vm)],
        ),
      ),
    );
  }

  Widget order(ViewModel vm) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      margin: EdgeInsets.only(bottom: 9, top: 9),
      decoration: BoxDecoration(
        color: System.data.colorUtil.lightTextColor,
        boxShadow: <BoxShadow>[
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                rowData(
                    title: "${model.invoice.shipmentNumber}",
                    value:
                        "${DateFormat(System.data.resource.dateFormat, System.data.resource.dateLocalFormat).format(model.invoice.shipmentDate)}",
                    titleColor: System.data.colorUtil.primaryColor,
                    valueColor: System.data.colorUtil.primaryColor),
                Divider(
                  color: System.data.colorUtil.primaryColor,
                  thickness: 1,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "${model.invoice.tmsShipmentDestinationList.first.driverName}",
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.primaryColor),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            "${model.invoice.isInstant ? System.data.resource.instantCourier : System.data.resource.scheduled}",
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: totalInOutCome(
                    amount: model.invoice.takeHomePayTransporter,
                    status: model.invoice.shipmentInvoice.billPayStatus,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget totalInOutCome({
    int status,
    double amount,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(amount ?? 0)}",
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.primaryColor,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            child: DecorationComponent.paidStatus(status,
                margin: EdgeInsets.only(
                  right: 0,
                )),
          ),
        ],
      ),
    );
  }

  Widget infoIncome(ViewModel vm) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(bottom: 9, top: 9),
      decoration: BoxDecoration(
        color: System.data.colorUtil.lightTextColor,
        boxShadow: <BoxShadow>[
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          rowData(
            title: "${System.data.resource.paymentInformation}",
            titleColor: System.data.colorUtil.primaryColor,
            titleFontWeight: FontWeight.bold,
          ),
          Divider(
            color: System.data.colorUtil.primaryColor,
            thickness: 1,
          ),
          rowData(
              title: "${System.data.resource.paymentMethod}",
              titleColor: System.data.colorUtil.primaryColor,
              value: "${model.invoice.shipmentInvoice.methodDetailName}"),
          rowData(
              title: "${System.data.resource.duaDate}",
              titleColor: System.data.colorUtil.primaryColor,
              value:
                  "${DateFormat("dd MMM yyyy", System.data.resource.dateLocalFormat).format(model.invoice.shipmentInvoice.dueDate)}"),
          rowData(
            title: "${System.data.resource.detailTransaction}",
            titleColor: System.data.colorUtil.primaryColor,
            titleFontWeight: FontWeight.bold,
          ),
          Divider(
            color: System.data.colorUtil.primaryColor,
            thickness: 1,
          ),
          rowData(
              title: "${System.data.resource.rate}",
              titleColor: System.data.colorUtil.primaryColor,
              value:
                  "Rp ${NumberFormat("#,###", System.data.resource.locale).format(model.invoice.basicPrice)}"),
          rowData(
            title: "${System.data.resource.helpPeople}",
            titleColor: System.data.colorUtil.primaryColor,
            value:
                "Rp ${NumberFormat("#,###", System.data.resource.locale).format(model.invoice.extraHelperAmount ?? 0)}",
          ),
          rowData(
            title: "${System.data.resource.insuranceFee}",
            titleColor: System.data.colorUtil.primaryColor,
            value:
                "Rp ${NumberFormat("#,###", System.data.resource.locale).format(model.invoice.insuranceAmount ?? 0)}",
          ),
          rowData(
            title: "${System.data.resource.discount}",
            titleColor: System.data.colorUtil.primaryColor,
            value:
                "Rp ${NumberFormat("#,###", System.data.resource.locale).format((model.invoice.discountAmount ?? 0) * -1)}",
          ),
          Divider(
            color: System.data.colorUtil.primaryColor,
            thickness: 1,
          ),
          rowData(
            title: "${System.data.resource.totalPaidByCustomer}",
            titleColor: System.data.colorUtil.primaryColor,
            titleFontWeight: FontWeight.bold,
            valueFontWeight: FontWeight.bold,
            value:
                "Rp ${NumberFormat("#,###", System.data.resource.locale).format(model.invoice.totalPrice ?? 0)}",
          ),
          rowData(
            title: "${System.data.resource.insuranceFee}",
            titleColor: System.data.colorUtil.primaryColor,
            value:
                "Rp ${NumberFormat("#,###", System.data.resource.locale).format((model.invoice.insuranceAmount ?? 0) * -1)}",
          ),
          rowData(
            title: "${System.data.resource.angkutserviceFee}",
            titleColor: System.data.colorUtil.primaryColor,
            value:
                "Rp ${NumberFormat("#,###", System.data.resource.locale).format((model.invoice.takeHomePayAngkut ?? 0) * -1)}",
          ),
          Divider(
            color: System.data.colorUtil.primaryColor,
            thickness: 1,
          ),
          rowData(
            title: "${System.data.resource.totalYourIncome}",
            titleColor: System.data.colorUtil.primaryColor,
            titleFontWeight: FontWeight.bold,
            valueFontWeight: FontWeight.bold,
            value:
                "Rp ${NumberFormat("#,###", System.data.resource.locale).format(model.invoice.takeHomePayTransporter ?? 0)}",
          ),
          Divider(
            color: System.data.colorUtil.primaryColor,
            thickness: 1,
          ),
          havePayToAngkut()
        ],
      ),
    );
  }

  Widget havePayToAngkut() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget shipment(ViewModel vm) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(bottom: 9, top: 9),
      decoration: BoxDecoration(
        color: System.data.colorUtil.lightTextColor,
        boxShadow: <BoxShadow>[
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          rowData(
            title: "${System.data.resource.deliverySummary}",
            titleColor: System.data.colorUtil.primaryColor,
            valueWidgetStatus: true,
            valueWidget: GestureDetector(
              onTap: () {},
              child: Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onTapShipmentDetail(widget.invoice);
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.seeDetail}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: System.data.colorUtil.primaryColor,
            thickness: 1,
          ),
          rowData(
              title: "${System.data.resource.transporter}",
              titleColor: System.data.colorUtil.primaryColor,
              value:
                  "${System.data.getLocal<LocalData>().user.transporterName}"),
          Divider(
            color: System.data.colorUtil.primaryColor,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: SvgPicture.asset("assets/angkut/fromTo.svg")),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text("${model.invoice.distancePickupToDestination} Km"),
              ),
              // Container(
              //   margin: EdgeInsets.only(right: 10),
              //   child: Icon(
              //     FontAwesomeLight(FontAwesomeId.fa_clock),
              //     color: System.data.colorUtil.primaryColor,
              //   ),
              // ),
              // Container(
              //   child: Text("123.45 Km"),
              // ),
            ],
          ),
          DecorationComponent.detailShipmentIncomePayment(
            context: context,
            poinName: "${System.data.resource.pickUpLocation}",
            next: true,
            icon: SvgPicture.asset("assets/angkut/box_angkut.svg"),
            address:
                "${model.invoice.tmsShipmentDestinationList.first.originAddress}",
            dateTime: "",
          ),
          DecorationComponent.detailShipmentIncomePayment(
            context: context,
            poinName: "${System.data.resource.destination}",
            icon: Icon(
              FontAwesomeSolid(FontAwesomeId.fa_map_marker_alt),
              color: System.data.colorUtil.redColor,
            ),
            address:
                "${model.invoice.tmsShipmentDestinationList.first.destinationAddress}",
            dateTime: "",
          )
        ],
      ),
    );
  }

  Widget rowData({
    String title,
    Color titleColor,
    String value,
    Color valueColor,
    FontWeight titleFontWeight,
    FontWeight valueFontWeight,
    TextStyle valueStyle,
    Widget titleWidget,
    bool titleWidgetStatus = false,
    Widget valueWidget,
    bool valueWidgetStatus = false,
  }) {
    return Container(
      padding: EdgeInsets.all(9),
      child: Row(
        children: <Widget>[
          titleWidgetStatus
              ? titleWidget
              : title != null
                  ? Expanded(
                      child: Container(
                        child: Text(
                          toBeginningOfSentenceCase("$title"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: titleColor,
                            fontWeight: titleFontWeight,
                          ),
                        ),
                      ),
                    )
                  : Container(),
          valueWidgetStatus
              ? valueWidget
              : value != null
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          toBeginningOfSentenceCase("$value"),
                          style: valueStyle ??
                              System.data.textStyleUtil.mainLabel(
                                color: valueColor,
                                fontWeight: valueFontWeight,
                              ),
                        ),
                      ),
                    )
                  : Container(),
        ],
      ),
    );
  }

  Widget bottomComponent({
    String label,
    double amount,
    String pathFile,
  }) {
    return Container(
      height: 70,
      width: double.infinity,
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
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    label ?? System.data.resource.totalYourIncome,
                    style: System.data.textStyleUtil.mainTitle(
                        color: System.data.colorUtil.primaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "Rp. ${NumberFormat("#,###", System.data.resource.locale).format(amount ?? widget.invoice.takeHomePayTransporter)}",
                    style: System.data.textStyleUtil.mainTitle(
                      fontSize: System.data.fontUtil.xxl,
                      color: System.data.colorUtil.redColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => PDFScreen(
            //         pathPDF: pathFile ?? model.pathFile,
            //         title: 'documents',
            //       ),
            //     ),
            //   );
            // },
            child: Container(
              width: 110,
              height: double.infinity,
              color: System.data.colorUtil.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Image.asset(
                      "assets/angkut/logo_angkut_white.png",
                    ),
                  )
                  // Text(
                  //   "Invoice",
                  //   style: System.data.textStyleUtil.mainLabel(
                  //     color: System.data.colorUtil.lightTextColor,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // Icon(
                  //   Icons.chevron_right,
                  //   color: System.data.colorUtil.lightTextColor,
                  //   size: 20,
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
