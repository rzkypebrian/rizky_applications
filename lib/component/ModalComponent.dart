import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/NavigationUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:enerren/util/StringExtention.dart';

class ModalComponent {
  static Future<T> bottomModalWithCorner<T>(
    BuildContext context, {
    double height,
    Color backgroundColor,
    Widget backgroundWidget,
    double corner,
    Widget child,
    Color handleColor,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool fromRoute = true,
  }) {
    System.data.routes.routeHistory.add(RouteHistory(
      routeName: "PopUp",
    ));

    Future<void> modal = showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      useRootNavigator: false,
      builder: (builder) {
        return Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: height ?? 250.0,
              decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(corner ?? 15),
                      topRight: Radius.circular(corner ?? 15))),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  // print("test");
                },
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: backgroundWidget,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(),
                          ),
                          child ?? Container()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    if (fromRoute) {
      modal.then((onValue) {
        System.data.routes.routeHistory.remove(System.data.routes.routeHistory
            .where((x) => x.routeName == "PopUp")
            .toList()
            .last);
      });
    }

    return modal;
  }

  static void showAlert(
    BuildContext context, {
    String title = '',
    String description = '',
    Color color = Colors.orange,
    double radius = 5.0,
    bool isConfirm = true,
    VoidCallback onConfirm,
    bool dismisable = true,
    String confirmText = "Yes",
    bool cancleButton = false,
    String cancleText = "No",
    IconData iconData = Icons.check_circle,
    String fontFamily,
    double titleFontSize,
    double fontSize,
    TextStyle titleStyle,
    TextStyle descriptionStyle,
    TextAlign titileAlign,
    TextAlign descriptionAlign,
    Color backgroundColor,
    Color cancleButtonColor,
    Color confirmButtonColor,
    List<Widget> customAction,
  }) {
    showDialog(
        context: context,
        barrierDismissible: dismisable,
        builder: (context) => isConfirm
            ? AlertDialog(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
                content: SingleChildScrollView(
                  child: Container(
                    width: 343,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        title.isNotEmpty
                            ? Text(
                                title,
                                textAlign: titileAlign,
                                style: titleStyle ??
                                    TextStyle(
                                        color: Colors.black,
                                        fontFamily: fontFamily,
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          description,
                          textAlign: descriptionAlign,
                          style: descriptionStyle ??
                              TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: titleFontSize),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: customAction ??
                    <Widget>[
                      cancleButton == true
                          ? ButtonTheme(
                              buttonColor: cancleButtonColor,
                              minWidth: 100,
                              height: 48,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                                child: Text(cancleText,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: fontFamily,
                                        fontSize: fontSize)),
                              ),
                            )
                          : Container(),
                      ButtonTheme(
                        buttonColor: confirmButtonColor,
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
                                  fontFamily: fontFamily,
                                  fontSize: fontSize)),
                        ),
                      ),
                    ],
              )
            : AlertDialog(
                backgroundColor: backgroundColor,
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
                          title.isNotEmpty
                              ? Text(title,
                                  textAlign: titileAlign,
                                  style: titleStyle ??
                                      TextStyle(
                                          color: Colors.black,
                                          fontFamily: fontFamily,
                                          fontSize: titleFontSize,
                                          fontWeight: FontWeight.bold))
                              : Container(),
                          Text(
                            description,
                            textAlign: descriptionAlign,
                            style: descriptionStyle ??
                                TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: titleFontSize),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }

  static Future<T> modalNotification<T>({
    String title,
    Color titleColor,
    String body,
    Color bodyColor,
    String imaage,
    String defaultBackGroundImage,
    Color imageBackgroundColor,
    String defaultNotifImmage,
    String imageUrl,
    VoidCallback onTapOk,
  }) {
    System.data.routes.routeHistory.add(RouteHistory(
      routeName: "PopUp",
    ));
    Future<void> modal = showModalBottomSheet(
      context: System.data.navigatorKey.currentContext,
      isDismissible: true,
      isScrollControlled: true,
      useRootNavigator: false,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Container(
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(System.data.navigatorKey.currentContext)
                  .viewInsets
                  .bottom),
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 280.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  // print("test");
                },
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(),
                          ),
                          Container(
                            height: 250,
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 5, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "$title",
                                  style: System.data.textStyleUtil.linkLabel(
                                    color: titleColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Center(
                                      child: Stack(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              "${defaultBackGroundImage ?? "assets/background_notif.svg"}",
                                              color: imageBackgroundColor ??
                                                  Colors.grey.shade200,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: !imageUrl.isNullOrEmpty()
                                                ? Image.network(imageUrl,
                                                    height: 70)
                                                : SvgPicture.asset(
                                                    "${defaultNotifImmage ?? "assets/icon_notification.svg"}",
                                                  ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "$body",
                                    textAlign: TextAlign.center,
                                    style: System.data.textStyleUtil.mainLabel(
                                      color: bodyColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BottonComponent.roundedButton(
                                    height: 40,
                                    width: 120,
                                    text: "${System.data.resource.ok}",
                                    textstyle:
                                        System.data.textStyleUtil.mainTitle(),
                                    colorBackground:
                                        System.data.colorUtil.primaryColor,
                                    onPressed: () {
                                      Navigator.of(System
                                              .data.navigatorKey.currentContext)
                                          .pop();
                                      if (onTapOk != null) {
                                        onTapOk();
                                      }
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    modal.then(
      (onValue) {
        System.data.routes.routeHistory.remove(System.data.routes.routeHistory
            .where((x) => x.routeName == "PopUp")
            .toList()
            .last);
      },
    );
    return modal;
  }
}

class HolcimBetonModal {
  static modalBottomComfirmation(
    BuildContext context, {
    VoidCallback onConfirm,
    String titleText,
    String descriptionText,
    String confirmText,
    TextStyle titleTextStyle,
    TextStyle descriptionTextStyle,
    TextStyle confirmTextStyle,
    Color bottonCollor,
  }) {
    ModalComponent.bottomModalWithCorner(context,
        backgroundColor: Colors.white,
        handleColor: System.data.colorUtil.primaryColor,
        child: Container(
          height: 220,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(titleText ?? "Confirmation",
                          style: titleTextStyle ??
                              TextStyle(
                                fontFamily: System.data.fontUtil.primary,
                                fontSize: System.data.fontUtil.xxl,
                              )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 20, right: 15),
                      child: Text(
                        descriptionText ??
                            "Are you sure to confirm this action?",
                        style: descriptionTextStyle ??
                            TextStyle(
                              fontFamily: System.data.fontUtil.primary,
                              fontSize: System.data.fontUtil.m,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BottonComponent.roundedButton(
                      onPressed: onConfirm,
                      width: 200,
                      text: confirmText ?? "Confirmation",
                      textstyle: confirmTextStyle ??
                          TextStyle(
                              color: Colors.white,
                              fontFamily: System.data.fontUtil.primary,
                              fontSize: System.data.fontUtil.l,
                              fontWeight: FontWeight.bold),
                      colorBackground:
                          bottonCollor ?? System.data.colorUtil.primaryColor),
                ),
              )
            ],
          ),
        ));
  }
}

class SbbiModal {
  static String modalBackground =
      '<svg xmlns="http://www.w3.org/2000/svg" width="243.966" height="182.341" viewBox="0 0 243.966 182.341"><g id="Group_519" data-name="Group 519" transform="translate(0 -484.959)"><path id="Path_204" data-name="Path 204" d="M-753,12632.357l111.038-88.586,33.127,48.845-10.825,28.351-99.2,80.181h29.426l85.329-66.393,19.107-44.288-50.623-71.508h-6.335L-753,12608Z" transform="translate(753 -12034)" fill="#a8c700" opacity="0.24"/><path id="Path_205" data-name="Path 205" d="M155.479,244.436l73.362-58.8,45.985-6.334,45.855,65.429H295.808L265.657,200.84,237.54,204.69l-50.172,40.484Z" transform="translate(-76.716 422.125)" fill="#7d7d81" opacity="0.24"/></g></svg>';

  static void bottonModal(
    BuildContext context, {
    double height = 200,
    Widget child,
  }) {
    height = height > 500 ? 500 : height;
    ModalComponent.bottomModalWithCorner(context,
        handleColor: Colors.transparent,
        backgroundWidget: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: height > 300 ? 300 : height,
            width: double.infinity,
            child: SvgPicture.string(
              modalBackground,
              fit: BoxFit.fitHeight,
              alignment: Alignment.bottomLeft,
            ),
          ),
        ),
        height: height,
        child: Container(
            height: (height - 21).toDouble(),
            width: double.infinity,
            child: child));
  }
}
