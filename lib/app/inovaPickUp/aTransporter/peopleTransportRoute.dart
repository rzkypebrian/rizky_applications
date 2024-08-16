import 'dart:convert';

import 'package:enerren/app/angkut/aTransporter/localData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/TransporterModel.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/util/MarkerUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/angkut/module/checkUser/main.dart' as checkUser;
import 'package:enerren/app/angkut/module/login/main.dart' as login;
import 'package:enerren/app/inovaPickup/aTransporter/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/app/angkut/aTransporter/module/listVehicle/main.dart'
    as listVehicle;
import 'package:enerren/app/angkut/aTransporter/module/detailVehicle/main.dart'
    as vehicleDetail;
import 'package:enerren/app/angkut/aTransporter/module/detailDriver/main.dart'
    as driverDetail;
import 'package:enerren/app/angkut/module/liveMap/main.dart' as liveMap;
import 'package:enerren/app/angkut/module/map/main.dart' as maps;
import 'package:enerren/app/angkut/aTransporter/module/listAbsent/main.dart'
    as absent;
import 'package:enerren/module/driverAbsent/main.dart' as absentDetail;
import 'package:enerren/module/tripAllowanceList/main.dart' as uangJalan;
import 'package:enerren/module/tripAllowaceDetail/main.dart' as detailuangJalan;
import 'package:enerren/app/angkut/aTransporter/module/profile/main.dart'
    as profile;
import 'package:enerren/app/angkut/aDriver/module/history/main.dart' as history;
import 'package:enerren/app/angkut/module/verification/main.dart'
    as verification;
import 'package:enerren/app/angkut/aTransporter/module/orderDetail/main.dart'
    as orderDetail;
import 'package:enerren/app/angkut/aTransporter/module/bill/main.dart' as bill;
import 'package:enerren/app/angkut/aTransporter/module/setting/main.dart'
    as setting;
import 'package:enerren/app/angkut/module/password/main.dart' as password;
import 'package:enerren/app/angkut/aTransporter/module/splashScreen/main.dart'
    as splashScreen;
import 'package:enerren/module/track/main.dart' as track;
import 'package:enerren/app/angkut/module/notification/main.dart'
    as notification;
import 'package:enerren/module/historyMap/main.dart' as historyMap;
import 'package:enerren/module/deleveryEmergencyDetail/main.dart'
    as deliveryEmergencyDetail;
import 'package:enerren/app/angkut/aDriver/module/profile/main.dart'
    as driverProfile;
import 'package:enerren/module/do/main.dart' as dos;
import 'package:enerren/module/shipmentItemDescription/main.dart'
    as shipmentItemDescription;
import 'package:enerren/module/deliveryPod/main.dart' as pod;
import 'package:enerren/app/angkut/aTransporter/module/billList/main.dart'
    as billList;
import 'package:enerren/app/angkut/aTransporter/module/billSummary/main.dart'
    as billSummary;
import 'package:enerren/app/angkut/aTransporter/module/billDetail/main.dart'
    as billReport;
import 'package:enerren/app/inovaPickUp/util/ResourceUtil.dart';

