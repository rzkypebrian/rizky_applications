import 'package:enerren/app/sierad/aCustomer/localData.dart';
import 'package:enerren/app/sierad/aCustomer/module/dashboard/customerView.dart';
import 'package:enerren/util/InternalDataUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SieradLBView extends CustomerView {
  @override
  Widget company() {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15),
      child: SvgPicture.asset(
        "assets/sierad/logo_live_bird.svg",
        height: 40,
      ),
    );
  }

  Widget ranking({
    @required double width,
    @required double value,
    String animation1 = "assets/flares/empty_score1.flr",
    String animation2 = "assets/flares/empty_score2.flr",
    String animation3 = "assets/flares/empty_score3.flr",
    String moveAnimationName = "move",
    String stayAnimationName = "stay",
    Color barValueColor,
    Color barBackgroudColor,
    TextStyle valueStyle,
  }) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.only(left: 50, right: 50),
      child: Consumer<InternalDataUtil>(
        builder: (c, d, h) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              eggItem(
                icon: "assets/sierad/live_bird_process.svg",
                iconHeight: 75,
                label: System.data.resource.process,
                value: System.data
                    .getLocal<LocalData>()
                    .shipmentCountSummary
                    .process,
                onTap: () {
                  onTapRankSummary(0);
                },
              ),
              // eggItem(
              //     width: 70,
              //     icon: "assets/sierad/icon_egg_shipped.svg",
              //     paddingValue: EdgeInsets.only(top: 18, left: 10),
              //     label: System.data.resource.shipped,
              //     value: System.data
              //         .getLocal<LocalData>()
              //         .shipmentCountSummary
              //         .shipped,
              //     onTap: () {
              //       onTapRankSummary(1);
              //     }),
              eggItem(
                  iconHeight: 75,
                  icon: "assets/sierad/live_bird_finish.svg",
                  label: System.data.resource.finish,
                  value: System.data
                      .getLocal<LocalData>()
                      .shipmentCountSummary
                      .finish,
                  onTap: () {
                    onTapRankSummary(2);
                  }),
              eggItem(
                  label: System.data.resource.cancel,
                  iconHeight: 75,
                  icon: "assets/sierad/live_bird_canceled.svg",
                  value: System.data
                      .getLocal<LocalData>()
                      .shipmentCountSummary
                      .cancel,
                  onTap: () {
                    onTapRankSummary(3);
                  }),
            ],
          );
        },
      ),
    );
  }

  Widget eggItem({
    String icon,
    EdgeInsetsGeometry paddingValue,
    String label,
    double width,
    double iconHeight,
    int value,
    VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 60,
        height: 100,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SvgPicture.asset(
                  "${icon ?? "assets/sierad/icon_egg_process.svg"}",
                  height: iconHeight ?? 60,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: paddingValue ??
                    const EdgeInsets.only(
                        top: 0, left: 0, bottom: 17, right: 5),
                child: Text(
                  "${value != null ? value > 100 ? "99+" : value : "0"}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.darkTextColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "$label",
                style: System.data.textStyleUtil
                    .mainLabel(color: System.data.colorUtil.darkTextColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget contureBottomBackground() {
    return SizedBox();
  }
}
