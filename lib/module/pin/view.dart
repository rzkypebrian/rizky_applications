import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/inovatrackComponent.dart';
import 'package:enerren/module/pin/main.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = System.data.colorUtil.scaffoldBgColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height - 110);
    path.quadraticBezierTo(
        size.width / 2, size.height - 0, size.width, size.height - 110);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class View extends PresenterState {
  String image1 = "assets/cloud1.svg";
  String image2 = "assets/cloud2.svg";
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration(),
      child: Scaffold(
        backgroundColor: System.data.colorUtil.scaffoldBgColor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                body(),
                circularProgressIndicatorDecoration(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: System.data.colorUtil.scaffoldBgColor,
    );
  }

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
                            textInovatrack(),
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
              image: AssetImage("assets/bgScafold.png"),
            )),
      ),
    );
  }

  Widget logo() {
    return SafeArea(
        child: Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: SvgPicture.asset(
          "assets/inovatrack_logo.svg",
          width: 80,
        ),
      ),
    ));
  }

  Widget textInovatrack() {
    return Container(
      child: Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset("assets/text_inovaTrack.svg")),
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
        height: super.contentHeght,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listInputComponent(),
        ),
      ),
    );
  }

  List<Widget> listInputComponent() {
    return <Widget>[
      inputPin(),
      confirmPin(),
      btnSubmit(),
      bottonForgotPassword(),
    ];
  }

  Widget inputPin() {
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
              color: System.data.colorUtil.primaryColor3,
            ),
          ),
          Expanded(
            child: InputComponent.inputTextWithCorner(
                borderInputGray: System.data.colorUtil.borderInputColor,
                hintText: "${System.data.resource.pin}",
                corner: 10,
                controller: pinController,
                obscureText: true,
                fontColor: System.data.colorUtil.darkTextColor,
                keyboardType: TextInputType.number,
                backgroundColor: Colors.white,
                masking: "#0",
                contentPadding: EdgeInsets.only(top: 15, left: 15)),
          ),
        ],
      ),
    );
  }

  Widget confirmPin() {
    return Container(
      margin: EdgeInsets.only(top: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            // height: 25,
            width: 25,
            margin: EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              "assets/icon_padlock.svg",
              color: System.data.colorUtil.primaryColor3,
            ),
          ),
          Expanded(
            child: InputComponent.inputTextWithCorner(
                borderInputGray: System.data.colorUtil.borderInputColor,
                hintText: "${System.data.resource.confirmPin}",
                corner: 10,
                controller: confirmPinController,
                obscureText: true,
                fontColor: System.data.colorUtil.darkTextColor,
                keyboardType: TextInputType.number,
                backgroundColor: Colors.white,
                masking: "#",
                contentPadding: EdgeInsets.only(top: 15, left: 15)),
          ),
        ],
      ),
    );
  }

  Widget btnSubmit() {
    return Container(
      margin: EdgeInsets.only(top: 28),
      child: BottonComponent.roundedButton(
        onPressed: submit,
        colorBackground: System.data.colorUtil.primaryColor3,
        height: 50,
        text: "${super.btnLabel}",
        textstyle: System.data.textStyleUtil.mainTitle(
            fontWeight: FontWeight.bold, fontSize: System.data.fontUtil.l),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
      textStyleError: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
      ),
    );
  }

  Widget bottonForgotPassword() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            child: Text(
              "Forgot PIN? Please ",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blackColor,
              ),
            ),
          ),
          Align(
            child: GestureDetector(
              onTap: relogin,
              child: Text(
                "${System.data.resource.relogin}",
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.blueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
