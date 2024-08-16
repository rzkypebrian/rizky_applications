// import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/module/driverScore/main.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/CircularCartComponent.dart';
import 'package:enerren/component/backgroundPainter.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (context) => super.model,
        child: Consumer<ViewModel>(builder: (ctx, dt, child) {
          return DecoratedBox(
            decoration: boxDecoration(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: appBar(),
              body: home(),
            ),
          );
        }));
  }

  Decoration boxDecoration() {
    return BoxDecoration(
      color: Colors.red,
    );
  }

  Widget home() {
    return Stack(
      children: <Widget>[
        pathBackgroundPatern(),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                chart(),
                detail(),
              ],
            ),
          ),
        ),
        DecorationComponent.circularProgressDecoration(
          controller: loadingController,
        )
      ],
    );
  }

  Widget pathBackgroundPatern() {
    return Align(
      alignment: Alignment.topCenter,
      child: DecorationComponent.containerWithDecoration(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: BackgroundPainter(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
        context: context,
        elevetion: 0,
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        titleColor: System.data.colorUtil.primaryColor,
        title: System.data.resource.driverScore,
        actionText: System.data.resource.back);
  }

  Widget chart() {
    return CircularCartComponent(
      controller: controller,
      backgroundChild: (val) {
        return Container(
          child: SvgPicture.asset(
            val.completeColor == val.lowerColor
                ? "assets/bgScore1.svg"
                : val.completeColor == val.middleColor
                    ? "assets/bgScore2.svg"
                    : "assets/bgScore3.svg",
          ),
        );
      },
      centerChild: (val) {
        switch (val.status) {
          case 0:
            return Center(
              child: Container(
                height: widget.animationSize,
                width: widget.animationSize,
                child: FlareActor(
                  widget.lowAnimationFile ??
                      widget.defaultAnimationFile ??
                      "assets/flares/score_sierad1.flr",
                  animation: widget.lowAnimationName ??
                      widget.defaultAnimationName ??
                      "move",
                ),
              ),
            );
            break;
          case 1:
            return Center(
              child: Container(
                height: widget.animationSize,
                width: widget.animationSize,
                child: FlareActor(
                  widget.midleAnimationFile ??
                      widget.defaultAnimationFile ??
                      "assets/flares/score_sierad1.flr",
                  animation: widget.midleAnimationName ??
                      widget.defaultAnimationName ??
                      "move",
                ),
              ),
            );
            break;
          case 2:
            return Center(
              child: Container(
                height: widget.animationSize,
                width: widget.animationSize,
                child: FlareActor(
                  widget.hightAnimationFile ??
                      widget.defaultAnimationFile ??
                      "assets/flares/score_sierad1.flr",
                  animation: widget.hightAnimationName ??
                      widget.defaultAnimationName ??
                      "move",
                ),
              ),
            );
            break;
          default:
            return Center(
              child: Container(
                height: widget.animationSize,
                width: widget.animationSize,
                child: FlareActor(
                  widget.defaultAnimationFile ??
                      "assets/flares/score_sierad1.flr",
                  animation: widget.defaultAnimationName ?? "move",
                ),
              ),
            );
            break;
        }
      },
      bottomChild: (val) => Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(
          "${NumberFormat("#0.0#", System.data.resource.locale).format(val.current)}",
          style: System.data.textStyleUtil.linkLabel(
            color: val.completeColor,
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
        ),
      ),
    );
  }

  Widget detail() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          detailData(
              title: "${System.data.resource.canceledJob}",
              value: "${model.canceledJob}x",
              valueColor: System.data.colorUtil.yellowColor),
          detailData(
              title: "${System.data.resource.overSpeed}",
              value: "${model.overSpeed}x",
              valueColor: System.data.colorUtil.yellowColor),
          detailData(
              title: "${System.data.resource.averageSpeed}",
              value: "${model.averageSpeed} km/h",
              valueColor: System.data.colorUtil.primaryColor),
          detailData(
              title: "${System.data.resource.finishedJob}",
              value: "${model.finishedJob}x",
              valueColor: System.data.colorUtil.primaryColor),
        ],
      ),
    );
  }

  Widget detailData({
    String title,
    Color titleColor,
    String value,
    Color valueColor,
    Color backgorundColor,
    Color borderColor,
    Color shadowColor,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 14),
      decoration: BoxDecoration(
        boxShadow: [
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: backgorundColor ?? System.data.colorUtil.secondaryColor,
        border: Border.all(
            color: borderColor ?? System.data.colorUtil.secondaryColor),
      ),
      child: ListTile(
        title: Text(
          "$title",
          style: System.data.textStyleUtil.linkLabel(
              color: titleColor ?? System.data.colorUtil.darkTextColor),
        ),
        trailing: Text(
          "$value",
          style: System.data.textStyleUtil.linkLabel(
            color: valueColor,
            fontSize: System.data.fontUtil.xxl,
          ),
        ),
      ),
    );
  }
}
