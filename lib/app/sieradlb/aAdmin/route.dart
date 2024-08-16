import 'dart:convert';

import 'package:enerren/app/sierad/aTransporter/localData.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/TransporterModel.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/sierad/aTransporter/module/checkUser/main.dart'
    as checkUser;
import 'package:enerren/app/sierad/aTransporter/module/login/main.dart'
    as login;
import 'package:enerren/app/sierad/module/verification/main.dart'
    as verification;
import 'package:enerren/app/sierad/module/password/main.dart' as password;
import 'package:enerren/app/sierad/aTransporter/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/module/setting/main.dart' as setting;
import 'package:enerren/app/sierad/aDriver/module/history/main.dart' as history;
import 'package:enerren/app/sierad/aTransporter/module/profile/main.dart'
    as profile;
import 'package:enerren/app/sierad/aTransporter/module/detailHistory/main.dart'
    as detailHistory;
import 'package:enerren/module/track/main.dart' as track;
import 'package:enerren/app/sierad/module/liveMap/main.dart' as liveMap;
import 'package:enerren/module/contactService/main.dart' as contactService;
import 'package:enerren/app/sierad/module/listVehicle/main.dart' as listVehicle;
import 'package:enerren/app/sierad/module/vehicleDetail/main.dart'
    as detailVehicle;
import 'package:enerren/app/sierad/aTransporter/module/driverDetail/main.dart'
    as detailDriver;
import 'package:enerren/app/sierad/module/map/main.dart' as maps;
import 'package:enerren/module/notification/main.dart' as notification;
import 'package:enerren/app/sierad/aTransporter/module/splashScreen/main.dart'
    as splasScreen;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:enerren/module/historyMap/main.dart' as historyMap;
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
  static const String profile = "profile";
  static const String changePassword = "changePassword";
  static const String singleHistory = "singleHistory";
  static const String detailHistory = "detailHistory";
  static const String track = "track";
  static const String liveMap = "liveMap";
  static const String liveTrack = "liveTrack";
  static const String contactService = "contactService";
  static const String verificationNewLogin = "verificationNewLogin";
  static const String listVehicle = "listVehicle";
  static const String detailVehicle = "detailVehicle";
  static const String detailDriver = "detailDriver";
  static const String maps = "maps";
  static const String notification = "notification";
  static const String changeProfile = "changeProfile";
  static const String singgleListShipment = "singgleListShipment";
  static const String splasScreen = "splasScreen";
  static const String historyMap = "historyMap";
  static const String pod = "pod";
  static const String about = "about";
}

enum ParamName {
  Username,
  Shipment,
  DetailVehicleViewModel,
  OnDetailVehicleDetailTapDriver,
  TmsVehicleModel,
  VtsPositionModel,
  VtsVehicleId,
  FromDate,
  ToDate,
  TmsPodModel,
}

