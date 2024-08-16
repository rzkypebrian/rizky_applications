import 'dart:convert';

import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/AttendanceModel.dart';
import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/MarkerUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NavigationUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/tms/aDriver/localData.dart';
import 'package:enerren/app/tms/module/checkUser/main.dart' as checkUser;
import 'package:enerren/app/tms/module/login/main.dart' as login;
import 'package:enerren/app/tms/aDriver/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/module/notification/main.dart' as notification;
import 'package:enerren/app/tms/aDriver/module/history/main.dart' as history;
import 'package:enerren/app/tms/module/detailHistory/main.dart'
    as detailHistory;
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
import 'package:enerren/module/maintenaceMenu/main.dart' as maintenance;
import 'package:enerren/module/maintenanceSchedule/main.dart'
    as maintenanceListVehicle;
import 'package:enerren/module/inventoryActivitiesMenu/main.dart'
    as inventoryActivity;
import 'package:enerren/module/inventoryProcess/main.dart' as inventoryProcess;
import 'package:enerren/app/tms/aDriver/module/mutasiStock/main.dart'
    as inventoryMutasiStock;
import 'package:enerren/module/historyStock/main.dart' as historyStock;
import 'package:enerren/module/inventoryDetailHistoryStock/main.dart'
    as detailHistoryStock;
import 'package:enerren/module/pokectMoney/main.dart' as pokectMoney;
import 'package:enerren/component/HeroComponent.dart' as heroComponent;
import 'package:enerren/app/tms/aDriver/module/liveMap/main.dart'
    as shipmentMap;
import 'package:enerren/module/doFinish/main.dart' as doFinish;
import 'package:enerren/module/do/main.dart' as doPickup;
import 'package:enerren/app/tms/aDriver/module/podPickup/main.dart' as podPicUp;
import 'package:enerren/app/tms/aDriver/module/podFinish/main.dart'
    as podFinish;
import 'package:enerren/module/attendance/main.dart' as attendance;
import 'package:enerren/module/tripAllowance/main.dart' as uangJalan;
import 'package:enerren/module/shipmentItemDescription/main.dart'
    as shipmentItemDescription;
import 'package:enerren/module/deleveryEmergencyDetail/main.dart'
    as deliveryEmergencyDetail;

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
  static const String maintenance = "maintenance";
  static const String maintenanceActivities = "maintenanceActivities";
  static const String maintenanceListVehicle = "maintenanceListVehicle";
  static const String stockProcess = "stockProcess";
  static const String inventoryMutasiStock = "inventoryMutasiStock";
  static const String historyStock = "historyStock";
  static const String detailHistoryStock = "detailHistoryStock";
  static const String heroComponent = "heroComponent";
  static const String pocketMoney = "pocketMoney";
  static const String shipmentMap = "shipmentMap";
  static const String doFinish = "doFinish";
  static const String attendance = "attendance";
  static const String atendaceReadOnly = "atendaceReadOnly";
  static const String confirmAttendance = "confirmAttendance";
  static const String uangJalan = "uangJalan";
  static const String doPickup = "doPickup";
  static const String podPickup = "podPickup";
  static const String podFinish = "podFinish";
  static const String unloadingShipmentItemDescription =
      "unloadingShipmentItemDescription";
  static const String loadingShipmentItemDescription =
      "loadingShipmentItemDescription";
  static const detailEmergencyDetail = "detailEmergencyDetail";
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
  TagImage,
  DestinationListId,
  MapViewModel,
  Attendance,
  TripAllowanceSummary,
  ShipmentDeliveryEmergencyDetail,
}

