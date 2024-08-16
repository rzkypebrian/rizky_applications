import 'dart:async';
import 'dart:io';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TextStyleUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ColorUtil.dart';
import 'DatabaseUtil.dart';
import 'FacebookLoginUtil.dart';
import 'FontUtil.dart';
import 'GlobalDataUtil.dart';
import 'GoogleSignUtil.dart';
import 'NavigationUtil.dart';
import 'ThemeUtil.dart';

import 'ResourceUtil.dart';

class InternalDataUtil extends ChangeNotifier {
  static final InternalDataUtil data = new InternalDataUtil._internal();

  static const String LANG = "Lang";
  String applicationName = "Hacaca Transporter";
  String version = "1.1.8";

  dynamic themesController;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigationUtil routes = new NavigationUtil();
  Map<String, WidgetBuilder> mapRoute = {};
  String initialRouteName = "";
  ResourceUtil resource = new ResourceUtil();
  ColorUtil colorUtil = new ColorUtil();
  FontUtil fontUtil = new FontUtil();
  TextStyleUtil textStyleUtil = new TextStyleUtil();
  GlobalDataUtil global = new GlobalDataUtil();
  ThemeData themeData = ThemeUtil().primary();
  String fontFamily = FontUtil().primary;
  ApiEndPointUtil apiEndPointUtil = new ApiEndPointUtil();
  ThemeUtil themeUtil = new ThemeUtil();
  DataBaseUtil database;
  String unAuthorizeRouteName;
  String unAuthorizeRouteNameLimit = "";
  VoidCallback onUnAuthorized;
  List<Permission> permission = [];

  SharedPreferences sharedPreferences;
  Map<DataKey, dynamic> sharedData = Map<DataKey, dynamic>();

  //settingan update
  String androidUpdateUrl = "";
  String iosUpdateUrl = "";

  //third party login
  GoogleSignUtil googleSign = new GoogleSignUtil();
  FacebookLoginUtil facebookLogin = new FacebookLoginUtil();
  //

  //self authorized ssl certificate
  bool useSelfAuthorizedCertificateSSl = false;

  ValueChanged<CircularProgressIndicatorController> onAppWillClose;

  bool isFirstLoad = true;
  Timer autoRefreshTimer;
  bool autoRefreshDefined = false;
  bool autoRefresh = true;
  bool runCallback = false;

  Duration autoRefreshInterval = Duration(seconds: 10);

  dynamic localData = {};

  bool showDebugBanner = true;

  BuildContext context;

  T getLocal<T>() {
    return (this.localData as T);
  }

  set setResource(ResourceUtil resource) {
    this.resource = resource;
  }

  //oneSignal for messaging service
  OneSignalMessaging oneSignalMessaging = new OneSignalMessaging();

  static void clearData() {
    InternalDataUtil.data.sharedPreferences.clear();
  }

  InternalDataUtil({this.initDatabase = true}) {
    _initSharedPreference();
    _initDatabse();
  }

