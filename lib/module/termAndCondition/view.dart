import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BottonComponent.customAppBar1(
        context: context,
        actionText: "",
        title: System.data.resource.termAndCondition,
        backgroundColor: System.data.colorUtil.primaryColor,
        titleStyle: System.data.textStyleUtil.mainTitle(),
        backButtonColor: System.data.colorUtil.lightTextColor,
      ),
      body: Stack(
        children: <Widget>[
          mainContent(),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget mainContent() {
    return Container(
      color: Colors.green,
    );
  }

  Widget bottomNavigationBar() {
    return submitButton();
  }

  Widget submitButton() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 70,
      child: BottonComponent.roundedButton(
        onPressed: () {
          widget.onTapSubmit();
        },
        text: widget.submitTextLabel ?? System.data.resource.submit,
        textstyle: System.data.textStyleUtil.mainLabel(
          fontWeight: FontWeight.bold,
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }

  Widget agreeBotton() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 70,
      child: BottonComponent.roundedButton(
        onPressed: () {
          widget.onTapAgree();
        },
        text: System.data.resource.agree,
        textstyle: System.data.textStyleUtil.mainLabel(
          fontWeight: FontWeight.bold,
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }

  Widget disAgreeBotton() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 70,
      child: BottonComponent.roundedButton(
        onPressed: () {
          widget.onTapDisagree();
        },
        text: System.data.resource.disAgree,
        textstyle: System.data.textStyleUtil.mainLabel(
          fontWeight: FontWeight.bold,
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }
}
