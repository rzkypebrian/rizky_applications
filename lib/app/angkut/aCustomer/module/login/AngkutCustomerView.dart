import 'dart:io';

import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/login/main.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'AngkutCustomerPresenter.dart';

class AngkutCustomerView extends View with AngkutCustomerPresenter {
  final VoidCallback onTapRegister;
  final bool showThirdPartyLogin;

  AngkutCustomerView({
    this.onTapRegister,
    this.showThirdPartyLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: System.data.colorUtil.scaffoldBackgroundColor,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: BottonComponent.customAppBar1(
          context: context,
          actionText: "",
          title: "${System.data.resource.login}",
          backgroundColor: System.data.colorUtil.primaryColor,
          actionTextColor: System.data.colorUtil.lightTextColor,
          titleColor: System.data.colorUtil.lightTextColor,
          titleStyle: System.data.textStyleUtil.mainTitle(),
          backButtonColor: System.data.colorUtil.lightTextColor,
        ),
        body: Stack(
          children: <Widget>[
            body(),
            circularProgressIndicatorDecoration(),
          ],
        ),
      ),
    );
  }

  @override
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
      controller: super.loadingController,
    );
  }

  @override
  Widget body() {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          logo(),
          inputContainer(
              align: Alignment.topCenter,
              margin: EdgeInsets.all(0),
              height: double.infinity),
        ],
      ),
    );
  }

  Widget inputEmail() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: InputComponent.inputTextWithUnderLine(
                underLineColor:
                    usernameController.stateInput == StateInput.Error
                        ? System.data.colorUtil.redColor
                        : System.data.colorUtil.borderInputColor,
                focusNode: usernameFocuseNode,
                controller: usernameController,
                textColor: System.data.colorUtil.darkTextColor,
                contentPadding: EdgeInsets.only(bottom: 15),
                onSubmited: (val) {
                  FocusScope.of(context).requestFocus(passwordFocuseNode);
                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget inputPassword() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: InputComponent.inputTextWithUnderLine(
              underLineColor: passwordController.stateInput == StateInput.Error
                  ? System.data.colorUtil.redColor
                  : System.data.colorUtil.borderInputColor,
              focusNode: passwordFocuseNode,
              controller: passwordController,
              obscureText: true,
              contentPadding: EdgeInsets.only(bottom: 15),
              textColor: System.data.colorUtil.darkTextColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listInputComponent() {
    return <Widget>[
      Text(
        "${System.data.resource.email}",
        style: System.data.textStyleUtil.linkLabel(),
      ),
      inputEmail(),
      SizedBox(
        height: 20,
      ),
      Text(
        "${System.data.resource.password}",
        style: System.data.textStyleUtil.linkLabel(),
      ),
      inputPassword(),
      SizedBox(
        height: 20,
      ),
      bottonForgotPassword(),
      btnSubmit(),
      SizedBox(
        height: 20,
      ),
      // register(),
      showThirdPartyLogin ? thirdPartyLogin() : SizedBox(),
    ];
  }

  Widget thirdPartyLogin() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: signInWithGoogle,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: System.data.colorUtil.disableColor),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                    height: 30,
                    width: 30,
                    child: Image.asset("assets/angkut/google_logo.png"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 45),
                      child: Text(
                        "${System.data.resource.google}",
                        textAlign: TextAlign.center,
                        style: System.data.textStyleUtil.mainLabel(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: loginWithFacebook,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: System.data.colorUtil.disableColor),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      "assets/angkut/facebook_logo.png",
                      height: 30,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 45),
                      child: Text(
                        "${System.data.resource.facebook}",
                        textAlign: TextAlign.center,
                        style: System.data.textStyleUtil.mainLabel(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Platform.isIOS
              ? GestureDetector(
                  onTap: loginWithApple,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: System.data.colorUtil.disableColor),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 25,
                          width: 25,
                          child: Image.asset(
                            "assets/apple_logo.png",
                            height: 30,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 45),
                          child: Text(
                            "Sign in with Apple ",
                            textAlign: TextAlign.center,
                            style: System.data.textStyleUtil.mainLabel(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 20,
          ),
          register(),
        ],
      ),
    );
  }

  Widget register() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "${System.data.resource.dontHaveAccount}?",
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onTapRegister,
          child: Text(
            "${System.data.resource.register}?",
            textAlign: TextAlign.center,
            style: System.data.textStyleUtil.linkLabel(),
          ),
        ),
      ],
    );
  }
}
