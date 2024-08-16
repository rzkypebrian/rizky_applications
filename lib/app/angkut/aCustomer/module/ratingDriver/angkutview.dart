import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/module/ratingDriver/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'angkutPresenter.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';

class AngkutView extends View with AngkutPresenter {
  AngkutShipmentModel angkutShipmentModel;

  AngkutView({
    this.angkutShipmentModel,
  });

  @override
  Widget bottomNavBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: BottonComponent.roundedButton(
          onPressed: () {
            submit();
          },
          height: 40,
          radius: 5,
          text: System.data.resource.save,
          colorBackground: System.data.colorUtil.primaryColor,
          textstyle: System.data.textStyleUtil.mainLabel(
              fontWeight: FontWeight.bold,
              color: System.data.colorUtil.lightTextColor,
              fontSize: System.data.fontUtil.xl)),
    );
  }

  @override
  List<Widget> listComponent() {
    return <Widget>[
      imageDriver(),
      driverName(),
      detailAngkutShipment(),
      inputRating(),
      inputNote(),
    ];
  }

  Widget detailAngkutShipment() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 1,
          ),
          bottom: BorderSide(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${angkutShipmentModel.shipmentNumber}",
          ),
          verticalSpace(),
          detailItem(),
          verticalSpace(),
          detailItem(
            assetsIcon: "assets/angkut/icon_delivery.svg",
            value: angkutShipmentModel.isInstant == true
                ? System.data.resource.instant
                : System.data.resource.scheduled,
          ),
          verticalSpace(),
          detailItem(
            assetsIcon: "assets/angkut/discount_label.svg",
            value: NumberFormat("Rp #,###", System.data.resource.locale)
                .format(angkutShipmentModel.totalPrice),
          ),
          verticalSpace(),
          detailItem(
              assetsIcon: "assets/angkut/date_blue.svg",
              value: DateFormat(System.data.resource.dateFormat,
                      System.data.resource.locale)
                  .format(angkutShipmentModel.shipmentDate)),
        ],
      ),
    );
  }

  Widget detailItem({
    String assetsIcon,
    String value,
  }) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          child: SvgPicture.asset(
            assetsIcon ?? "assets/angkut/box_gray.svg",
            color: System.data.colorUtil.primaryColor,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          value ?? "${angkutShipmentModel.deliveryDescription}",
        ),
      ],
    );
  }

  Widget verticalSpace() {
    return SizedBox(
      height: 10,
    );
  }

  Widget circularProgressIndicatorComponent() {
    return DecorationComponent.circularLOadingIndicator(
      controller: loadingController,
    );
  }
}
