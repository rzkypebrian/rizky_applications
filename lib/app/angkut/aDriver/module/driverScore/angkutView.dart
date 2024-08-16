import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/CircularCartComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/driverScore/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'angkutPresenter.dart';

class AngkutView extends View with AngkutPresenter {
  final detailValueCOlor = Color(0XFFE0FD00);
  final detailBorderColor = System.data.colorUtil.primaryColor;

  @override
  Widget chart() {
    return CircularCartComponent(
      controller: controller,
      backgroundChild: (val) {
        return Container(
          child: SvgPicture.asset(
            val.completeColor == val.lowerColor
                ? "assets/angkut/angkut_bg_score.svg"
                : val.completeColor == val.middleColor
                    ? "assets/angkut/angkut_bg_score.svg"
                    : "assets/angkut/angkut_bg_score.svg",
            color: Color(0XFF0063BA),
          ),
        );
      },
      centerChild: (val) => FlareActor(
        "assets/flares/angkut/angkut_car_score.flr",
        animation: val.value < 5
            ? "score1"
            : val.value < 6.5
                ? "score2"
                : "score3",
      ),
      bottomChild: (val) => Container(
        child: Text(
          "${NumberFormat("#0.0#", System.data.resource.locale).format(val.current)}",
          style: System.data.textStyleUtil.linkLabel(
              color: System.data.colorUtil.lightTextColor,
              fontWeight: FontWeight.bold,
              fontSize: System.data.fontUtil.xxxl + 5),
        ),
      ),
    );
  }

  @override
  Decoration boxDecoration() {
    return DecorationComponent.backGroundDecoration2();
  }

  @override
  Widget pathBackgroundPatern() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget detail() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          detailData(
              backgorundColor: System.data.colorUtil.primaryColor,
              title: "${System.data.resource.canceledJob}",
              value: "${model.canceledJob}x",
              shadowColor: System.data.colorUtil.primaryColor,
              borderColor: detailBorderColor,
              titleColor: System.data.colorUtil.lightTextColor,
              valueColor: detailValueCOlor),
          detailData(
              backgorundColor: System.data.colorUtil.primaryColor,
              title: "${System.data.resource.overSpeed}",
              value: "${model.overSpeed}x",
              shadowColor: System.data.colorUtil.primaryColor,
              borderColor: detailBorderColor,
              titleColor: System.data.colorUtil.lightTextColor,
              valueColor: detailValueCOlor),
          detailData(
              backgorundColor: System.data.colorUtil.primaryColor,
              title: "${System.data.resource.averageSpeed}",
              value: "${model.averageSpeed} km/h",
              shadowColor: System.data.colorUtil.primaryColor,
              borderColor: detailBorderColor,
              titleColor: System.data.colorUtil.lightTextColor,
              valueColor: detailValueCOlor),
          detailData(
              backgorundColor: System.data.colorUtil.primaryColor,
              title: "${System.data.resource.finishedJob}",
              value: "${model.finishedJob}x",
              shadowColor: System.data.colorUtil.primaryColor,
              borderColor: detailBorderColor,
              titleColor: System.data.colorUtil.lightTextColor,
              valueColor: detailValueCOlor)
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
        context: context,
        elevetion: 0,
        backButtonColor: System.data.colorUtil.lightTextColor,
        backgroundColor: Colors.transparent,
        titleColor: System.data.colorUtil.lightTextColor,
        title: System.data.resource.driverScore,
        actionText: System.data.resource.back);
  }
}
