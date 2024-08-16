import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/CustomBoxShadow.dart';
import 'package:enerren/util/FontUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';

class MenuComponent {
  static Container circleMenu({
    double sizeMenuButton = 113,
    Color bgMenu = Colors.black12,
    double radiusMenu = 5,
    IconData iconMenu = const FontAwesomeRegular(FontAwesomeId.fa_bell),
    Widget menu,
    Color colorIcon = const Color(0xff5555BF),
    double sizeIcon = 20.2,
    EdgeInsets iconMargin = const EdgeInsets.all(0),
    Color colorBedge = const Color(0xffFF9500),
    int intBedge = 0,
    Color colorTextBedge = Colors.white,
    String textMenu = 'label',
    TextStyle textMenuStyle,
    Color colorRxtMenu = Colors.white,
    VoidCallback onTap,
    double sizeTextMenu = 12,
    String fontTextFamily,
    bool neonStyle = true,
    Color shadowColor,
    Color backgroundColor,
    List<BoxShadow> shadow,
    Color borderColor,
    double size,
    double textMenuSpace,
    double borderWidth = 3,
  }) {
    return Container(
      // margin: EdgeInsets.only(left: 1, right: 1, bottom: 1),
      width: sizeMenuButton,
      height: sizeMenuButton,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Center(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: size ?? 65,
                  width: size ?? 65,
                  decoration: BoxDecoration(
                      color: backgroundColor ?? Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: shadow != null
                          ? shadow
                          : [
                              neonStyle
                                  ? CustomBoxShadow(
                                      color: shadowColor ??
                                          System.data.colorUtil.secondaryColor,
                                      blurRadius: 6.0,
                                      blurStyle: BlurStyle.outer)
                                  : CustomBoxShadow(color: Colors.transparent),
                            ],
                      border: Border.all(
                        color:
                            borderColor ?? System.data.colorUtil.secondaryColor,
                        width: borderWidth,
                      )),
                  child: Center(
                    child: Padding(
                      padding: iconMargin,
                      child: menu ??
                          Icon(
                            iconMenu,
                            color: Colors.white,
                            size: sizeIcon,
                          ),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: intBedge == 0 || intBedge == null
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(right: 10, top: 6),
                          width: sizeMenuButton / 4,
                          height: sizeMenuButton / 4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blueGrey)),
                          child: Center(
                              child: Text("$intBedge",
                                  style: TextStyle(color: Colors.red))),
                        )),
              !textMenu.isNullOrEmpty()
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: textMenuSpace ?? 60),
                        padding: EdgeInsets.only(
                          bottom: 0,
                        ),
                        child: Text(
                          textMenu,
                          style: textMenuStyle ??
                              TextStyle(
                                color: colorRxtMenu,
                                fontSize: sizeTextMenu,
                                fontFamily:
                                    fontTextFamily ?? FontUtil().primary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }

  static void showAlert(BuildContext context,
      {String mainTitle = 'Confirmation',
      String secondTile = 'are you sure',
      Color color,
      double radius = 5.0,
      bool isConfirm = true,
      VoidCallback onConfirm,
      bool dismisable = true,
      String confirmText = "Yes",
      bool cancleButton = false,
      String cancleText = "No",
      IconData iconData = Icons.check_circle}) {
    showDialog(
        context: context,
        barrierDismissible: dismisable,
        builder: (context) => isConfirm
            ? AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
                content: SingleChildScrollView(
                  child: Container(
                    width: 343,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          mainTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: System.data.fontUtil.primary,
                              fontSize: System.data.fontUtil.m,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          secondTile,
                          style: TextStyle(
                            fontFamily: System.data.fontUtil.primary,
                            fontSize: System.data.fontUtil.s,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  cancleButton == true
                      ? ButtonTheme(
                          buttonColor: System.data.colorUtil.primaryColor,
                          minWidth: 100,
                          height: 48,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            child: Text(cancleText,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: System.data.fontUtil.primary,
                                    fontSize: System.data.fontUtil.s)),
                          ),
                        )
                      : Container(),
                  ButtonTheme(
                    buttonColor: System.data.colorUtil.primaryColor,
                    minWidth: 100,
                    height: 48,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: onConfirm,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      child: Text(confirmText,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: System.data.fontUtil.primary,
                              fontSize: System.data.fontUtil.s)),
                    ),
                  ),
                ],
              )
            : AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
                content: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: 343,
                      child: Column(
                        children: <Widget>[
                          Icon(
                            iconData,
                            color: color,
                            size: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 10),
                          ),
                          Text(
                              mainTitle == ''
                                  ? System.data.resource.success
                                  : mainTitle,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: System.data.fontUtil.primary,
                                  fontSize: System.data.fontUtil.m,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            secondTile == ''
                                ? System.data.resource.yourReportHasBeenSend
                                : secondTile,
                            style: TextStyle(
                              fontFamily: System.data.fontUtil.primary,
                              fontSize: System.data.fontUtil.s,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
