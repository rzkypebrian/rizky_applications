import 'package:enerren/module/checkUser/view.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AngkutView extends View {
  @override
  Decoration decoration() {
    return DecorationComponent.backGroundDecoration1();
  }

  @override
  Widget loadingDecoration() {
    return DecorationComponent.circularLOadingIndicator(
      controller: loadingController,
    );
  }

  @override
  Widget body() {
    return Stack(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              logo(),
              boxInput(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget boxInput() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.all(
          12,
        ),
        padding: EdgeInsets.only(top: 42, bottom: 42, left: 22, right: 22),
        width: double.infinity,
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            inputEmail(),
            buttonNext(),
          ],
        ),
      ),
    );
  }

  @override
  Widget logo() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 150,
              width: 150,
              child: DecorationComponent.logo(),
            )),
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
            margin: EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              "assets/angkut/angkut_icon_user.svg",
              height: 25,
              width: 25,
              color: System.data.colorUtil.secondaryColor,
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: usernameController,
              builder: ((context, value, child) {
                return InputComponent.inputTextWithUnderLine(
                  underLineColor: getColor(usernameController.stateInput),
                  hintText: "${System.data.resource.username}",
                  controller: usernameController,
                  textColor: System.data.colorUtil.lightTextColor,
                  contentPadding: EdgeInsets.only(bottom: 20),
                  hintTextColor: System.data.colorUtil.disableColor,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buttonNext() {
    return Container(
      margin: EdgeInsets.only(top: 38),
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.transparent.withOpacity(0),
        padding: EdgeInsets.all(0),
        onPressed: submit,
        child: Container(
          decoration: DecorationComponent.buttonDecoration(),
          child: Center(
            child: Text(
              "${System.data.resource.next}",
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

  @override
  Widget poweredByTms() {
    return Container();
  }
}
