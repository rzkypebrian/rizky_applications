import 'dart:convert';

import 'package:enerren/app/sierad/aDriver/localData.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
// import 'package:enerren/model/tmsDriverScore.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NavigationUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/sierad/aDriver/module/checkUser/main.dart'
    as checkUser;
import 'package:enerren/app/sierad/aDriver/module/login/main.dart' as login;
import 'package:enerren/app/sierad/module/verification/main.dart'
    as verification;
import 'package:enerren/app/sierad/module/password/main.dart' as password;
import 'package:enerren/app/sierad/aDriver/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/app/sierad/aDriver/module/history/main.dart' as history;
import 'package:enerren/module/setting/main.dart' as setting;
import 'package:enerren/app/sierad/aDriver/module/profile/main.dart' as profile;
import 'package:enerren/app/sieradlb/module/detailHistory/main.dart'
    as detailHistory;
import 'package:enerren/app/sierad/aDriver/module/pod/main.dart' as pod;
import 'package:enerren/app/sieradlb/aDriver/module/checkShipmentStock/main.dart'
    as checkStock;
import 'package:enerren/app/sierad/aDriver/module/deleveryEmergencyReport/main.dart'
    as emergency;
import 'package:enerren/module/track/main.dart' as track;
import 'package:enerren/app/sierad/module/liveMap/main.dart' as liveMap;
import 'package:enerren/module/driverScore/main.dart' as driverScore;
import 'package:enerren/module/contactService/main.dart' as contactService;
import 'package:enerren/module/notification/main.dart' as notification;
import 'package:enerren/app/sierad/aDriver/module/splashScreen/main.dart'
    as splassScreen;
import 'package:enerren/app/sierad/aDriver/module/pendingData/main.dart'
    as pendingData;
import 'package:enerren/module/about/main.dart' as about;

//definisikan enum name alur program anda disini
class RouteName {
  static const String checkUser = "checkUser";
  static const String login = "login";
  static const String verification = "verification";
  static const String createPassword = "createPassword";
  static const String dashboard = "dashboard";
  static const String history = "history";
  static const String setting = "setting";
  static const String changeLanguage = "changeLanguage";
  static const String changePassword = "changePassword";
  static const String profile = "profile";
  static const String singgleHistory = "singgleHistory";
  static const String singgleHistoryEmergency = "singgleHistoryEmergency";
  static const String detailHistory = "detailHistory";
  static const String detailHistoryEmergency = "detailHistoryEmergency";
  static const String pod = "pod";
  static const String checkStock = "checkStock";
  static const String emergency = "emergency";
  static const String track = "track";
  static const String liveMap = "liveMap";
  static const String driverScore = "driverScore";
  static const String contactService = "contactService";
  static const String verificationNewLogin = "verificationNewLogin";
  static const String notification = "notification";
  static const String splashScreen = "splashScreen";
  static const String historyForEmergency = "String";
  static const String podViewOnly = "podViewOnly";
  static const String changeProfile = "changeProfile";
  static const String pendingData = "pendingData";
  static const String about = "about";
}

enum ParamName {
  Username,
  Shipment,
  ShipnentStcock,
  TmsShipmentPod,
  ProfileModel,
}

