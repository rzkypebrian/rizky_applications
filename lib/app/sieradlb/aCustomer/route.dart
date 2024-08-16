import 'dart:convert';
//import 'dart:js';

import 'package:enerren/app/sierad/aCustomer/localData.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:enerren/app/sierad/aCustomer/module/checkUser/main.dart'
    as checkUser;
import 'package:enerren/app/sierad/aCustomer/module/login/main.dart' as login;
import 'package:enerren/app/sierad/module/verification/main.dart'
    as verification;
import 'package:enerren/app/sierad/module/password/main.dart' as password;
import 'package:enerren/app/sieradlb/aCustomer/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/module/setting/main.dart' as setting;
import 'package:enerren/app/sierad/aCustomer/module/history/main.dart'
    as history;
import 'package:enerren/app/sierad/aCustomer/module/profile/main.dart'
    as profile;
import 'package:enerren/app/sieradlb/aCustomer/module/detailHistory/main.dart'
    as detailHistory;
import 'package:enerren/app/sierad/aCustomer/module/ratingDriver/main.dart'
    as ratingDriver;
import 'package:enerren/module/track/main.dart' as track;
import 'package:enerren/app/sierad/module/liveMap/main.dart' as liveMap;
import 'package:enerren/module/contactService/main.dart' as contactService;
import 'package:enerren/module/notification/main.dart' as notification;
import 'package:enerren/app/sierad/aCustomer/module/splashScreen/main.dart'
    as splashScreen;
import 'package:enerren/module/deliveryPod/main.dart' as pod;
import 'package:enerren/module/about/main.dart' as about;

//definisikan enum name alur program anda disini
class RouteName {
  static const String checkUser = "checkUser";
  static const String login = "login";
  static const String verification = "verification";
  static const String createPassword = "createPassword";
  static const String dashboard = "dashboard";
  static const String setting = "setting";
  static const String changeLanguage = "changeLanguage";
  static const String history = "history";
  static const String changePassword = "changePassword";
  static const String profile = "profile";
  static const String singleHistory = "singleHistory";
  static const String detailHistory = "detailHistory";
  static const String track = "track";
  static const String liveMap = "liveMap";
  static const String contactService = "contactService";
  static const String verificationNewLogin = "verificationNewLogin";
  static const String ratingDriver = "ratingDriver";
  static const String notification = "notification";
  static const String splashScreen = "splashScreen";
  static const String pod = 'pod';
  static const String about = 'about';
}

enum ParamName {
  Username,
  Shipment,
  TmsDeliveryPodModel,
}