//definisikan enum name alur program anda disini
class RouteName {
  static const String checkUser = "checkUser";
  static const String login = "login";
  static const String dashboard = "dashboard";
  static const String listVehicle = "listVehicle";
  static const String vehicleDetail = "vehicleDetail";
  static const String driverDetail = "driverDetail";
  static const String liveMap = "liveMao";
  static const String maps = "maps";
  static const String absent = "absent";
  static const String absentDetail = "absentDetail";
  static const String uangJalan = "uangJalan";
  static const String detailuangJalan = "detailuangJalan";
  static const String profile = "profile";
  static const String history = "history";
  static const String verificationNewLogin = "verificationNewLogin";
  static const String orderDetail = "orderDetail";
  static const String bill = "bill";
  static const String setting = "setting";
  static const String changePassword = "changePassword";
  static const String changeLanguage = "changeLanguage";
  static const String splashScreen = "splashScreen";
  static const String track = "track";
  static const String liveTrack = "liveTrack";
  static const String notification = "notification";
  static const String listShipmentForUangJalan = "listShipmentForUangJalan";
  static const String historyMap = "historyMap";
  static const String createPassword = "createPassword";
  static const String verification = "forgotPassword";
  static const String detailEmergencyDetail = "detailEmergencyDetail";
  static const String driverProfile = "driverProfile";
  static const String dos = "dos";
  static const String loadingShipmentItemDescription =
      "loadingShipmentItemDescription";
  static const String unLoadingShipmentItemDescription =
      "unLoadingShipmentItemDescription";
  static const String readOnlyPod = "readOnlyPod";
  static const String incomeList = "incomeList";
  static const String outComeList = "paymentlist";
  static const String incomeSumary = "incomeSumary";
  static const String outComeSummary = "paymentsummary";
  static const String incomeReport = "billReport";
  static const String outComeReport = "paymentreport";
}

enum ParamName {
  Username,
  Shipment,
  DetailVehicleViewModel,
  OnDetailVehicleDetailTapDriver,
  TmsVehicleModel,
  VtsPositionModel,
  AngkutBudgetOperationModel,
  TmsVehicleCheckDocument,
  AngkutShipmentModel,
  VtsVehicleId,
  Notification,
  UangJalanViewModel,
  HistoryMap,
  FromDate,
  ToDate,
  ShipmentDeliveryEmergencyDetail,
  ProfileModel,
  TabVehicleActive,
  TabListVehicleActive,
  TmsShipmentPodModel,
  Invoices,
  Invoice,
  FirstDate,
  LastDate,
  ShowShipmentNumber,
  DestinationId,
}

