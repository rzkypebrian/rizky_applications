import 'dart:convert';

import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NavigationUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/tms/aDriver/localData.dart';
import 'package:enerren/app/tms/module/checkUser/main.dart' as checkUser;
import 'package:enerren/app/tms/module/login/main.dart' as login;
import 'package:enerren/app/uliVaksin/aDriver/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/module/notification/main.dart' as notification;
import 'package:enerren/app/tms/aDriver/module/history/main.dart' as history;
import 'package:enerren/app/tms/module/detailHistory/main.dart'
    as detailHistory;
import 'package:enerren/app/uliVaksin/aDriver/module/checkShipmentStock/main.dart'
    as checkStock;
import 'package:enerren/app/tms/aDriver/module/splashScreen/main.dart'
    as splassScreen;
import 'package:enerren/app/tms/aDriver/module/deleveryEmergencyReport/main.dart'
    as emergency;
import 'package:enerren/module/driverScore/main.dart' as driverScore;
import 'package:enerren/app/tms/module/liveMap/main.dart' as liveMap;
import 'package:enerren/app/tms/aDriver/module/pod/main.dart' as pod;
import 'package:enerren/module/setting/main.dart' as setting;
import 'package:enerren/app/tms/module/password/main.dart' as password;
import 'package:enerren/module/about/main.dart' as about;
import 'package:enerren/module/track/main.dart' as track;
import 'package:enerren/app/tms/aDriver/module/pendingData/main.dart'
    as pendingData;
import 'package:enerren/app/tms/module/verification/main.dart' as verification;

// definisikan enum name alur program anda disini
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
  MaintenanceFinish,
  StockProcess,
  HistoryStock,
  PathImage,
  TagImage
}

//definisikan initial root name
String initialEouteName = RouteName.splashScreen;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splashScreen: (BuildContext context) => splassScreen.Presenter(
        view: splassScreen.DriverView()
          ..logoAssets = "assets/uliVaksin/logo_unilever.svg"
          ..logoColor = System.data.colorUtil.lightTextColor
          ..logoSize = 150
          ..backgroundColor = System.data.colorUtil.primaryColor,
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
        view: checkUser.TmsView()
          ..logoAssets = "assets/uliVaksin/logo_unilever.svg",
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
      view: login.TmsView()..logoAssets = "assets/uliVaksin/logo_unilever.svg",
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
        view: verification.TmsView(),
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
        view: password.TmsView(),
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
          },
        )
          ..showTmsLogo = true
          ..image1 = "-"
          ..image2 = '-'
          ..companyLogoAssets = "assets/uliVaksin/logo_unilever.svg",
      ),
  RouteName.notification: (BuildContext context) => notification.Presenter(),
  RouteName.history: (BuildContext context) => history.Presenter(
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
  RouteName.detailHistory: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return detailHistory.Presenter(
      data: shipment,
      onTapFinish: (shipment) {
        System.data.routes.pushNamed(context, RouteName.checkStock, arguments: {
          ParamName.Shipment: arg[ParamName.Shipment],
        });
      },
      onTapTrack: (shipment) {
        System.data.routes.pushNamed(context, RouteName.track, arguments: {
          ParamName.Shipment: shipment,
        });
      },
      //TODO: detail bongkar
      // onTapViewPod: (pod) {
      //   System.data.routes
      //       .pushNamed(context, RouteName.podViewOnly, arguments: {
      //     ParamName.TmsShipmentPod: pod,
      //   });
      // },
      onTapPendingPod: (shipment) {
        System.data.routes.pushNamed(context, RouteName.pendingData);
      },
    );
  },
  RouteName.podViewOnly: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return pod.Presenter(
      view: pod.ReadOnlyView(deliveryPodModel: arg[ParamName.TmsShipmentPod]),
    );
  },
  RouteName.historyForEmergency: (BuildContext context) => history.Presenter(
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
  RouteName.emergency: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return emergency.Presenter(
      view: emergency.DriverView(
        shipment: shipment,
      ),
      customerName: shipment.customerName,
      shipmentId: shipment.tmsShipmentId,
      shipmentNumber: shipment.shipmentNumber,
    );
  },
  RouteName.driverScore: (BuildContext context) {
    return driverScore.Presenter(
      view: driverScore.View(),
      score: System.data.getLocal<LocalData>().user.score,
      lowAnimationFile: "assets/flares/tms/troli_score_1.flr",
      midleAnimationFile: "assets/flares/tms/troli_score_2.flr",
      hightAnimationFile: "assets/flares/tms/troli_score_3.flr",
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
  RouteName.liveMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    List<TmsShipmentModel> shipment = arg[ParamName.Shipment];
    return liveMap.Presenter(
      vehicleIconTopUrl:
          shipment.first.tmsShipmentDestinationList.first.vehicleTypeIconUrlTop,
      drawRoute: shipment.length > 1 ? false : true,
      view: liveMap.TmsView(
        userType: UserType.Driver,
        tmsViewModel: new liveMap.TmsViewModel(
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
  RouteName.checkStock: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return checkStock.Presenter(
      shipment: arg[ParamName.Shipment],
      onSuccess: (shipment, stock) {
        System.data.routes.pushNamed(context, RouteName.pod, arguments: {
          ParamName.Shipment: shipment,
          ParamName.ShipnentStcock: stock,
        });
      },
    );
  },
  RouteName.pod: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    // return pod.Presenter(
    //   view: pod.TmsDriverView(
    //     shipment: arg[ParamName.Shipment],
    //     onSuccess: (shipment) {
    //       System.data.routes
    //           .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
    //     },
    //   ),
    // );
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return pod.ReceiverOnlyPresenter(
      destinationId: shipment.tmsShipmentDestinationList.first.detailshipmentId,
      onSubmit: (reciverPhoto) {
        System.data.routes.routeHistory.add(RouteHistory(
          routeName: "product",
          needConfirm: false,
          confirmMessage: "",
          onBack: null,
        ));
        NavigationUtil.navTo(
          context,
          pod.ProductOnlyPresenter(
            destinationId:
                shipment.tmsShipmentDestinationList.first.detailshipmentId,
            viewModel: reciverPhoto,
            onSubmit: (productPhoto) {
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
                  viewModel: productPhoto,
                  view: pod.TmsDriverView(
                    shipment: arg[ParamName.Shipment],
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
        view: password.TmsView(),
        passwordState: password.PasswordState.ChangePassword,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
        },
      ),
  RouteName.about: (BuildContext context) => about.Presenter(),
  RouteName.track: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return track.Presenter(
      showButtonMap: shipment.tmsShipmentDestinationList.first.detailStatus ==
                  "POD" ||
              shipment.tmsShipmentDestinationList.first.detailStatus == "CNCL"
          ? false
          : true,
      onTapLiveMap: () {
        System.data.routes.pushNamed(context, RouteName.liveMap, arguments: {
          ParamName.Shipment: <TmsShipmentModel>[shipment],
        });
      },
      data: shipment
          .tmsShipmentDestinationList.first.tmsShipmentDetailHistoryList,
    );
  },
  RouteName.pendingData: (BuildContext context) {
    return pendingData.Presenter(
      view: pendingData.TmsView(),
    );
  },
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
