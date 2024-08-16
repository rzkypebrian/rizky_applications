import 'package:enerren/module/login/View.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:component_icons/font_awesome.dart';

class AngkutView extends View {
  Color backgroundColor1;
  Color backgroundColor2;

  AngkutView({
    this.backgroundColor1,
    this.backgroundColor2,
  });

  @override
  void initState() {
    super.initState();
    super.passwordController.setObscureText = true;
  }

  @override
  Decoration decoration() {
    return DecorationComponent.backGroundDecoration1(
      color1: backgroundColor1,
      color2: backgroundColor2,
    );
  }

  @override
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
      controller: loadingController,
    );
  }

  @override
  Widget logo() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 50, bottom: 100),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 150,
            width: 150,
            child: DecorationComponent.logo(),
          ),
        ),
      ),
    );
  }

  @override
  Widget inputContainer({
    AlignmentGeometry align,
    EdgeInsets margin,
    double height,
  }) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(
          top: 80,
          left: 12,
          right: 12,
          bottom: 12,
        ),
        padding: EdgeInsets.only(top: 42, bottom: 42, left: 22, right: 22),
        height: 330,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listInputComponent(),
        ),
      ),
    );
  }

  @override
  Widget inputEmail() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 25,
            width: 25,
            margin: EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              "assets/angkut/angkut_icon_user.svg",
              color: System.data.colorUtil.lightTextColor,
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: usernameController,
              builder: ((context, value, child) {
                return InputComponent.inputTextWithUnderLine(
                  underLineColor: getColor(usernameController.stateInput),
                  hintText: "${System.data.resource.username}",
                  focusNode: usernameFocuseNode,
                  controller: usernameController,
                  textColor: System.data.colorUtil.lightTextColor,
                  contentPadding: EdgeInsets.only(bottom: 20),
                  hintTextColor: System.data.colorUtil.disableColor,
                  onSubmited: (val) {
                    FocusScope.of(context).requestFocus(passwordFocuseNode);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputPassword() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 35,
            width: 25,
            margin: EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              "assets/angkut/angkut_icon_keys.svg",
              color: System.data.colorUtil.lightTextColor,
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: passwordController,
              builder: ((context, value, child) {
                return InputComponent.inputTextWithUnderLine(
                    underLineColor: getColor(passwordController.stateInput),
                    obscureText: passwordController.obscureText,
                    hintText: "${System.data.resource.password}",
                    focusNode: passwordFocuseNode,
                    controller: passwordController,
                    textColor: System.data.colorUtil.lightTextColor,
                    contentPadding: EdgeInsets.only(bottom: 20),
                    hintTextColor: System.data.colorUtil.disableColor,
                    suffix: passwordController.obscureText
                        ? FontAwesomeLight(FontAwesomeId.fa_eye)
                        : FontAwesomeLight(FontAwesomeId.fa_eye_slash),
                    suffixIconColor: System.data.colorUtil.lightTextColor,
                    onSuffixIconTap: () {
                      passwordController.toogleObscureText();
                    });
              }),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listInputComponent() {
    return <Widget>[
      inputEmail(),
      SizedBox(
        height: 50,
      ),
      inputPassword(),
      SizedBox(
        height: 10,
      ),
      bottonForgotPassword(
        color: Colors.white,
      ),
      btnSubmit(),
    ];
  }

  @override
  Widget btnSubmit() {
    return Container(
      margin: EdgeInsets.only(top: 38),
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.transparent,
        padding: EdgeInsets.all(0),
        onPressed: submit,
        child: Container(
          decoration: DecorationComponent.buttonDecoration(),
          child: Center(
            child: Text(
              "${System.data.resource.login}",
              style: System.data.textStyleUtil.mainTitle(),
            ),
          ),
          height: 50,
        ),
      ),
    );
  }

  Color getColor(StateInput stateInput) {
    return usernameController.stateInput == StateInput.Error
        ? Colors.red
        : usernameController.stateInput == StateInput.Disable
            ? System.data.colorUtil.disableColor
            : System.data.colorUtil.secondaryColor;
  }
}
