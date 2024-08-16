import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/inovatrackDecorationComponent.dart';
import 'package:enerren/module/login/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'inovatrackPresenter.dart';

class InovatrackView extends View with InovatrackPresenter {
  String image1 = "assets/inovatrack/cloud1.svg";
  String image2 = "assets/inovatrack/cloud2.svg";
  Decoration decoration() {
    return BoxDecoration(
      color: System.data.colorUtil.primaryColor2,
    );
  }

  List<Widget> listComponent() {
    return <Widget>[
      body(),
      circularProgressIndicatorDecoration(),
    ];
  }

  @override
  Widget body() {
    return Stack(
      children: <Widget>[
        Container(
            child: DecorationComponent.containerWithDecoration(
          image1: image1,
          image2: image2,
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: PathPainter(),
            child: Stack(
              children: <Widget>[
                bgImage(),
                Column(
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Column(
                          children: <Widget>[
                            logo(),
                            textInovaTrack(),
                          ],
                        ),
                      ),
                    ),
                    inputContainer(),
                  ],
                )
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget bgImage() {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 50, bottom: 75),
        child: Align(
          alignment: Alignment.topCenter,
          child: Image(
            image: AssetImage("assets/inovatrack/bgScafold.png"),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return SafeArea(
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            "assets/inovatrack/inovaTrackLogo.svg",
            width: 80,
          ),
        ),
      ),
    );
  }

  Widget textInovaTrack() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.topCenter,
        child: SvgPicture.asset(
          "assets/inovatrack/inovaTrack.svg",
          width: 190,
        ),
      ),
    );
  }

  Widget inputContainer({
    AlignmentGeometry align,
    EdgeInsets margin,
    double height,
  }) {
    return Align(
      alignment: align ?? Alignment.center,
      child: Container(
        margin: margin ??
            EdgeInsets.all(
              12,
            ),
        padding: EdgeInsets.only(top: 42, bottom: 42, left: 22, right: 22),
        decoration: BoxDecoration(
          color: System.data.colorUtil.secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
        ),
        height: height ?? widget.containerHeight ?? 330,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listInputComponent(),
        ),
      ),
    );
  }

  List<Widget> listInputComponent() {
    return <Widget>[
      inputMemberCode(),
      SizedBox(
        height: 20,
      ),
      inputEmail(),
      SizedBox(
        height: 20,
      ),
      inputPassword(),
      bottonForgotPassword(),
      btnSubmit(),
    ];
  }

  Widget inputMemberCode() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 25,
            width: 25,
            margin: EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              "assets/icon_user.svg",
              color: System.data.colorUtil.primaryColor2,
            ),
          ),
          Expanded(
            child: InputComponent.inputTextWithCorner(
                borderInputGray: System.data.colorUtil.borderInputColor,
                hintText: "${System.data.resource.memberCode}",
                corner: 10,
                focusnode: membercodeFocusNode,
                controller: memberCodeController,
                fontColor: System.data.colorUtil.darkTextColor,
                onSubmited: (val) {
                  FocusScope.of(context).requestFocus(usernameFocuseNode);
                }),
          ),
        ],
      ),
    );
  }

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
              "assets/icon_user.svg",
              color: System.data.colorUtil.primaryColor2,
            ),
          ),
          Expanded(
            child: InputComponent.inputTextWithCorner(
                borderInputGray: System.data.colorUtil.borderInputColor,
                hintText: "${System.data.resource.username}",
                corner: 10,
                focusnode: usernameFocuseNode,
                controller: usernameController,
                fontColor: System.data.colorUtil.darkTextColor,
                onSubmited: (val) {
                  FocusScope.of(context).requestFocus(passwordFocuseNode);
                }),
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
            height: 25,
            width: 25,
            margin: EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              "assets/icon_padlock.svg",
              color: System.data.colorUtil.primaryColor2,
            ),
          ),
          Expanded(
            child: InputComponent.inputTextWithCorner(
              borderInputGray: System.data.colorUtil.borderInputColor,
              hintText: "${System.data.resource.password}",
              corner: 10,
              focusnode: passwordFocuseNode,
              controller: passwordController,
              obscureText: true,
              fontColor: System.data.colorUtil.darkTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget btnSubmit() {
    return Container(
      margin: EdgeInsets.only(top: 38),
      child: BottonComponent.roundedButton(
        onPressed: submit,
        colorBackground: System.data.colorUtil.primaryColor2,
        height: 50,
        text: "${System.data.resource.login}",
        textstyle:
            System.data.textStyleUtil.mainTitle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }
}
