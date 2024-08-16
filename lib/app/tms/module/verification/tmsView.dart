import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/timerCountDownComponent.dart';
import 'package:enerren/module/verification/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'tmsPresenter.dart';

class TmsView extends View with TmsPresenter {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Scaffold(
                backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
                appBar: appBar(),
                body: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          color: System.data.colorUtil.secondaryColor,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: System.data.colorUtil.shadowColor
                                  .withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      height: 280,
                      child: body(),
                    ),
                  ],
                ),
                bottomNavigationBar: bottomNavigationBar(),
              ),
              circularProgressIndicator(model.loadingController)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget body() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title(),
              message(
                message: System
                    .data.resource.checkYourInboxEnter6DigitActivationCode,
                phonNumber: widget.phoneNumber,
              ),
              verificationBox(),
              timerContainer(),
              bottonSubmit(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
        title: System.data.resource.verification,
        context: context,
        actionText: "",
        backButtonColor: System.data.colorUtil.lightTextColor,
        titleColor: System.data.colorUtil.lightTextColor,
        actionTextColor: System.data.colorUtil.secondaryColor,
        titleStyle: System.data.textStyleUtil.mainTitle(
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: System.data.colorUtil.primaryColor);
  }

  @override
  Widget bottonSubmit() {
    return Container();
  }

  @override
  Widget title() {
    return Container();
  }

  @override
  Widget circularProgressIndicator(
      CircularProgressIndicatorController controller) {
    return DecorationComponent.circularProgressDecoration(
      controller: controller,
    );
  }

  @override
  Widget timerCountDown(TimerCountDown time) {
    return Text(
      "${time.duration.inMinutes.toString().padLeft(2, "0")} : ${(time.duration.inSeconds - (Duration(minutes: time.duration.inMinutes).inSeconds)).toString().padLeft(2, "0")}",
      style: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.darkTextColor,
        fontWeight: FontWeight.bold,
        fontSize: System.data.fontUtil.xl,
      ),
    );
  }

  @override
  Widget timerCountDownFinish(TimerCountDown time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "${System.data.resource.didnotReceiveVerificationCode}",
          style: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.darkTextColor,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            resend();
          },
          child: Text(
            "${System.data.resource.resend}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
        )
      ],
    );
  }

  Widget bottomNavigationBar() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 14, right: 14, bottom: 30),
        child: BottonComponent.roundedButton(
          onPressed: () => submit(),
          text: System.data.resource.next,
          textColor: System.data.colorUtil.secondaryColor,
          textstyle: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.lightTextColor,
            fontWeight: FontWeight.bold,
          ),
          colorBackground: System.data.colorUtil.primaryColor,
        ),
      ),
    );
  }

  @override
  Widget message({String message, String phonNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Center(
            child: Text(
              "$message",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.darkTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          child: Center(
            child: Text(
              "${widget.scurePhoneNUmber ? secureNumber(phonNumber) : phonNumber}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.darkTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
