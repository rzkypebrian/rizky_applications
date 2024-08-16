import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'presenter.dart';

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = System.data.colorUtil.scaffoldBackgroundColor;
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
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        // appBar: AppBar(),
        body: Stack(
          children: listComponent(),
        ),
      ),
    );
  }

  List<Widget> listComponent() {
    return <Widget>[
      body(),
      circularProgressIndicatorDecoration(),
    ];
  }

  Decoration decoration() {
    return BoxDecoration(
      color: System.data.colorUtil.primaryColor,
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

  Widget body() {
    return Stack(
      children: <Widget>[
        logo(),
        inputContainer(),
      ],
    );
  }

  Widget logo() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            "assets/logo_inovatrack.svg",
            width: 80,
          ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listInputComponent(),
          ),
        ),
      ),
    );
  }

  List<Widget> listInputComponent() {
    return <Widget>[
      // inputMemberCode(),
      // SizedBox(
      //   height: 20,
      // ),
      inputEmail(),
      SizedBox(
        height: 20,
      ),
      inputPassword(),
      bottonForgotPassword(),
      btnSubmit(),
    ];
  }

  Widget bottonForgotPassword({
    Color color,
  }) {
    return GestureDetector(
      onTap: onForgotPassword,
      child: Container(
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        width: double.infinity,
        child: Text(
          "${System.data.resource.forgotPassword}?",
          textAlign: TextAlign.right,
          style: System.data.textStyleUtil.linkLabel(
            color: color,
          ),
        ),
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
              color: System.data.colorUtil.primaryColor,
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
              color: System.data.colorUtil.primaryColor,
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
        colorBackground: System.data.colorUtil.primaryColor,
        height: 50,
        text: "${System.data.resource.next}",
        textstyle:
            System.data.textStyleUtil.mainTitle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