  Future<bool> _initSharedPreference() async {
    this.sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  bool initDatabase;

  Future<bool> _initDatabse() async {
    if (initDatabase) {
      this.database = await new DataBaseUtil().initializeDb();
      return true;
    } else
      return initDatabase;
  }

  //popup modal version check
  void versionCheck({
    bool optional = false,
  }) {
    Artboard _riveArtboard;
    RiveAnimationController _controller;
    rootBundle.load('assets/flares/rocket.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        // Load the RiveFile from the binary data.
        if (file != null) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('play'));
          _riveArtboard = artboard;
          _controller.isActive = true;

          showCupertinoModalPopup(
            context: this.navigatorKey.currentContext,
            semanticsDismissible: !optional,
            builder: (ctx) {
              return GestureDetector(
                onTap: () {
                  if (optional) Navigator.of(ctx).pop();
                },
                child: WillPopScope(
                  onWillPop: () async {
                    if (optional) {
                      return willPopUpdatellback();
                    } else {
                      return false;
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(ctx).size.height,
                    width: MediaQuery.of(ctx).size.width,
                    color: Colors.grey.withOpacity(0.7),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: Container(
                          height: MediaQuery.of(ctx).size.height * 0.7,
                          width: MediaQuery.of(ctx).size.width * 0.8,
                          // decoration: BoxDecoration(
                          //   color: Colors.yellow,
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(15),
                          //   ),
                          // ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Rive(
                                          artboard: _riveArtboard,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width:
                                              (MediaQuery.of(ctx).size.width *
                                                  0.8 /
                                                  2),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${System.data.resource.please}",
                                                  style: System
                                                      .data.textStyleUtil
                                                      .mainLabel(
                                                    color: System.data.colorUtil
                                                        .lightTextColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    "${System.data.resource.update}",
                                                    style: System
                                                        .data.textStyleUtil
                                                        .mainTitle(
                                                      color: System
                                                          .data
                                                          .colorUtil
                                                          .yellowColor,
                                                      fontSize: 50,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${System.data.resource.ourNewestVersion}!",
                                                  style: System
                                                      .data.textStyleUtil
                                                      .mainLabel(
                                                    color: System.data.colorUtil
                                                        .lightTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    optional == true
                                        ? Expanded(
                                            child: Container(
                                              height: 50,
                                              child:
                                                  BottonComponent.roundedButton(
                                                text:
                                                    "${System.data.resource.later}",
                                                textstyle: System
                                                    .data.textStyleUtil
                                                    .mainLabel(),
                                                colorBackground: System
                                                    .data.colorUtil.greyColor,
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        color: Colors.blue,
                                        child: BottonComponent.roundedButton(
                                          text: "${System.data.resource.ok}",
                                          textstyle: System.data.textStyleUtil
                                              .mainLabel(
                                            color: System
                                                .data.colorUtil.lightTextColor,
                                          ),
                                          colorBackground: System
                                              .data.colorUtil.primaryColor,
                                          onPressed: () {
                                            ExternalLinkComponent.openUrl(
                                                url: Platform.isAndroid
                                                    ? this.androidUpdateUrl
                                                    : Platform.isIOS
                                                        ? this.iosUpdateUrl
                                                        : "");
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  //popup modal rating
  bool isPopUpRatingOpened = false;
  void showPopupRating({
    VoidCallback onTapRatting,
  }) {
    isPopUpRatingOpened = true;
    showCupertinoModalPopup(
      context: this.navigatorKey.currentContext,
      builder: (ctx) {
        double popupwidth = MediaQuery.of(ctx).size.width * 90 / 100;
        double popupheight = popupwidth * 130 / 100;
        System.data.routes.routeHistory.add(new RouteHistory(
          routeName: "popupratting",
        ));
        return WillPopScope(
          onWillPop: willPopRatingCallback,
          child: Container(
            color: Colors.grey.shade400.withOpacity(0.2),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  width: popupwidth,
                  height: popupheight,
                  child: Stack(
                    children: [
                      FlareActor(
                        "assets/flares/pop_up_rating.flr",
                        animation: "play",
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: popupwidth * 30 / 100,
                          height: 30,
                          margin: EdgeInsets.all(30),
                          child: BottonComponent.roundedButton(
                            text: System.data.resource.ok,
                            radius: 50,
                            height: 30,
                            colorBackground: Color(0xff39D9FF),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              System.data.routes.routeHistory.removeLast();
                              this.isPopUpRatingOpened = false;
                              onTapRatting();
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: popupwidth * 60 / 100,
                          margin: EdgeInsets.only(
                              right: 20,
                              left: 20,
                              bottom: popupheight * 30 / 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "${System.data.resource.letsGiveARating}",
                                  style: System.data.textStyleUtil.mainTitle(
                                    color: System.data.colorUtil.yellowColor,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "${System.data.resource.forThisOrder}",
                                  style: System.data.textStyleUtil.mainTitle(
                                    color: System.data.colorUtil.lightTextColor,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> willPopRatingCallback() async {
    System.data.routes.routeHistory.removeLast();
    this.isPopUpRatingOpened = false;
    return true;
  }

  Future<bool> willPopUpdatellback() async {
    System.data.routes.routeHistory.removeLast();
    return true;
  }

  InternalDataUtil._internal();

  void commit() {
    notifyListeners();
  }
}

class SystemStream {
  InternalDataUtil data;

  SystemStream(this.data) {
    _evenController.stream.listen(_mapEventToState);
  }

  StreamController<InternalDataUtil> _evenController =
      StreamController<InternalDataUtil>();
  StreamSink<InternalDataUtil> get eventSink => _evenController.sink;

  StreamController<InternalDataUtil> _stateController =
      StreamController<InternalDataUtil>();
  StreamSink<InternalDataUtil> get stateSink => _stateController.sink;

  Stream<InternalDataUtil> get stateStream => _stateController.stream;

  void _mapEventToState(InternalDataUtil data) {
    stateSink.add(InternalDataUtil.data);
  }

  void setState() {
    eventSink.add(InternalDataUtil.data);
  }

  void dispose() {
    _evenController.close();
    _stateController.close();
  }
}

enum DataKey {
  shipments,
  shipment,
}