//definisikan initial root name
String initialEouteName = RouteName.splashScreen;
// String initialEouteName = RouteName.checkUser;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splashScreen: (BuildContext context) => splashScreen.Presenter(
        view: splashScreen.TransporterView()
          ..animationAssets = System.data.global.splascreenAnimationAssets
          ..animationName = System.data.global.splasscreenAnimationName,
        onFinishSpashScreen: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes
                .pushNamedAndRemoveUntil(context, RouteName.login, "");
          } else {
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            System.data.routes
                .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
            ModeUtil.debugPrint("toke : ${System.data.global.token}");
            ModeUtil.debugPrint(
                "deviceId : ${System.data.global.mmassagingToken}");
          }
        },
      ),
  RouteName.checkUser: (BuildContext context) => checkUser.Presenter(
        view: checkUser.AngkutView(),
        onUserIsActive: (accountModel) {
          System.data.routes.pushNamed(context, RouteName.login, arguments: {
            ParamName.Username: accountModel.username,
          });
        },
        onUserIsNonActive: (accountModel) {
          // System.data.global.newAccount = accountModel;
          // System.data.routes.pushNamed(context, RouteName.verification);
        },
      ),
  RouteName.login: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return login.Presenter(
      view: login.AngkutView(),
      username: arg[ParamName.Username],
      onLoginSuccess: (data) {
        System.data.getLocal<LocalData>().user =
            TransporterModel.fromJson(data);
        System.data.global.token = System.data.getLocal<LocalData>().user.token;
        System.data.sharedPreferences.setString(PrefsKey.user,
            json.encode(System.data.getLocal<LocalData>().user.toJson()));
        System.commit();
        System.data.routes
            .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        ModeUtil.debugPrint(
            "toke : ${System.data.global.token = System.data.getLocal<LocalData>().user.token}");
        ModeUtil.debugPrint("deviceId : ${System.data.global.mmassagingToken}");
      },
      onAccessDenied: (username, password, account) {
        System.data.global.newAccount = AccountModel.fromJson(account);
        System.data.global.newAccount.username = username;
        System.data.global.newAccount.password = password;
        System.data.routes.pushNamed(context, RouteName.verificationNewLogin);
      },
      onForgotPasswordSuccess: (accountModel) {
        System.data.global.newAccount = accountModel;
        System.data.routes.pushNamed(context, RouteName.verification);
      },
    );
  },
  RouteName.verificationNewLogin: (BuildContext context) =>
      verification.Presenter(
        view: verification.NewLoginView(
          onSuccessLogin: (data) {
            System.data.getLocal<LocalData>().user =
                TransporterModel.fromJson(data);
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
  RouteName.dashboard: (BuildContext context) => dashboard.Presenter(
        gotoProfile: () {
          System.data.routes.pushNamed(context, RouteName.profile);
        },
        view: dashboard.PeopleTransportView(
            notificationAnimationAsset:
                "assets/flares/inovapickup/bell_norification.flr",
            onTapListVehicle: () {
              System.data.routes.pushNamed(context, RouteName.listVehicle);
            },
            onTapMaps: () {
              System.data.routes.pushNamed(context, RouteName.maps);
            },
            onTapAbsent: () {
              System.data.routes.pushNamed(context, RouteName.absent);
            },
            onTapUangJalan: () {
              System.data.routes.pushNamed(context, RouteName.uangJalan);
            },
            onTapHistory: () {
              System.data.routes.pushNamed(context, RouteName.history);
            },
            onTapBill: () {
              System.data.routes.pushNamed(context, RouteName.bill);
            },
            onTapSetting: () {
              System.data.routes.pushNamed(context, RouteName.setting);
            },
            onTapNotification: () {
              System.data.routes.pushNamed(context, RouteName.notification);
            },
            onTapVehicleStatus: (id) {
              System.data.routes
                  .pushNamed(context, RouteName.listVehicle, arguments: {
                ParamName.TabVehicleActive: id,
                ParamName.TabListVehicleActive: 1,
              });
            }),
      ),
  RouteName.history: (BuildContext context) => history.Presenter(
        showExtraPeople: true,
        showPaidStatus: false,
        showPrice: false,
        onSelected: (vm, shipment) {
          System.data.routes.pushNamed(
            context,
            RouteName.orderDetail,
            arguments: {
              ParamName.Shipment: shipment,
              ParamName.ShowShipmentNumber: shipment.shipmentStatusId == 1 ||
                      shipment.shipmentStatusId == 2
                  ? false
                  : true,
            },
          );
        },
      ),
  RouteName.orderDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return orderDetail.Presenter(
      showContactPerson: false,
      showInchargeStatus: false,
      showPaymentDetail: false,
      shipment: arg[ParamName.Shipment],
      showShipmentNumber: arg[ParamName.ShowShipmentNumber],
      onTapLiveMap: (shipment) {
        System.data.routes.pushNamed(context, RouteName.track, arguments: {
          ParamName.AngkutShipmentModel: shipment,
        });
      },
      onTapDriver: (shipment, emergencyData) {
        if (emergencyData != null) {
          System.data.routes.pushNamed(
            context,
            RouteName.detailEmergencyDetail,
            arguments: {
              ParamName.ShipmentDeliveryEmergencyDetail: emergencyData,
            },
          );
        }
      },
      onTapLoadingDetail: (angkutShipmentModel, destinationId) {
        System.data.routes.pushNamed(
            context, RouteName.loadingShipmentItemDescription,
            arguments: {
              ParamName.AngkutShipmentModel: angkutShipmentModel,
              ParamName.DestinationId: destinationId,
            });
      },
      onTapUnloadingDetail: (angkutShipmentModel, destinationId) {
        System.data.routes.pushNamed(
            context, RouteName.unLoadingShipmentItemDescription,
            arguments: {
              ParamName.AngkutShipmentModel: angkutShipmentModel,
              ParamName.DestinationId: destinationId,
            });
      },
      onTapTripReport: (angkutUangJalan) {
        System.data.routes.pushNamed(
          context,
          RouteName.detailuangJalan,
          arguments: {
            ParamName.AngkutBudgetOperationModel: angkutUangJalan,
          },
        );
      },
      view: orderDetail.TransporterView(
        onTapAddAllowanceBalance: (shipment) {
          System.data.routes.pushNamed(
            context,
            RouteName.uangJalan,
            arguments: {
              ParamName.AngkutShipmentModel: shipment,
            },
          );
        },
      ),
    );
  },
  RouteName.listVehicle: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return listVehicle.Presenter<AngkutShipmentModel>(
      view: listVehicle.AngkutView<AngkutShipmentModel>(),
      withUnSuitableVehicle: false,
      selectedTab: arg[ParamName.TabListVehicleActive],
      selectedDriverTab: arg[ParamName.TabVehicleActive],
      selectedVehicleTab: arg[ParamName.TabVehicleActive],
      childReader: (json) => AngkutShipmentModel.fromJson(json),
      onTapVehicle: (tmsVehicleModel, vtsPositionMOdel) {
        print("masuk sini");
        System.data.routes
            .pushNamed(context, RouteName.vehicleDetail, arguments: {
          ParamName.TmsVehicleModel: tmsVehicleModel,
          ParamName.VtsPositionModel: vtsPositionMOdel,
        });
      },
      onTapDriver: (tmsVehicleModel, vtsPosistionModel) {
        System.data.routes
            .pushNamed(context, RouteName.driverDetail, arguments: {
          ParamName.TmsVehicleModel: tmsVehicleModel,
          ParamName.VtsPositionModel: vtsPosistionModel,
        });
      },
      userIdVts:
          System.data.getLocal<LocalData>().user.transporterIdVts ?? 63701600,
      tokenVts: System.data.getLocal<LocalData>().user.transporterTokenVts ??
          'd4a190c10c4105424db0ad936b2f474a',
    );
  },
  RouteName.vehicleDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsVehicleModel<AngkutShipmentModel> vehicle =
        arg[ParamName.TmsVehicleModel];
    return vehicleDetail.Presenter(
      view: vehicleDetail.AngkutView(),
      initData: new vehicleDetail.ViewModel(
        vtsPositionModel: arg[ParamName.VtsPositionModel],
        vehicleModel: vehicle,
      ),
      onTapDriver: (viewModel) {
        System.data.routes.pushNamed(
          context,
          RouteName.driverDetail,
          arguments: {
            ParamName.TmsVehicleModel: vehicle,
            ParamName.VtsPositionModel: viewModel.vtsPositionModel,
          },
        );
      },
      onTapSearch: (vm) {
        System.data.routes.pushNamed(context, RouteName.liveTrack, arguments: {
          ParamName.TmsVehicleModel: vehicle,
          ParamName.AngkutShipmentModel:
              AngkutShipmentModel(tmsShipmentDestinationList: [
            TmsShipmentDestinationModel(
              vehicleType: vehicle.vehicleTypeName,
              driverName: vehicle.driverName,
              vehicleNo: vehicle.vehicleNumber,
              driverPhone: vehicle.driverPhoneNumber,
              driverImageUrl: vehicle.driverImageUrl,
              vehicleTypeIconUrl: vehicle.vehicleTypeIconUrl,
              vehicleTypeIconUrlTop: vehicle.vehicleTypeIconUrlTop,
            )
          ]),
        });
      },
    );
  },
  RouteName.driverDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsVehicleModel<AngkutShipmentModel> vehicle =
        arg[ParamName.TmsVehicleModel];
    return driverDetail.Presenter(
      view: driverDetail.AngkutView(),
      initData: driverDetail.ViewModel(
        address: vehicle.driverAddress,
        birdDate: vehicle.driverBirthDate,
        driverName: vehicle.driverName,
        driverNik: vehicle.driverNik,
        email: vehicle.driverEmail,
        phoneNumber: vehicle.driverPhoneNumber,
        urlDriverImmage: vehicle.driverImageUrl,
        vehicleType: vehicle.vehicleTypeName,
        score: vehicle.driverScore,
      ),
      onTapVehicle: (vm) {
        System.data.routes
            .pushNamed(context, RouteName.vehicleDetail, arguments: {
          ParamName.TmsVehicleModel: vehicle,
          ParamName.VtsPositionModel: arg[ParamName.VtsPositionModel]
        });
      },
    );
  },
  RouteName.liveMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    List<TmsShipmentDestinationModel> destinationShipment =
        (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
            .tmsShipmentDestinationList;
    return liveMap.Presenter(
      view: liveMap.AngkutView(
        shipmentModel: arg[ParamName.AngkutShipmentModel],
      ),
      vehicleId: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
                  .shipmentStatusId ==
              10
          ? null
          : destinationShipment.first.vehicleIdVts,
      vehicleIconTopUrl: destinationShipment.first.vehicleTypeIconUrlTop,
      vehicleIconTopSize:
          destinationShipment.first.vehicleTypeIconTopSize ?? 150,
      destination: MarkerUtil.readPointDestination(
        destinations: destinationShipment,
        markerOriginIcon: "assets/inovapickup/man.png",
        markerOriginIconSize: 50,
        // markerDestinationIcon: "assets/angkut/flag_destination.png",
        markerDestinationIconSize: 100,
      ),
      fromDate: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
              .beginDatetime ??
          DateTime.now().add(
            Duration(hours: -2),
          ),
      toDate: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
                  .shipmentStatusId ==
              10
          ? (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
              .completeDatetime
          : null,
      liveTrack: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
                  .shipmentStatusId ==
              10
          ? false
          : true,
    );
  },
  RouteName.liveTrack: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsVehicleModel<AngkutShipmentModel> tmsVehicleModel =
        arg[ParamName.TmsVehicleModel];
    return liveMap.Presenter(
      view: liveMap.AngkutView(
        shipmentModel: arg[ParamName.AngkutShipmentModel],
      ),
      vehicleId: tmsVehicleModel.vtsVehicleId,
      vehicleIconTopUrl: tmsVehicleModel?.vehicleTypeIconUrlTop,
      vehicleIconTopSize: tmsVehicleModel.vehicleTypeIconTopSize ?? 150,
      destination: MarkerUtil.readPointDestination(
        destinations: tmsVehicleModel?.shipmentHeaderData != null
            ? tmsVehicleModel.shipmentHeaderData.length > 0
                ? tmsVehicleModel
                    .shipmentHeaderData.first.tmsShipmentDestinationList
                : null
            : null,
        markerOriginIcon: "assets/angkut/track_destination.png",
        markerOriginIconSize: 100,
        markerDestinationIcon: "assets/angkut/flag_destination.png",
        markerDestinationIconSize: 100,
      ),
      fromDate: DateTime.now().add(Duration(hours: -2)),
    );
  },
  RouteName.maps: (BuildContext context) {
    return maps.Presenter(
      view: maps.AngkutView(onTapDetailOrder: (shipment) {
        if (shipment.tmsShipmentDestinationList.length > 1) {
          System.data.routes
              .pushNamed(context, RouteName.orderDetail, arguments: {
            ParamName.Shipment: shipment,
            ParamName.ShowShipmentNumber:
                shipment.shipmentStatusId == 1 || shipment.shipmentStatusId == 2
                    ? false
                    : true,
          });
        } else {
          System.data.routes
              .pushNamed(context, RouteName.orderDetail, arguments: {
            ParamName.Shipment: shipment,
            ParamName.ShowShipmentNumber:
                shipment.shipmentStatusId == 1 || shipment.shipmentStatusId == 2
                    ? false
                    : true,
          });
        }
      }, onTapSearchHistoery: (tmsVehicleModel, fromdate, toDate) {
        System.data.routes.pushNamed(context, RouteName.historyMap, arguments: {
          ParamName.TmsVehicleModel: tmsVehicleModel,
          ParamName.FromDate: fromdate,
          ParamName.ToDate: toDate,
        });
      }),
      userId:
          System.data.getLocal<LocalData>().user.transporterIdVts ?? 65606274,
      token: System.data.getLocal<LocalData>().user.transporterTokenVts ??
          'dc5c9c3b2299c8ed1b7ba31b74936073',
    );
  },
  RouteName.absent: (BuildContext context) => absent.Presenter(
        view: absent.AngkutView(),
        onTapAbsentItem: (data) {
          System.data.routes.pushNamed(context, RouteName.absentDetail,
              arguments: {ParamName.TmsVehicleCheckDocument: data});
        },
      ),
  RouteName.absentDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return absentDetail.Presenter(
      tmsVehicleCheckDocument: arg[ParamName.TmsVehicleCheckDocument],
    );
  },
  RouteName.uangJalan: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return uangJalan.Presenter(
      // view: uangJalan.TransporterView(),
      showList: false,
      showSearchSipment: false,
      shipmentNumber:
          (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
              .shipmentNumber,
      onSubmit: (angkutUangJalan) {
        System.data.routes.pushNamed(
          context,
          RouteName.detailuangJalan,
          arguments: {
            ParamName.AngkutBudgetOperationModel: angkutUangJalan,
          },
        );
      },
      onTapSearchShipment: (uangJalanViewMOdel) {
        System.data.routes
            .pushNamed(context, RouteName.listShipmentForUangJalan, arguments: {
          ParamName.UangJalanViewModel: uangJalanViewMOdel,
        });
      },
      onSuccessAddbalance: (uangJalan) {
        System.data.routes.pop(context);
      },
    );
  },
  RouteName.detailuangJalan: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailuangJalan.Presenter(
      tripAllowanceSummary: arg[ParamName.AngkutBudgetOperationModel],
    );
  },
  RouteName.profile: (BuildContext context) => profile.Presenter(
        view: profile.TransporterView(),
      ),
  RouteName.bill: (BuildContext context) => bill.Presenter(
        onTapIncoming: () {
          System.data.routes.pushNamed(context, RouteName.incomeSumary);
        },
        onTappayment: () {
          System.data.routes.pushNamed(context, RouteName.outComeSummary);
        },
      ),
  RouteName.setting: (BuildContext context) => setting.Presenter(
        view: setting.TransporterView(language: () {
          System.data.routes.pushNamed(context, RouteName.changeLanguage);
        }, changePassword: () {
          System.data.routes.pushNamed(context, RouteName.changePassword);
        }, logout: () {
          System.data.sharedPreferences.setString(PrefsKey.user, null);
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.login, "");
        }),
      ),
  RouteName.changeLanguage: (BuildContext context) => setting.Presenter(
        view: setting.LanguageView(
          onTapId: () {
            System.data.resource = ResourceUtil.ind().peopleTransportId();
            System.commit();
          },
          onTapEn: () {
            System.data.resource = ResourceUtil.ind().peopleTransportEn();
            System.commit();
          },
        ),
      ),
  RouteName.changePassword: (BuildContext comtext) => password.Presenter(
        view: password.AngkutView(),
        passwordState: password.PasswordState.ChangePassword,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user =
              TransporterModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
        },
      ),
  RouteName.track: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel shipment = arg[ParamName.AngkutShipmentModel];
    return track.Presenter(
      shipmentNumber: shipment.shipmentNumber,
      showButtonMap: shipment.shipmentStatusId <= 2 ||
              shipment.shipmentStatusId == 12 ||
              shipment.shipmentStatusId == 10
          ? false
          : true,
      onTapLiveMap: () {
        System.data.routes.pushNamed(
          context,
          RouteName.liveMap,
          arguments: {
            ParamName.AngkutShipmentModel: shipment,
          },
        );
      },
      onTapDetailShipment: () {
        System.data.routes
            .pushNamed(context, RouteName.orderDetail, arguments: {
          ParamName.Shipment: shipment,
          ParamName.ShowShipmentNumber:
              shipment.shipmentStatusId == 1 || shipment.shipmentStatusId == 2
                  ? false
                  : true,
        });
      },
      // data: shipment
      //     .tmsShipmentDestinationList.first.tmsShipmentDetailHistoryList,
      data: shipment.tmsShipmentHistoryList,
    );
  },
  RouteName.notification: (BuildContext context) => notification.Presenter(
        view: notification.AngkutView(onTapNotif: (shipment) {
          System.data.routes
              .pushNamed(context, RouteName.orderDetail, arguments: {
            ParamName.Shipment: shipment,
            ParamName.ShowShipmentNumber:
                shipment.shipmentStatusId == 1 || shipment.shipmentStatusId == 2
                    ? false
                    : true,
          });
        }),
        loadingIndicatorDecoration: (controller) {
          return DecorationComponent.circularLOadingIndicator(
              controller: controller);
        },
      ),
  RouteName.listShipmentForUangJalan: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    uangJalan.ViewModel uangJalanViewModel = arg[ParamName.UangJalanViewModel];
    return history.Presenter(
      tabs: [
        TabName.Process,
        TabName.Finish,
      ],
      onSelected: (vm, shipment) {
        uangJalanViewModel.shimenpNumber.text = shipment.shipmentNumber;
        System.data.routes.pop(context);
      },
    );
  },
  RouteName.historyMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return historyMap.Presenter(
      vehicleIdVts:
          (arg[ParamName.TmsVehicleModel] as TmsVehicleModel).vtsVehicleId,
      markerIconType: (arg[ParamName.TmsVehicleModel] as TmsVehicleModel)
                  .vehicleTypeIconUrlTop !=
              null
          ? MarkerIconType.Network
          : null,
      markerSize: (arg[ParamName.TmsVehicleModel] as TmsVehicleModel)
                  .vehicleTypeIconTopSize !=
              null
          ? (arg[ParamName.TmsVehicleModel] as TmsVehicleModel)
              .vehicleTypeIconTopSize
          : null,
      markerOnEngineOn: (arg[ParamName.TmsVehicleModel] as TmsVehicleModel)
          .vehicleTypeIconUrlTop,
      markerOnEngineOff: (arg[ParamName.TmsVehicleModel] as TmsVehicleModel)
          .vehicleTypeIconUrlTop,
      fromDate: arg[ParamName.FromDate],
      toDate: arg[ParamName.ToDate],
    );
  },
  RouteName.verification: (BuildContext context) => verification.Presenter(
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
        view: password.AngkutView(),
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user =
              TransporterModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        },
      ),
  RouteName.detailEmergencyDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return deliveryEmergencyDetail.Presenter(
      emergencyModel: arg[ParamName.ShipmentDeliveryEmergencyDetail],
      onTapProfile: (driverModel) {
        System.data.routes
            .pushNamed(context, RouteName.driverProfile, arguments: {
          ParamName.ProfileModel: ProfileModel(
            address: "",
            email: driverModel.email,
            name: driverModel.driverName,
            phone: driverModel.phoneNumber,
            registeredDate: driverModel.insertedDate,
            urlImmage: driverModel.urlProfileImage,
          )
        });
      },
    );
  },
  RouteName.driverProfile: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return driverProfile.Presenter(
      view: driverProfile.DriverView(),
      profileModel: arg[ParamName.ProfileModel],
    );
  },
  RouteName.dos: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return dos.Presenter(
      view: dos.ViewOnly(),
      tmsShipmentId: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
          .tmsShipmentId,
    );
  },
  RouteName.loadingShipmentItemDescription: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel angkutShipmentModel =
        arg[ParamName.AngkutShipmentModel];
    return shipmentItemDescription.Presenter(
      token: System.data.global.token,
      tmsShipmentId: angkutShipmentModel.tmsShipmentId,
      destinationId: arg[ParamName.DestinationId],
      loadingDecoration: (controller) {
        return DecorationComponent.circularLOadingIndicator(
            controller: controller);
      },
      onTapViewPOD: (tmsDeliveryPodModel) {
        System.data.routes
            .pushNamed(context, RouteName.readOnlyPod, arguments: {
          ParamName.TmsShipmentPodModel: tmsDeliveryPodModel,
        });
      },
    );
  },
  RouteName.unLoadingShipmentItemDescription: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel angkutShipmentModel =
        arg[ParamName.AngkutShipmentModel];
    return shipmentItemDescription.Presenter(
      token: System.data.global.token,
      tmsShipmentId: angkutShipmentModel.tmsShipmentId,
      destinationId: arg[ParamName.DestinationId],
      loadingDecoration: (controller) {
        return DecorationComponent.circularLOadingIndicator(
            controller: controller);
      },
      view: shipmentItemDescription.UnloadingView(),
      onTapViewPOD: (tmsDeliveryPodModel) {
        System.data.routes
            .pushNamed(context, RouteName.readOnlyPod, arguments: {
          ParamName.TmsShipmentPodModel: tmsDeliveryPodModel,
        });
      },
    );
  },
  RouteName.readOnlyPod: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsDeliveryPodModel deliveryPodModel = arg[ParamName.TmsShipmentPodModel];
    return pod.Presenter(
      view: pod.ReadOnlyView(
        deliveryPodModel: deliveryPodModel,
      ),
    );
  },
  RouteName.incomeList: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return billList.Presenter(
      invoice: arg[ParamName.Invoices],
      firstDate: arg[ParamName.FirstDate],
      lastDate: arg[ParamName.LastDate],
      onTapBill: (inoice) {
        System.data.routes.pushNamed(context, RouteName.outComeReport);
      },
    );
  },
  RouteName.outComeList: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return billList.Presenter(
      invoice: arg[ParamName.Invoices],
      firstDate: arg[ParamName.FirstDate],
      lastDate: arg[ParamName.LastDate],
      view: billList.OutCome(),
      onTapBill: (invoice) {
        System.data.routes
            .pushNamed(context, RouteName.outComeReport, arguments: {
          ParamName.Invoice: invoice,
        });
      },
    );
  },
  RouteName.incomeSumary: (BuildContext context) => billSummary.Presenter(
        onTapGotoList: (invoices, firstDate, lastDate) {
          System.data.routes
              .pushNamed(context, RouteName.incomeList, arguments: {
            ParamName.Invoices: invoices,
            ParamName.FirstDate: firstDate,
            ParamName.LastDate: lastDate,
          });
        },
      ),
  RouteName.outComeSummary: (BuildContext context) => billSummary.Presenter(
        view: billSummary.Payment(),
        onTapGotoList: (invoices, firstDate, lastDate) {
          System.data.routes
              .pushNamed(context, RouteName.outComeList, arguments: {
            ParamName.Invoices: invoices,
            ParamName.FirstDate: firstDate,
            ParamName.LastDate: lastDate,
          });
        },
      ),
  RouteName.incomeReport: (BuildContext context) => billReport.Presenter(),
  RouteName.outComeReport: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return billReport.Presenter(
      onTapShipmentDetail: (shipment) {
        System.data.routes
            .pushNamed(context, RouteName.orderDetail, arguments: {
          ParamName.Shipment: shipment,
          ParamName.ShowShipmentNumber:
              shipment.shipmentStatusId == 1 || shipment.shipmentStatusId == 2
                  ? false
                  : true,
        });
      },
      invoice: arg[ParamName.Invoice],
      view: billReport.OutcomeView(),
    );
  }
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
