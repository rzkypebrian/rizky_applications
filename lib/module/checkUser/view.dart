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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DecoratedBox(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          // appBar: AppBar(),
          body: Stack(
            children: <Widget>[
              body(),
              loadingDecoration(),
            ],
          ),
        ),
        decoration: decoration(),
      ),
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: System.data.colorUtil.primaryColor,
    );
  }

  Widget loadingDecoration() {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
    );
  }

  Widget body() {
    return Stack(
      children: <Widget>[
        Container(
          child: CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: PathPainter(),
            child: Stack(
              children: <Widget>[
                logo(),
                boxInput(),
              ],
            ),
          ),
        ),
        poweredByTms(),
      ],
    );
  }

  Widget poweredByTms() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: SvgPicture.asset("assets/poweredby_tms.svg"),
      ),
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
            width: 100,
            color: System.data.colorUtil.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget boxInput() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.all(
          12,
        ),
        padding: EdgeInsets.only(top: 42, bottom: 42, left: 22, right: 22),
        decoration: BoxDecoration(
          color: System.data.colorUtil.scaffoldBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
        ),
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

  Widget inputEmail() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              "assets/icon_user.svg",
              height: 25,
              width: 25,
              color: System.data.colorUtil.primaryColor,
            ),
          ),
          Expanded(
            child: InputComponent.inputTextWithCorner(
              borderInputGray: System.data.colorUtil.borderInputColor,
              hintText: "${System.data.resource.username}",
              corner: 10,
              controller: usernameController,
              fontColor: System.data.colorUtil.darkTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonNext() {
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