//definisikan initial root name
String initialEouteName = RouteName.splasScreen;
String loadingFlareAssets = "assets/flares/sierad/loader_live_bird.flr";
String loadingFlareAnimation = "play";

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splasScreen: (BuildContext context) => splasScreen.Presenter(
        view: splasScreen.TransporterView()
          ..logoUrl = "assets/sierad/splash_screen_live_bird.svg"
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets,
        onFinishSpashScreen: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushAndReplaceName(context, RouteName.login);
          } else {
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            System.data.routes.pushAndReplaceName(context, RouteName.dashboard);
          }
        },
      ),
  RouteName.checkUser: (BuildContext context) => checkUser.Presenter(
        view: checkUser.TransporterView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets
          ..logoUrl = "assets/sierad/logo_live_bird.svg"
          ..image1 = "-"
          ..image2 = "-"
          ..image3 = "-"
          ..image4 = "-"
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
      view: login.TransporterView()
        ..flareAnimation = loadingFlareAnimation
        ..flareAssets = loadingFlareAssets
        ..logoUrl = "assets/sierad/logo_live_bird.svg"
        ..image1 = "-"
        ..image2 = "-"
        ..image3 = "-"
        ..image4 = "-"
        ..logoWidth = 100,
      username: arg[ParamName.Username],
      onLoginSuccess: (data) {
        System.data.getLocal<LocalData>().user =
            TransporterModel.fromJson(data);
        System.data.global.token = System.data.getLocal<LocalData>().user.token;
        System.data.sharedPreferences.setString(
            PrefsKey.user, json.encode(System.data.getLocal<LocalData>().user));
        System.data.routes
            .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
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
        phoneNumber: System.data.global.newAccount.sendTo,
        sentSms: false,
        duration: Duration(minutes: 1),
        withTimer: true,
        verificationCode: System.data.global.newAccount.otpCode,
        onVerificationValid: (str) {
          System.data.routes.pushNamed(context, RouteName.createPassword);
        },
      ),
  RouteName.createPassword: (BuildContext context) => password.Presenter(
        passwordState: password.PasswordState.CreatePassword,
        view: password.SieradView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user =
              TransporterModel.fromJson(data);
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
        view: dashboard.TransporterView(
          orderIcon: "assets/sierad/live_bird_order.svg",
          siagaIcon: "assets/sierad/live_bird_siaga.svg",
          istirahatIcon: "assets/sierad/live_bird_istirahat.svg",
          alignValue: Alignment.topCenter,
          paddingSiagaValue: EdgeInsets.only(top: 51, right: 5),
          paddingIstirahatValue: EdgeInsets.only(top: 51, right: 5),
          paddingOrderValue: EdgeInsets.only(top: 51, left: 10),
          colorValue: System.data.colorUtil.darkTextColor,
          onSetting: () {
            System.data.routes.pushNamed(context, RouteName.setting);
          },
          onHistory: () {
            System.data.routes.pushNamed(context, RouteName.history);
          },
          onContactService: () {
            System.data.routes.pushNamed(context, RouteName.contactService);
          },
          onTaplistVehicle: () {
            System.data.routes.pushNamed(context, RouteName.listVehicle);
          },
          onTapMap: () {
            System.data.routes.pushNamed(context, RouteName.maps);
          },
          onNotification: () {
            System.data.routes.pushNamed(context, RouteName.notification);
          },
        )
          ..image1 = "-"
          ..image2 = "-"
          ..companyLogoUrl = "assets/sierad/logo_live_bird.svg"
          ..companyLogoSize = 50,
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
            System.data.routes.pushNamed(
              context,
              RouteName.singleHistory,
              arguments: {
                ParamName.Shipment: shipment,
              },
            );
          } else {
            System.data.routes
                .pushNamed(context, RouteName.detailHistory, arguments: {
              ParamName.Shipment: shipment,
            });
          }
        },
      ),
  RouteName.singgleListShipment: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return history.Presenter(
      view: history.SinggleListShipmentView(data: arg[ParamName.Shipment]),
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
    );
  },
  RouteName.profile: (BuildContext context) => profile.Presenter(
        view: profile.TransporterView(),
      ),
  RouteName.changePassword: (BuildContext context) => password.Presenter(
        view: password.SieradView()
          ..flareAnimation = loadingFlareAnimation
          ..flareAssets = loadingFlareAssets,
        passwordState: password.PasswordState.ChangePassword,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user =
              TransporterModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
        },
      ),
  RouteName.singleHistory: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return history.Presenter(
      view: history.SinggleListView(
        data: arg[ParamName.Shipment],
      ),
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
    );
  },
  RouteName.detailHistory: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> data =
        arg[ParamName.Shipment];
    return detailHistory.Presenter(
      data: data,
      view: data.shipmentType == "HE"
          ? detailHistory.HeTransporterView()
          : data.shipmentType == "BAS"
              ? detailHistory.BasketPresenterView()
              : detailHistory.TransporterView(),
      onTapTrack: (shipment) {
        System.data.routes.pushNamed(context, RouteName.track, arguments: {
          ParamName.Shipment: shipment,
        });
      },
      onTapViewPod: (pod) {
        System.data.routes.pushNamed(context, RouteName.pod, arguments: {
          ParamName.TmsPodModel: pod,
        });
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
        System.data.routes.pushNamed(context, RouteName.liveTrack, arguments: {
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
    TmsVehicleModel<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
        vehiclesData = arg[ParamName.TmsVehicleModel];
    return liveMap.Presenter(
      view: liveMap.TransporterView(
        sieradViewModel: liveMap.SieradViewModel(
          nik: vehiclesData?.driverNik,
          driverImageUrl: vehiclesData?.driverImageUrl,
          address: vehiclesData?.driverAddress,
          birdDate: vehiclesData?.driverBirthDate,
          driverName: vehiclesData?.driverName,
          email: vehiclesData?.driverEmail,
          customerPhoneNumber: vehiclesData?.driverPhoneNumber,
          rating: 5,
          temperature: 50,
          vehicleImageUrl: vehiclesData?.vehicleTypeIconUrl,
          vehicleName: vehiclesData?.vehicleName,
          vehicleNumber: vehiclesData?.vehicleNumber,
          vehicleType: vehiclesData?.vehicleTypeName,
          shipment: vehiclesData?.shipmentHeaderData,
          fanSensorCode: vehiclesData?.vehicleFanSensor,
          backdoorSensorCode: vehiclesData?.vehicleBackDoorSensor,
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
      )..mapToDestination = false,
      destination: null,
      vehicleIconTopUrl: vehiclesData.vehicleTypeIconUrlTop,
      vehicleId: vehiclesData.vtsVehicleId,
      fromDate: DateTime.now().add(
        Duration(days: -1),
      ),
    );
  },
  RouteName.contactService: (BuildContext context) =>
      contactService.Presenter(),
  RouteName.verificationNewLogin: (BuildContext context) =>
      verification.Presenter(
        view: verification.NewLoginView(onSuccessLogin: (data) {
          System.data.getLocal<LocalData>().user =
              TransporterModel.fromJson(data);
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
  RouteName.listVehicle: (BuildContext context) => listVehicle.Presenter<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>(
        view: listVehicle.SieradView<
            TmsShipmentModel<SieradShipmentDetailHatcheryModel>>(),
        userIdVts:
            System.data.getLocal<LocalData>().user.transporterIdVts ?? 65606274,
        tokenVts: System.data.getLocal<LocalData>().user.transporterTokenVts ??
            'dc5c9c3b2299c8ed1b7ba31b74936073',
        childReader: (json) =>
            TmsShipmentModel.fromJson<SieradShipmentDetailHatcheryModel>(json,
                childReader: (data) {
          return SieradShipmentDetailHatcheryModel.fromJson(json);
        }),
        onTapDriver: (tmsVehicle, vtsPositionModel) {
          System.data.routes
              .pushNamed(context, RouteName.detailDriver, arguments: {
            ParamName.TmsVehicleModel: tmsVehicle,
            ParamName.VtsPositionModel: vtsPositionModel,
          });
        },
        onTapVehicle: (tmsVehiccle, vtsPositionMOdel) {
          System.data.routes.pushNamed(
            context,
            RouteName.detailVehicle,
            arguments: {
              ParamName.TmsVehicleModel: tmsVehiccle,
              ParamName.VtsPositionModel: vtsPositionMOdel,
              ParamName.OnDetailVehicleDetailTapDriver:
                  (detailVehicle.ViewModel data) {
                System.data.routes.pushAndReplaceName(
                  context,
                  RouteName.detailDriver,
                  arguments: {
                    ParamName.TmsVehicleModel: tmsVehiccle,
                  },
                );
              },
            },
          );
        },
      ),
  RouteName.detailVehicle: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsVehicleModel data = arg[ParamName.TmsVehicleModel];
    return detailVehicle.Presenter(
      view: detailVehicle.SieradView(),
      initData: detailVehicle.ViewModel(
        vtsPositionModel: arg[ParamName.VtsPositionModel],
        vehicleModel: data,
      ),
      onTapSearch: (viewModel) {
        System.data.routes.pushNamed(context, RouteName.liveMap, arguments: {
          ParamName.TmsVehicleModel: data,
        });
      },
      onTapDriver: arg[ParamName.OnDetailVehicleDetailTapDriver],
    );
  },
  RouteName.detailDriver: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsVehicleModel data = arg[ParamName.TmsVehicleModel];
    return detailDriver.Presenter(
      view: detailDriver.TransPorterView(
          dataShipment: data.shipmentHeaderData,
          onTapDetailShipment: (shipment) {
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
          }),
      initData: detailDriver.ViewModel(
        address: data.driverAddress,
        birdDate: data.driverBirthDate,
        driverName: data.driverName,
        driverNik: data.driverNik,
        email: data.driverEmail,
        phoneNumber: data.driverPhoneNumber,
        urlDriverImmage: data.driverImageUrl,
        vehicleType: data.vehicleTypeName,
      ),
      onTapVehicle: (viewModel) {
        System.data.routes
            .pushAndReplaceName(context, RouteName.detailVehicle, arguments: {
          ParamName.TmsVehicleModel: data,
          ParamName.VtsPositionModel: arg[ParamName.VtsPositionModel]
        });
      },
    );
  },
  RouteName.maps: (BuildContext context) {
    return maps.Presenter(
      view: maps.SieradView(
        onTapDetailOrder: (shipment) {
          if (shipment.length > 1) {
            System.data.routes
                .pushNamed(context, RouteName.singgleListShipment, arguments: {
              ParamName.Shipment: shipment,
            });
          } else {
            if (shipment.first.tmsShipmentDestinationList.length > 1) {
              System.data.routes
                  .pushNamed(context, RouteName.singleHistory, arguments: {
                ParamName.Shipment: shipment.first,
              });
            } else {
              System.data.routes
                  .pushNamed(context, RouteName.detailHistory, arguments: {
                ParamName.Shipment: shipment.first,
              });
            }
          }
        },
        onTapSearchHistoery: (vehicleIdVts, fromDate, toDate) {
          System.data.routes
              .pushNamed(context, RouteName.historyMap, arguments: {
            ParamName.VtsVehicleId: vehicleIdVts,
            ParamName.FromDate: fromDate,
            ParamName.ToDate: toDate,
          });
        },
      ),
      userId:
          System.data.getLocal<LocalData>().user.transporterIdVts ?? 65606274,
      token: System.data.getLocal<LocalData>().user.transporterTokenVts ??
          'dc5c9c3b2299c8ed1b7ba31b74936073',
    );
  },
  RouteName.liveTrack: (BuildContext context) {
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
          customerPhoneNumber: "",
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
          backdoorSensorCode: shipment
              .first.tmsShipmentDestinationList.first.vehicleBackDoorSensor,
          fanSensorCode:
              shipment.first.tmsShipmentDestinationList.first.vehicleFanSensor,
          driverPhoneNumber:
              shipment.first.tmsShipmentDestinationList.first.driverPhone,
        ),
        onTapDetailOrder: (shipment) {
          if (shipment.tmsShipmentDestinationList.length > 1) {
            System.data.routes.pushNamed(
              context,
              RouteName.singleHistory,
              arguments: {
                ParamName.Shipment: shipment,
              },
            );
          } else {
            System.data.routes.pushNamed(
              context,
              RouteName.detailHistory,
              arguments: {
                ParamName.Shipment: shipment,
              },
            );
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
  RouteName.notification: (BuildContext context) => notification.Presenter(
        loadingAnimation: loadingFlareAnimation,
        loadingAnimationAssets: loadingFlareAssets,
      ),
  RouteName.historyMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return historyMap.Presenter(
      vehicleIdVts: arg[ParamName.VtsVehicleId],
      fromDate: arg[ParamName.FromDate],
      toDate: arg[ParamName.ToDate],
    );
  },
  RouteName.pod: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsDeliveryPodModel podData = arg[ParamName.TmsPodModel];
    return pod.Presenter(
      view: pod.ReadOnlyView(
        deliveryPodModel: podData,
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