//definisikan initial root name
String initialEouteName = RouteName.splashScreen;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.maintenance: (BuildContext context) => maintenance.Presenter(
        view: maintenance.MaintenanceMenuView(
          onTapWorkOrder: () => System.data.routes
              .pushNamed(context, RouteName.maintenanceActivities),
          onTapMaintenanceItem: () => System.data.routes.pushNamed(
              context, RouteName.maintenanceListVehicle,
              arguments: {ParamName.MaintenanceFinish: true}),
          onTapHistory: () =>
              System.data.routes.pushNamed(context, RouteName.historyStock),
        ),
      ),

  RouteName.maintenanceListVehicle: (BuildContext context) {
    return maintenanceListVehicle.Presenter();
  },

  RouteName.maintenanceActivities: (BuildContext context) =>
      maintenance.Presenter(
        view: inventoryActivity.InventoryActivityView(
          onTapBuyStock: () => System.data.routes.pushNamed(
              context, RouteName.stockProcess,
              arguments: {ParamName.StockProcess: 1}),
          onTapTakeStock: () => System.data.routes.pushNamed(
              context, RouteName.stockProcess,
              arguments: {ParamName.StockProcess: 2}),
        ),
      ),

  RouteName.stockProcess: (BuildContext context) {
    return inventoryProcess.Presenter(
      maintenanceModelSelector: () async {
        MaintenanceScheduleModel mm = new MaintenanceScheduleModel();
        await System.data.routes.push(
          context,
          maintenanceListVehicle.Presenter(
            tabs: [
              MaintenanceTab.WillOverdue,
              MaintenanceTab.Overdue,
            ],
            onSelected: (data) {
              mm = data;
              System.data.routes.pop(context);
            },
          ),
        );
        return mm;
      },
      // typeProcessStock: arg[ParamName.StockProcess],
    );
  },
  RouteName.inventoryMutasiStock: (BuildContext context) =>
      inventoryMutasiStock.Presenter(
        view: inventoryMutasiStock.DriverMutasiStock(),
      ),
  RouteName.historyStock: (BuildContext context) => historyStock.Presenter(
        onTapHeroImage: (n, p) => System.data.routes.pushNamed(
            context, RouteName.heroComponent,
            arguments: {ParamName.TagImage: n, ParamName.PathImage: p}),
        onTapDetail: (v) => System.data.routes.pushNamed(
            context, RouteName.detailHistoryStock,
            arguments: {ParamName.HistoryStock: v}),
      ),
  RouteName.detailHistoryStock: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailHistoryStock.Presenter(
        onTapHeroImage: (n, p) => System.data.routes.pushNamed(
            context, RouteName.heroComponent,
            arguments: {ParamName.TagImage: n, ParamName.PathImage: p}),
        historyStockModel: arg[ParamName.HistoryStock]);
  },
  RouteName.heroComponent: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return heroComponent.HeroComponent(
      pathImage: arg[ParamName.PathImage],
      tagImage: arg[ParamName.TagImage],
    );
  },

  RouteName.pocketMoney: (BuildContext context) => pokectMoney.Presenter(
        onTapHeroImage: (n, p) => System.data.routes.pushNamed(
            context, RouteName.heroComponent,
            arguments: {ParamName.TagImage: n, ParamName.PathImage: p}),
        onTapDetail: (v) => System.data.routes.pushNamed(
            context, RouteName.detailHistoryStock,
            arguments: {ParamName.HistoryStock: v}),
      ),

  //end route new fitur

  RouteName.splashScreen: (BuildContext context) => splassScreen.Presenter(
        view: splassScreen.DriverView(),
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
          ..showCopyrigth = false
          ..logoAssets = System.data.global.companyHorizontalLogoAssets
          ..logoWidth = 150,
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
      view: login.TmsView()
        ..showTmsCopyright = false
        ..logoAssets = System.data.global.companyHorizontalLogoAssets
        ..logoWidth = 150,
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
        view: dashboard.DriverView(history: () {
          System.data.routes.pushNamed(context, RouteName.history);
        }, setting: () {
          System.data.routes.pushNamed(context, RouteName.setting);
        }, emergency: (shipment) {
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
        }, score: () {
          System.data.routes.pushNamed(
            context,
            RouteName.driverScore,
          );
        }, liveMap: (shipment) {
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
        }, contact: () {
          System.data.routes.pushNamed(context, RouteName.contactService);
        }, onTapNotification: () {
          System.data.routes.pushNamed(context, RouteName.notification);
        }, onTapPendingData: () {
          System.data.routes.pushNamed(context, RouteName.pendingData);
        }, gotoAttendance: () {
          System.data.routes.pushNamed(context, RouteName.attendance);
        })
          ..companyLogoAssets = System.data.global.companyHorizontalLogoAssets,
      ),
  RouteName.notification: (BuildContext context) => notification.Presenter(),

  RouteName.history: (BuildContext context) => history.Presenter(
        onSelected: (shipment) {
          //--mode berurut sesuai no urut tujuan--//
          System.data.routes
              .pushNamed(context, RouteName.shipmentMap, arguments: {
            ParamName.Shipment: shipment,
          });
          //--mode bebas pilih shipment mana yang mau di pod--//
          // if (shipment.tmsShipmentDestinationList.length > 1) {
          //   System.data.routes
          //       .pushNamed(context, RouteName.singgleHistory, arguments: {
          //     ParamName.Shipment: shipment,
          //   });
          // } else {
          // System.data.routes
          //     .pushNamed(context, RouteName.detailHistory, arguments: {
          //   ParamName.Shipment: shipment,
          // });
          // }
          //--mode bebas
          // System.data.routes
          //     .pushNamed(context, RouteName.detailHistory, arguments: {
          //   ParamName.Shipment: shipment,
          // });
          //--mode
        },
      ),
  RouteName.detailHistory: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return detailHistory.Presenter(
      data: shipment,
      onTapDriver: (driverData, emergencyData) {
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
      onTapFinish: (shipment) {
        System.data.routes.pushNamed(context, RouteName.pod, arguments: {
          ParamName.Shipment: arg[ParamName.Shipment],
          ParamName.ShipnentStcock: arg[ParamName.ShipnentStcock],
        });
      },
      onTapTrack: (shipment) {
        System.data.routes.pushNamed(context, RouteName.track, arguments: {
          ParamName.Shipment: shipment,
        });
      },
      onTapLoadingDetail: (shipment, id) {
        System.data.routes.pushNamed(
            context, RouteName.loadingShipmentItemDescription,
            arguments: {
              ParamName.Shipment: shipment,
              ParamName.DestinationListId: id,
            });
      },
      onTapUnloadingDetail: (shipment, id) {
        System.data.routes.pushNamed(
            context, RouteName.unloadingShipmentItemDescription,
            arguments: {
              ParamName.Shipment: shipment,
              ParamName.DestinationListId: id,
            });
      },
      onTapPendingPod: (shipment) {
        System.data.routes.pushNamed(context, RouteName.pendingData);
      },
      onTapViewTripAllowance: (tripAllowanceModel) {
        System.data.routes.pushNamed(
          context,
          RouteName.uangJalan,
          arguments: {
            ParamName.TripAllowanceSummary: tripAllowanceModel,
          },
        );
      },
      showButtonAddTripAllowanceBalance: false,
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
              context,
              RouteName.singgleHistoryEmergency,
              arguments: {
                ParamName.Shipment: shipment,
              },
            );
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
        System.data.routes.pushNamed(
          context,
          RouteName.emergency,
          arguments: {
            ParamName.Shipment: shipment,
          },
        );
      },
    );
  },
  RouteName.emergency: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return emergency.Presenter(
      view: emergency.DriverView(
        shipment: shipment,
        onSuccess: () {
          System.data.routes.pop(context);
        },
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
      fromDate: DateTime.now().add(
        Duration(days: -1),
      ),
    );
  },
  RouteName.pod: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    //--single page pod//--
    // return pod.Presenter(
    //   view: pod.TmsDriverView(
    //     shipment: arg[ParamName.Shipment],
    //     onSuccess: (shipment) {
    //       System.data.routes
    //           .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
    //     },
    //   ),
    // );
    //--single page pod//--

    //--wizard pod--//
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return pod.ProductOnlyPresenter(
      destinationId: shipment.tmsShipmentDestinationList.first.detailshipmentId,
      onSubmit: (reciverPhoto) {
        System.data.routes.routeHistory.add(RouteHistory(
          routeName: "receiver",
          needConfirm: false,
          confirmMessage: "",
          onBack: null,
        ));
        NavigationUtil.navTo(
          context,
          pod.ReceiverOnlyPresenter(
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
                      //--mode bebas--//
                      System.data.routes.pushNamedAndRemoveUntil(
                          context, RouteName.dashboard, "");
                      //--mode bebas--//
                      //--mode terurut--//
                      System.data.routes.pushNamedAndRemoveUntil(
                        context,
                        RouteName.shipmentMap,
                        RouteName.dashboard,
                        arguments: {
                          ParamName.Shipment: shipment,
                        },
                      );
                      //--mode terurut--//
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
    //--wizard pod--//
  },
  RouteName.podPickup: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    shipmentMap.ViewModeliveMap liveMapViewModel =
        (arg[ParamName.MapViewModel] as shipmentMap.ViewModeliveMap);
    // return podPicUp.Presenter(
    //   view: podPicUp.PickUpView(
    //     shipment: arg[ParamName.AngkutShipmentModel],
    //     onSuccessSubmit: (am) {
    //       (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap)
    //           .angkutShipmentModel = am;
    //       (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap).commit();
    //       System.data.routes.pop(context);
    //       System.data.routes.pop(context);
    //     },
    //   ),
    // );
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return pod.ProductOnlyPresenter(
      destinationId: shipment.tmsShipmentDestinationList.first.detailshipmentId,
      isPod: false,
      imageQuality: null,
      title: null,
      loadUploadedImage: true,
      onSubmit: (viewModel) {
        System.data.routes.routeHistory.add(
          RouteHistory(
            routeName: "receiver",
            needConfirm: false,
            confirmMessage: "",
            onBack: null,
          ),
        );
        NavigationUtil.navTo(
          context,
          pod.ReceiverOnlyPresenter(
            destinationId:
                shipment.tmsShipmentDestinationList.first.detailshipmentId,
            isPod: false,
            loadUploadedImage: true,
            senderLabel: System.data.resource.sender,
            senderNameLabel: System.data.resource.senderName,
            viewModel: viewModel,
            onSubmit: (viewModel) {
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
                  view: podPicUp.PickUpView(
                    shipment: arg[ParamName.Shipment],
                    onSuccessSubmit: (am) {
                      // (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap)
                      //     .angkutShipmentModel = am;
                      // (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap)
                      //     .commit();
                      liveMapViewModel.tmsShipmentModel = am;
                      liveMapViewModel.commit();
                      System.data.routes.pop(context);
                      System.data.routes.pop(context);
                      System.data.routes.pop(context);
                      System.data.routes.pop(context);
                    },
                  ),
                  viewModel: viewModel,
                ),
              );
            },
          ),
        );
      },
    );
  },
  RouteName.podFinish: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    shipmentMap.ViewModeliveMap liveMapViewModel =
        (arg[ParamName.MapViewModel] as shipmentMap.ViewModeliveMap);

    // return podFinish.Presenter(
    //   view: podFinish.FinishView(
    //     shipment: arg[ParamName.AngkutShipmentModel],
    //     idDestination: arg[ParamName.DestinationListId],
    //     onSuccessSubmit: (v) {
    //       (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap)
    //           .angkutShipmentModel
    //           .shipmentStatusId = 10;
    //       (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap).commit();
    //       System.data.routes.pushNamedAndRemoveUntil(
    //         context,
    //         RouteName.liveMap,
    //         RouteName.dashboard,
    //         arguments: {
    //           ParamName.AngkutShipmentModel: v,
    //         },
    //       );
    //       System.data.routes.pop(context);
    //     },
    //   ),
    // );
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return pod.ProductOnlyPresenter(
      destinationId: shipment
          .tmsShipmentDestinationList[(arg[ParamName.DestinationListId]) as int]
          .detailshipmentId,
      imageQuality: 20,
      isPod: true,
      loadUploadedImage: false,
      onSubmit: (viewModel) {
        System.data.routes.routeHistory.add(RouteHistory(
          routeName: "receiver",
          needConfirm: false,
          confirmMessage: "",
          onBack: null,
        ));
        NavigationUtil.navTo(
          context,
          pod.ReceiverOnlyPresenter(
            destinationId: shipment
                .tmsShipmentDestinationList[
                    (arg[ParamName.DestinationListId]) as int]
                .detailshipmentId,
            isPod: true,
            loadUploadedImage: false,
            imageQuality: 20,
            viewModel: viewModel,
            onSubmit: (viewModel) {
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
                  view: podFinish.FinishView(
                    shipment: arg[ParamName.Shipment],
                    idDestination: arg[ParamName.DestinationListId],
                    // isFinish: arg[ParamName.IsPodFinish],
                    onSuccessSubmit: (am) {
                      //-- jika ingin kembali ke peta
                      // System.data.routes.pushNamedAndRemoveUntil(
                      //     context, RouteName.shipmentMap, RouteName.dashboard,
                      //     arguments: {
                      //       ParamName.Shipment: arg[ParamName.Shipment]
                      //     });
                      //-- jika ingin kembali ke peta end
                      // System.data.routes.pushNamedAndRemoveUntil(
                      //     context, RouteName.dashboard, "");
                      //dengan pop methode
                      liveMapViewModel.tmsShipmentModel = am;
                      liveMapViewModel.commit();
                      System.data.routes.pop(context);
                      System.data.routes.pop(context);
                      System.data.routes.pop(context);
                      System.data.routes.pop(context);
                    },
                  ),
                  viewModel: viewModel,
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
  RouteName.shipmentMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel shipment = (arg[ParamName.Shipment] as TmsShipmentModel);
    return shipmentMap.Presenter(
      fromDate: DateTime.now().add(Duration(hours: -2)),
      vehicleId: shipment.tmsShipmentDestinationList.first.vehicleIdVts,
      vehicleIconTopUrl:
          shipment.tmsShipmentDestinationList.first.vehicleTypeIconUrl,
      vehicleIconTopSize:
          shipment.tmsShipmentDestinationList.first.vehicleTypeIconTopSize ??
              150,
      destination: MarkerUtil.readPointDestination(
        destinations: shipment.tmsShipmentDestinationList,
        // markerOriginIcon: "assets/angkut/track_destination.png",
        markerOriginIconSize: 100,
        // markerDestinationIcon: "assets/angkut/flag_destination.png",
        markerDestinationIconSize: 100,
        showDestinationNumber: true,
      ),
      folowTheVehicle: true,
      usingLastPositionOnEmpty: true,
      showHistoryLine: false,
      view: shipmentMap.DriverView(
          headerUnloadingStatusCode: "DELV",
          destinationUnloadingStatusCode: "DELV",
          tmsShipmentModel: shipment,
          onTapPickup: (mapViewModel) {
            System.data.routes.pushNamed(
              context,
              RouteName.doPickup,
              arguments: {
                ParamName.Shipment: mapViewModel.tmsShipmentModel,
                ParamName.MapViewModel: mapViewModel,
              },
            );
          },
          onTapFinish: (mapViewModel, idDestination) {
            System.data.routes
                .pushNamed(context, RouteName.doFinish, arguments: {
              ParamName.MapViewModel: mapViewModel,
              ParamName.Shipment: mapViewModel.tmsShipmentModel,
              ParamName.DestinationListId: idDestination,
            });
          },
          onTapStart: () {},
          onTapDetail: (mapViewMOdel) {
            System.data.routes
                .pushNamed(context, RouteName.detailHistory, arguments: {
              ParamName.Shipment: shipment,
            });
          },
          onTapEmergency: (mapViewMOdel) {
            var single = TmsShipmentModel.fromJson(
              mapViewMOdel.tmsShipmentModel.toJson(),
              // childReader: childReader,
            );
            single.tmsShipmentDestinationList = <TmsShipmentDestinationModel>[
              mapViewMOdel.tmsShipmentModel.tmsShipmentDestinationList[
                  mapViewMOdel.pageController.page.toInt()]
            ];
            System.data.routes
                .pushNamed(context, RouteName.emergency, arguments: {
              ParamName.Shipment: mapViewMOdel.tmsShipmentModel,
            });
          }),
    );
  },
  RouteName.doPickup: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return doPickup.Presenter(
      tmsShipmentId:
          (arg[ParamName.Shipment] as TmsShipmentModel).tmsShipmentId,
      detailShipmentId: (arg[ParamName.Shipment] as TmsShipmentModel)
          .tmsShipmentDestinationList
          .first
          .detailshipmentId,
      isPod: false,
      user: "Driver ${System.data.getLocal<LocalData>().user.driverName}",
      destinations: (arg[ParamName.Shipment] as TmsShipmentModel)
          .tmsShipmentDestinationList,
      onSubmitSuccess: () {
        System.data.routes.pushNamed(
          context,
          RouteName.podPickup,
          arguments: {
            ParamName.Shipment: arg[ParamName.Shipment],
            ParamName.MapViewModel: arg[ParamName.MapViewModel]
          },
        );
      },
    );
  },
  RouteName.doFinish: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return doFinish.Presenter(
        view: doFinish.DoFinishView(),
        tmsShipmentId: (arg[ParamName.Shipment]).tmsShipmentId,
        detailShipmentId: (arg[ParamName.Shipment])
            .tmsShipmentDestinationList[
                (arg[ParamName.DestinationListId] as int)]
            .detailshipmentId,
        // detailShipmentId: 0,
        isPod: true,
        user: System.data.getLocal<LocalData>().user.driverName,
        // view: doFinish.AngkutView(),
        onSubmitSuccess: () {
          System.data.routes
              .pushNamed(context, RouteName.podFinish, arguments: {
            ParamName.Shipment: arg[ParamName.Shipment],
            ParamName.MapViewModel: arg[ParamName.MapViewModel],
            ParamName.DestinationListId: arg[ParamName.DestinationListId]
          });
        });
  },
  RouteName.attendance: (BuildContext context) {
    return attendance.Presenter(
      attendanceModel: new AttendanceModel(
          driverId: System.data.getLocal<LocalData>().user.driverId,
          driverName: System.data.getLocal<LocalData>().user.driverName,
          vehicleNumber: System.data.getLocal<LocalData>().user.driverCode,
          vehicleIdVts: System.data.getLocal<LocalData>().user.vehicleIdVts),
      onSubmited: (am) {
        System.data.routes.pushAndReplaceName(
          context,
          RouteName.atendaceReadOnly,
          arguments: {ParamName.Attendance: am},
        );
      },
    );
  },
  RouteName.atendaceReadOnly: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return attendance.Presenter(
      view: attendance.ReadOnlyView(),
      attendanceModel: arg[ParamName.Attendance],
    );
  },
  RouteName.uangJalan: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return uangJalan.Presenter(
      tripAllowanceSummary: arg[ParamName.TripAllowanceSummary],
    );
  },
  RouteName.loadingShipmentItemDescription: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel angkutShipmentModel = arg[ParamName.Shipment];
    return shipmentItemDescription.Presenter(
      token: System.data.global.token,
      tmsShipmentId: angkutShipmentModel.tmsShipmentId,
      destinationId: arg[ParamName.DestinationListId],
      loadingDecoration: (controller) {
        return DecorationComponent.circularProgressDecoration(
            controller: controller);
      },
      onTapViewPOD: (tmsDeliveryPodModel) {
        System.data.routes
            .pushNamed(context, RouteName.podViewOnly, arguments: {
          ParamName.TmsShipmentPod: tmsDeliveryPodModel,
        });
      },
    );
  },
  RouteName.unloadingShipmentItemDescription: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel shipment = arg[ParamName.Shipment];
    return shipmentItemDescription.Presenter(
      tmsShipmentId: shipment.tmsShipmentId,
      destinationId: arg[ParamName.DestinationListId],
      loadingDecoration: (controller) {
        return DecorationComponent.circularProgressDecoration(
            controller: controller);
      },
      view: shipmentItemDescription.UnloadingView(),
      token: System.data.global.token,
      onTapViewPOD: (tmsDeliveryPodModel) {
        System.data.routes
            .pushNamed(context, RouteName.podViewOnly, arguments: {
          ParamName.TmsShipmentPod: tmsDeliveryPodModel,
        });
      },
    );
  },
  RouteName.detailEmergencyDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return deliveryEmergencyDetail.Presenter(
      emergencyModel: arg[ParamName.ShipmentDeliveryEmergencyDetail],
      onTapProfile: (driverModel) {
        // System.data.routes.pushNamed(
        //   context,
        //   RouteName.driverProfile,
        //   arguments: {
        //     ParamName.ProfileModel: ProfileModel(
        //       address: "",
        //       email: driverModel.email,
        //       name: driverModel.driverName,
        //       phone: driverModel.phoneNumber,
        //       registeredDate: driverModel.insertedDate,
        //       urlImmage: driverModel.urlProfileImage,
        //     )
        //   },
        // );
      },
    );
  },
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