//definisikan initial root name
String initialEouteName = RouteName.splashScreen;
String loadingFlareAssets = "assets/flares/sierad/loader_live_bird.flr";
String loadingFlareAnimation = "play";

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splashScreen: (BuildContext context) => splassScreen.Presenter(
        view: splassScreen.DriverView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets
          ..logoUrl = "assets/sierad/splash_screen_live_bird.svg",
        onFinishSpashScreen: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushAndReplaceName(context, RouteName.checkUser);
          } else {
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            ModeUtil.debugPrint("token ${System.data.global.token}");
            System.data.routes.pushAndReplaceName(context, RouteName.dashboard);
          }
        },
      ),
  RouteName.checkUser: (BuildContext context) => checkUser.Presenter(
        view: checkUser.DriverView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets
          ..logoUrl = "assets/sierad/logo_live_bird.svg"
          ..image1 = ""
          ..image2 = ""
          ..image3 = ""
          ..image4 = ""
          ..logoWidth = 250,
        onUserIsActive: (accountModel) {
          System.data.routes.pushNamed(context, RouteName.login, arguments: {
            ParamName.Username: accountModel.username,
          });
        },
        onUserIsNonActive: (accountModel) {
          System.data.global.newAccount = accountModel;
          System.data.routes.pushNamed(context, RouteName.verification);
        },
      ),
  RouteName.login: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return login.Presenter(
      view: login.DriverView()
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
        System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
        System.data.getLocal<LocalData>().user.password = System
            .data.global.token = System.data.getLocal<LocalData>().user.token;
        System.data.routes
            .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        System.data.sharedPreferences.setString(
          PrefsKey.user,
          json.encode(
            System.data.getLocal<LocalData>().user.toJson(),
          ),
        );
      },
      onAccessDenied: (username, password, data) {
        System.data.global.newAccount = AccountModel.fromJson(data);
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
          System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
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
        view: dashboard.DriverView(
            rankingAnimation3: "assets/flares/sierad/skor_live_bird_buruk.flr",
            rankingAnimation2: "assets/flares/sierad/skor_live_bird_sedang.flr",
            rankingAnimation1: "assets/flares/sierad/skor_live_bird_bagus.flr",
            rankingAnimationPlay: "play",
            rankingAnimationStop: "stop",
            history: () {
              System.data.routes.pushNamed(context, RouteName.history);
            },
            setting: () {
              System.data.routes.pushNamed(context, RouteName.setting);
            },
            emergency: (shipment) {
              if (shipment.length > 1) {
                System.data.routes.pushNamed(
                  context,
                  RouteName.historyForEmergency,
                );
              } else {
                if (shipment.first.tmsShipmentDestinationList.length > 1) {
                  System.data.routes.pushNamed(
                      context, RouteName.singgleHistoryEmergency,
                      arguments: {
                        ParamName.Shipment: shipment.first,
                      });
                } else {
                  System.data.routes.pushNamed(
                    context,
                    RouteName.emergency,
                    arguments: {
                      ParamName.Shipment: shipment.first,
                    },
                  );
                }
              }
            },
            score: () {
              System.data.routes.pushNamed(
                context,
                RouteName.driverScore,
              );
            },
            liveMap: (shipment) {
              // if (shipment.tmsShipmentDestinationList.length > 1) {
              //   System.data.routes
              //       .pushNamed(context, RouteName.singgleHistory, arguments: {
              //     ParamName.Shipment: shipment,
              //   });
              // } else {
              System.data.routes.pushNamed(
                context,
                RouteName.liveMap,
                arguments: {
                  ParamName.Shipment: shipment,
                },
              );
              // }
            },
            contact: () {
              System.data.routes.pushNamed(context, RouteName.contactService);
            },
            onTapNotification: () {
              System.data.routes.pushNamed(context, RouteName.notification);
            },
            onTapPendingData: () {
              System.data.routes.pushNamed(context, RouteName.pendingData);
            })
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets
          ..image1 = ""
          ..image2 = ""
          ..animation1Size = 60
          ..companyLogoUrl = "assets/sierad/logo_live_bird.svg"
          ..companyLogoSize = 50,
      ),
  RouteName.history: (BuildContext context) => history.Presenter(
        loadingAnimation: loadingFlareAnimation,
        loadingAnimationAsset: loadingFlareAssets,
        onSelected: (shipment) {
          if (shipment.tmsShipmentDestinationList.length > 1) {
            System.data.routes
                .pushNamed(context, RouteName.singgleHistory, arguments: {
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
  RouteName.historyForEmergency: (BuildContext context) => history.Presenter(
        loadingAnimation: loadingFlareAnimation,
        loadingAnimationAsset: loadingFlareAssets,
        title:
            "${System.data.resource.select} ${System.data.resource.shipment}",
        tabs: [
          TabName.Process,
        ],
        onSelected: (shipment) {
          if (shipment.tmsShipmentDestinationList.length > 1) {
            System.data.routes.pushNamed(
                context, RouteName.singgleHistoryEmergency,
                arguments: {
                  ParamName.Shipment: shipment,
                });
          } else {
            System.data.routes
                .pushNamed(context, RouteName.emergency, arguments: {
              ParamName.Shipment: shipment,
            });
          }
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
  RouteName.changePassword: (BuildContext context) => password.Presenter(
        view: password.SieradView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets,
        passwordState: password.PasswordState.ChangePassword,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
        },
      ),
  RouteName.profile: (BuildContext context) => profile.Presenter(
        view: profile.DriverView(),
        // onChangeProfile: () {
        //   System.data.routes.pushAndReplaceName(
        //     context,
        //     RouteName.changeProfile,
        //     arguments: {
        //       ParamName.ProfileModel: new ProfileModel(
        //         address: "-",
        //         email: System.data.getLocal<LocalData>().user.email,
        //         name: System.data.getLocal<LocalData>().user.driverName,
        //         phone: System.data.getLocal<LocalData>().user.phoneNumber,
        //         registeredDate:
        //             System.data.getLocal<LocalData>().user.insertedDate,
        //         urlImmage:
        //             System.data.getLocal<LocalData>().user.urlProfileImage,
        //       )
        //     },
        //   );
        // },
      ),
  RouteName.changeProfile: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return profile.Presenter(
      view: profile.UpdateDriverView(),
      profileModel: arg[ParamName.ProfileModel],
      onUpdateSuccess: (profile) {
        System.data.routes.pushAndReplaceName(context, RouteName.profile);
      },
    );
  },
  RouteName.singgleHistory: (BuildContext context) {
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
  RouteName.singgleHistoryEmergency: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return history.Presenter(
      title:
          "${System.data.resource.select} ${System.data.resource.destination}",
      view: history.SinggleListView(
        data: arg[ParamName.Shipment],
      ),
      onSelected: (shipment) {
        System.data.routes
            .pushNamed(context, RouteName.detailHistoryEmergency, arguments: {
          ParamName.Shipment: shipment,
        });
      },
    );
  },
  RouteName.detailHistory: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment =
        arg[ParamName.Shipment];
    return detailHistory.Presenter(
      data: shipment,
      onTapFinish: (shipment) {
        System.data.routes.pushNamed(context, RouteName.checkStock, arguments: {
          ParamName.Shipment: arg[ParamName.Shipment],
          ParamName.ShipnentStcock: arg[ParamName.ShipnentStcock],
        });
      },
      onTapTrack: (shipment) {
        System.data.routes.pushNamed(context, RouteName.track, arguments: {
          ParamName.Shipment: shipment,
        });
      },
      onTapViewPod: (pod) {
        System.data.routes
            .pushNamed(context, RouteName.podViewOnly, arguments: {
          ParamName.TmsShipmentPod: pod,
        });
      },
      onTapPendingPod: (shipment) {
        System.data.routes.pushNamed(context, RouteName.pendingData);
      },
    );
  },
  RouteName.detailHistoryEmergency: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailHistory.Presenter(
      view: detailHistory.View(),
      data: arg[ParamName.Shipment],
      finisButtonLabel: System.data.resource.emergency,
      onTapFinish: (shipment) {
        System.data.routes.pushNamed(context, RouteName.emergency, arguments: {
          ParamName.Shipment: shipment,
        });
      },
    );
  },
  RouteName.pod: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    //---using 1 page
    // return pod.Presenter(
    //   view: pod.SieradDriverView(
    //       shipment: arg[ParamName.Shipment],
    //       stock: arg[ParamName.ShipnentStcock],
    //       onSuccess: (shipment) {
    //         System.data.routes
    //             .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
    //       }),
    // );
    //---using multiple page
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment =
        arg[ParamName.Shipment];
    return pod.ProductOnlyPresenter(
      imageQuality: 10,
      destinationId: shipment.tmsShipmentDestinationList.first.detailshipmentId,
      onSubmit: (dataReceiver) {
        System.data.routes.routeHistory.add(RouteHistory(
          routeName: "product",
          needConfirm: false,
          confirmMessage: "",
          onBack: null,
        ));
        NavigationUtil.navTo(
          context,
          pod.ReceiverOnlyPresenter(
            destinationId:
                shipment.tmsShipmentDestinationList.first.detailshipmentId,
            imageQuality: 10,
            viewModel: dataReceiver,
            onSubmit: (dataProduct) {
              System.data.routes.routeHistory.add(
                RouteHistory(
                  routeName: "signature",
                  needConfirm: false,
                  confirmMessage: "",
                  onBack: null,
                ),
              );
              NavigationUtil.navTo(
                context,
                pod.SignatureOnlyPresenter(
                  viewModel: dataProduct,
                  view: pod.SieradDriverView(
                    loadingAnimation: loadingFlareAnimation,
                    loadingAnimationAsset: loadingFlareAssets,
                    shipment: arg[ParamName.Shipment],
                    stock: arg[ParamName.ShipnentStcock],
                    onSuccess: (shipment) {
                      System.data.routes.pushNamedAndRemoveUntil(
                          context, RouteName.dashboard, "");
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  },
  RouteName.checkStock: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment =
        arg[ParamName.Shipment];
    return checkStock.Presenter(
      shipment: shipment,
      onSuccess: (shipment, stock) {
        System.data.routes.pushNamed(context, RouteName.pod, arguments: {
          ParamName.Shipment: shipment,
          ParamName.ShipnentStcock: stock,
        });
      },
    );
  },
  RouteName.emergency: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment =
        arg[ParamName.Shipment];
    return emergency.Presenter(
      view: emergency.SieradDriverView(
        loadingAnimation: loadingFlareAnimation,
        loadingAssets: loadingFlareAssets,
        shipment: shipment,
      ),
      customerName: shipment.customerName,
      shipmentId: shipment.tmsShipmentId,
      shipmentNumber: shipment.shipmentNumber,
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
  RouteName.liveMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>> shipment =
        arg[ParamName.Shipment];
    return liveMap.Presenter(
      vehicleIconTopUrl:
          shipment.first.tmsShipmentDestinationList.first.vehicleTypeIconUrlTop,
      drawRoute: shipment.length > 1 ? false : true,
      view: liveMap.SieradView(
        userType: UserType.Driver,
        sieradViewModel: new liveMap.SieradViewModel(
          shipment: shipment,
          address: "",
          email: "",
          nik: "",
          customerPhoneNumber: shipment.first.customerPhone,
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
                .pushNamed(context, RouteName.singgleHistory, arguments: {
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
      fromDate: DateTime.now().add(Duration(days: -1)),
    );
  },
  RouteName.driverScore: (BuildContext context) {
    return driverScore.Presenter(
      defaultAnimationFile: "assets/flares/sierad/skor_live_bird_sedang.flr",
      midleAnimationFile: "assets/flares/sierad/skor_live_bird_sedang.flr",
      hightAnimationFile: "assets/flares/sierad/skor_live_bird_bagus.flr",
      lowAnimationFile: "assets/flares/sierad/skor_live_bird_buruk.flr",
      defaultAnimationName: "play",
      animationSize: 90,
      view: driverScore.View(),
      score: System.data.getLocal<LocalData>().user.score,
      //data: arg[ParamName.DriverScore],
    );
  },
  RouteName.contactService: (BuildContext context) =>
      contactService.Presenter(),
  RouteName.verificationNewLogin: (BuildContext context) =>
      verification.Presenter(
        view: verification.NewLoginView(
          onSuccessLogin: (data) {
            System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            System.data.routes
                .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
          },
        ),
        sentSms: false,
        verificationCode: System.data.global.newAccount.otpCode,
        withTimer: true,
        scurePhoneNUmber: true,
        duration: Duration(seconds: 60),
        phoneNumber: System.data.global.newAccount.sendTo,
      ),
  RouteName.notification: (BuildContext context) => notification.Presenter(
        loadingAnimation: loadingFlareAnimation,
        loadingAnimationAssets: loadingFlareAssets,
      ),
  RouteName.podViewOnly: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return pod.Presenter(
      view: pod.ReadOnlyView(
        deliveryPodModel: arg[ParamName.TmsShipmentPod],
      ),
    );
  },
  RouteName.pendingData: (BuildContext context) {
    return pendingData.Presenter(
      view: pendingData.SieradView(),
    );
  },
  RouteName.about: (BuildContext context) => about.Presenter(),
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