//definisikan initial root name
String initialEouteName = RouteName.splashScreen;
String loadingFlareAssets = "assets/flares/sierad/loader_live_bird.flr";
String loadingFlareAnimation = "play";

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splashScreen: (BuildContext context) => splashScreen.Presenter(
        view: splashScreen.CustomerView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets
          ..logoUrl = "assets/sierad/splash_screen_live_bird.svg",
        onFinishSpashScreen: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushAndReplaceName(context, RouteName.checkUser);
          } else {
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            System.data.routes.pushAndReplaceName(context, RouteName.dashboard);
          }
        },
      ),
  RouteName.checkUser: (BuildContext context) {
    var view = checkUser.CustomerView();
    view.flareAnimation = loadingFlareAnimation;
    view.flareAssets = loadingFlareAssets;
    view.logoUrl = "assets/sierad/logo_live_bird.svg";
    view.image1 = "";
    view.image2 = "";
    view.image3 = "";
    view.image4 = "";
    view.logoWidth = 250;
    return checkUser.Presenter(
      view: view,
      onUserIsActive: (accountModel) {
        System.data.routes.pushNamed(context, RouteName.login, arguments: {
          ParamName.Username: accountModel.username,
        });
      },
      onUserIsNonActive: (accountModel) {
        System.data.global.newAccount = accountModel;
        System.data.routes.pushNamed(context, RouteName.verification);
      },
    );
  },
  RouteName.login: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return login.Presenter(
      view: login.CustomerView()
        ..flareAnimation = loadingFlareAnimation
        ..flareAssets = loadingFlareAssets
        ..logoUrl = "assets/sierad/logo_live_bird.svg"
        ..image1 = ""
        ..image2 = ""
        ..image3 = ""
        ..image4 = ""
        ..logoWidth = 100,
      username: arg[ParamName.Username],
      onLoginSuccess: (data) {
        System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
        System.data.global.token = System.data.getLocal<LocalData>().user.token;
        System.data.sharedPreferences.setString(
            PrefsKey.user, json.encode(System.data.getLocal<LocalData>().user));
        System.data.routes
            .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
      },
      onAccessDenied: (username, password, account) {
        System.data.global.newAccount = AccountModel.fromJson(account);
        System.data.global.newAccount.username = username;
        System.data.global.newAccount.password = password;
        System.data.routes.pushNamed(context, RouteName.verificationNewLogin);
      },
      onForgotPasswordSuccess: (account) {
        System.data.global.newAccount = account;
        System.data.routes.pushNamed(context, RouteName.verification);
      },
    );
  },
  RouteName.verification: (BuildContext context) => verification.Presenter(
        view: verification.SieradView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets,
        sentSms: false,
        verificationCode: System.data.global.newAccount.otpCode,
        withTimer: true,
        duration: Duration(seconds: 60),
        phoneNumber: System.data.global.newAccount.sendTo,
        onVerificationValid: (pin) {
          System.data.routes.pushNamed(context, RouteName.createPassword);
        },
      ),
  RouteName.createPassword: (BuildContext context) => password.Presenter(
        passwordState: password.PasswordState.CreatePassword,
        view: password.SieradView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        },
      ),
  RouteName.dashboard: (BuildContext context) => dashboard.Presenter(
        gotoProfile: () {
          System.data.routes.pushNamed(context, RouteName.profile);
        },
        view: dashboard.SieradLBView()
          ..buttonIconColor = Colors.white
          ..buttonBackgroundColor = System.data.colorUtil.primaryColor
          ..onSetting = () {
            System.data.routes.pushNamed(context, RouteName.setting);
          }
          ..onHistory = () {
            System.data.routes.pushNamed(context, RouteName.history);
          }
          ..onContactService = () {
            System.data.routes.pushNamed(context, RouteName.contactService);
          }
          ..onNotification = () {
            System.data.routes.pushNamed(context, RouteName.notification);
          },
      ),
  RouteName.setting: (BuildContext context) => setting.Presenter(
        view: setting.GeneralView(language: () {
          System.data.routes.pushNamed(context, RouteName.changeLanguage);
        }, changePassword: () {
          System.data.routes.pushNamed(context, RouteName.changePassword);
        }, logout: () {
          System.data.sharedPreferences.setString(PrefsKey.user, null);
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.checkUser, "");
        }, about: () {
          System.data.routes.pushNamed(context, RouteName.about);
        }),
      ),
  RouteName.changeLanguage: (BuildContext context) => setting.Presenter(
        view: setting.LanguageView(),
      ),
  RouteName.history: (BuildContext context) => history.Presenter(
        loadingAnimation: loadingFlareAnimation,
        loadingAnimationAsset: loadingFlareAssets,
        onSelected: (shipment) {
          if (shipment.tmsShipmentDestinationList.length > 1) {
            System.data.routes
                .pushNamed(context, RouteName.singleHistory, arguments: {
              ParamName.Shipment: shipment,
            });
          } else {
            System.data.routes
                .pushNamed(context, RouteName.detailHistory, arguments: {
              ParamName.Shipment: shipment,
            });
          }
        },
      ),
  RouteName.changePassword: (BuildContext context) => password.Presenter(
        passwordState: password.PasswordState.ChangePassword,
        view: password.SieradView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
        },
      ),
  RouteName.profile: (BuildContext context) => profile.Presenter(
        view: profile.CustomerView(),
      ),
  RouteName.ratingDriver: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment =
        arg[ParamName.Shipment];
    return ratingDriver.Presenter(
        view: ratingDriver.View(),
        driverImageUrl:
            shipment.tmsShipmentDestinationList.first.driverImageUrl,
        driverName: shipment.tmsShipmentDestinationList.first.driverName,
        customerNo: shipment.customerNo,
        driverId: shipment.tmsShipmentDestinationList.first.driverId,
        driverNik: "",
        memberId: shipment.memberId,
        shipmentId: shipment.tmsShipmentId,
        onSubmitSuccess: () {
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        });
  },
  RouteName.singleHistory: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return history.Presenter(
      view: history.SinggleListView(
        data: arg[ParamName.Shipment],
      ),
      onSelected: (shipment) {
        System.data.routes
            .pushNamed(context, RouteName.detailHistory, arguments: {
          ParamName.Shipment: shipment,
        });
      },
    );
  },
  RouteName.detailHistory: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> data =
        arg[ParamName.Shipment];
    return detailHistory.Presenter(
      view: detailHistory.CustomerView(),
      data: data,
      onTapTrack: (shipment) {
        System.data.routes.pushNamed(context, RouteName.track, arguments: {
          ParamName.Shipment: shipment,
        });
      },
      onTapFinish: (shipment) {
        System.data.routes.pushNamed(
          context,
          RouteName.ratingDriver,
          arguments: {
            ParamName.Shipment: shipment,
          },
        );
      },
      onTapViewPod: (pod) {
        System.data.routes.pushNamed(
          context,
          RouteName.pod,
          arguments: {
            ParamName.TmsDeliveryPodModel: pod,
          },
        );
      },
    );
  },
  RouteName.track: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment =
        arg[ParamName.Shipment];
    return track.Presenter(
      showButtonMap: shipment.tmsShipmentDestinationList.first.detailStatus ==
                  "POD" ||
              shipment.tmsShipmentDestinationList.first.detailStatus == "CNCL"
          ? false
          : true,
      onTapLiveMap: () {
        System.data.routes.pushNamed(context, RouteName.liveMap, arguments: {
          ParamName.Shipment:
              <TmsShipmentModel<SieradShipmentDetailHatcheryModel>>[shipment],
        });
      },
      data: shipment
          .tmsShipmentDestinationList.first.tmsShipmentDetailHistoryList,
    );
  },
  RouteName.contactService: (BuildContext context) =>
      contactService.Presenter(),
  RouteName.verificationNewLogin: (BuildContext context) =>
      verification.Presenter(
        view: verification.NewLoginView(onSuccessLogin: (data) {
          System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        }),
        sentSms: false,
        verificationCode: System.data.global.newAccount.otpCode,
        withTimer: true,
        scurePhoneNUmber: true,
        duration: Duration(seconds: 60),
        phoneNumber: System.data.global.newAccount.sendTo,
      ),
  RouteName.liveMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>> shipment =
        arg[ParamName.Shipment];
    return liveMap.Presenter(
      vehicleIconTopUrl:
          shipment.first.tmsShipmentDestinationList.first.vehicleTypeIconUrlTop,
      drawRoute: true,
      view: liveMap.SieradView(
        sieradViewModel: new liveMap.SieradViewModel(
          shipment: shipment,
          address: "",
          email: "",
          nik: "",
          customerPhoneNumber:
              shipment.first.tmsShipmentDestinationList.first.driverPhone,
          rating: null,
          birdDate: null,
          backdoor: true,
          fan: true,
          temperature: 30,
          driverImageUrl:
              shipment.first.tmsShipmentDestinationList.first.driverImageUrl,
          driverName:
              shipment.first.tmsShipmentDestinationList.first.driverName,
          desinationAddress: shipment
              .first.tmsShipmentDestinationList.first.destinationAddress,
          destinationLat:
              shipment.first.tmsShipmentDestinationList.first.destinationLat,
          destinationLon:
              shipment.first.tmsShipmentDestinationList.first.destinationLong,
          originAddress:
              shipment.first.tmsShipmentDestinationList.first.originAddress,
          originLat: shipment.first.tmsShipmentDestinationList.first.originLat,
          originLon: shipment.first.tmsShipmentDestinationList.first.originLong,
          shipmentType: shipment.first.shipmentTypeName,
          vehicleImageUrl: shipment
              .first.tmsShipmentDestinationList.first.vehicleTypeIconUrl,
          vehicleName: null,
          vehicleNumber:
              shipment.first.tmsShipmentDestinationList.first.vehicleNo,
          vehicleType:
              shipment.first.tmsShipmentDestinationList.first.vehicleType,
          backdoorSensorCode:
              shipment.first.tmsShipmentDestinationList.first.vehicleFanSensor,
          fanSensorCode:
              shipment.first.tmsShipmentDestinationList.first.vehicleFanSensor,
          driverPhoneNumber:
              shipment.first.tmsShipmentDestinationList.first.driverPhone,
        ),
        onTapDetailOrder: (shipment) {
          if (shipment.tmsShipmentDestinationList.length > 1) {
            System.data.routes
                .pushNamed(context, RouteName.singleHistory, arguments: {
              ParamName.Shipment: shipment,
            });
          } else {
            System.data.routes
                .pushNamed(context, RouteName.detailHistory, arguments: {
              ParamName.Shipment: shipment,
            });
          }
        },
      ),
      vehicleId: shipment.first.tmsShipmentDestinationList.first.vehicleIdVts,
      destination: [
        ObjectData(
            latLng: LatLng(
                shipment.first.tmsShipmentDestinationList.first.destinationLat,
                shipment
                    .first.tmsShipmentDestinationList.first.destinationLong))
      ],
      fromDate: DateTime.now().add(Duration(hours: -2)),
    );
  },
  RouteName.notification: (BuildContext context) => notification.Presenter(),
  RouteName.pod: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return pod.Presenter(
      view: pod.ReadOnlyView(
        deliveryPodModel: arg[ParamName.TmsDeliveryPodModel],
      ),
    );
  },
  RouteName.about: (BuildContext context) => about.Presenter()
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
