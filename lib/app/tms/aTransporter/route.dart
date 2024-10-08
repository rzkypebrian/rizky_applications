import 'dart:convert';

import 'package:enerren/app/tms/aTransporter/localData.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/model/TransporterModel.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/module/attendance/confirnAtendanceView.dart';
import 'package:enerren/module/attendance/readOnlyView.dart';
import 'package:enerren/util/EnumUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/tms/aTransporter/module/splashScreen/main.dart'
    as splasScreen;
import 'package:enerren/app/tms/module/checkUser/main.dart' as checkUser;
import 'package:enerren/app/tms/module/login/main.dart' as login;
import 'package:enerren/app/tms/module/verification/main.dart' as verification;
import 'package:enerren/app/tms/module/password/main.dart' as password;
import 'package:enerren/app/tms/aTransporter/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/module/setting/main.dart' as setting;
import 'package:enerren/app/tms/aDriver/module/history/main.dart' as history;
import 'package:enerren/app/tms/aTransporter/module/profile/main.dart'
    as profile;
import 'package:enerren/app/tms/aTransporter/module/detailHistory/main.dart'
    as detailHistory;
import 'package:enerren/module/track/main.dart' as track;
import 'package:enerren/app/tms/module/liveMap/main.dart' as liveMap;
import 'package:enerren/module/contactService/main.dart' as contactService;
import 'package:enerren/module/listVehicle/main.dart' as listVehicle;
import 'package:enerren/app/tms/module/vehicleDetail/main.dart'
    as detailVehicle;
import 'package:enerren/app/tms/aTransporter/module/driverDetail/main.dart'
    as detailDriver;
import 'package:enerren/app/tms/module/map/main.dart' as maps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:enerren/module/notification/main.dart' as notification;
import 'package:enerren/app/tms/aDriver/module/pod/main.dart' as pod;
import 'package:enerren/module/historyMap/main.dart' as historyMap;
import 'package:enerren/module/about/main.dart' as about;
import 'package:enerren/module/maintenaceMenu/main.dart' as maintenance;
import 'package:enerren/module/maintenanceItem/main.dart' as maintenanceItem;
import 'package:enerren/module/maintenanceItemAdd/main.dart'
    as maintenanceItemAdd;
import 'package:enerren/module/maintenanceSchedule/main.dart'
    as maintenanceSchedule;
import 'package:enerren/module/maintenanceDetail/main.dart'
    as maintenanceDetail;
import 'package:enerren/module/maintenanceAddWorkOrder/main.dart'
    as maintenanceAddWorkOrder;
import 'package:enerren/module/maintenanceHistoryWorkOrder/main.dart'
    as maintenanceWorkOrderHistory;
// import 'package:enerren/module/maintenanceDetailWorkOrder/main.dart'
import 'package:enerren/app/tms/aPic/module/detailWorkOrder/main.dart'
    as detailWorkOrder;
// import 'package:enerren/module/maintenanceDetailWorkOrderPerActivity/main.dart'
//     as maintenanceDetailWorkOrderPerActivity;
import 'package:enerren/app/tms/aPic/module/startWorkOrder/main.dart'
    as startWorkOrder;
import 'package:enerren/app/tms/aPic/module/detailWorkOrderPerActivity/main.dart'
    as maintenanceDetailWorkOrderPerActivity;
import 'package:enerren/module/personInCharge/main.dart' as personInCharge;
import 'package:enerren/module/vendor/main.dart' as vendor;
import 'package:enerren/module/vendorDetail/main.dart' as vendorDetail;
import 'package:enerren/module/inventoryMenu/main.dart' as inventory;
import 'package:enerren/module/inventoryProcess/main.dart' as inventoryProcess;
import 'package:enerren/module/inventoryMutasiStock/main.dart'
    as inventoryMutasiStock;
import 'package:enerren/module/historyStock/main.dart' as historyStock;
import 'package:enerren/module/inventoryDetailHistoryStock/main.dart'
    as inventoryDetailHistoryStock;
import 'package:enerren/app/tms/aTransporter/module/pocketMoney/main.dart'
    as pocketMoney;
import 'package:enerren/app/tms/aTransporter/module/detailPocketMoney/main.dart'
    as detailPocketMoney;
import 'package:enerren/app/tms/aTransporter/module/billing/main.dart'
    as billing;
import 'package:enerren/app/tms/aTransporter/module/incomeAndOutcome/main.dart'
    as incomeAndOutcome;
import 'package:enerren/app/tms/aTransporter/module/listIncomeAndOutcome/main.dart'
    as listIncomeAndOutcome;
import 'package:enerren/app/tms/aTransporter/module/detailIncomeAndOutcome/main.dart'
    as detailIncomeAndOutcome;
import 'package:enerren/component/HeroComponent.dart' as heroComponent;
import 'package:enerren/module/attendance/main.dart' as attendance;
import 'package:enerren/module/AttendaceList/main.dart' as listAttendance;
import 'package:enerren/module/tripAllowanceList/main.dart' as uangJalan;
import 'package:enerren/module/tripAllowaceDetail/main.dart' as detailuangJalan;
import 'package:enerren/module/shipmentItemDescription/main.dart'
    as shipmentItemDescription;
import 'package:enerren/module/deleveryEmergencyDetail/main.dart'
    as deliveryEmergencyDetail;

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
  static const String maintenance = "maintenance";
  static const String maintenanceItem = "maintenanceItem";
  static const String maintenanceItemAdd = "maintenanceItemAdd";
  static const String maintenanceSchedule = "maintenanceSchedule";
  static const String maintenanceDetail = "maintenanceDetail";
  static const String maintenanceAddWorkOrder = "maintenanceAddWorkOrder";
  static const String maintenanceWorkOrderHistory =
      "maintenanceWorkOrderHistory";
  static const String inventory = "inventory";
  static const String inventoryProcessPurchase = "inventoryProcessPurchase";
  static const String inventoryMutasiStock = "inventoryMutasiStock";
  static const String inventoryStockHistory = "inventoryStockHistory";
  static const String inventoryDetailHistoryStock = "detailHistoryStock";
  static const String heroComponent = "heroComponent";
  static const String pocketMoney = "pocketMoney";
  static const String detailPocketMoney = "detailPocketMoney";
  static const String splashScreen = "splashScreen";
  static const String historyForEmergency = "historyForEmergency";
  static const String singgleHistoryEmergency = "singgleHistoryEmergency";
  static const String emergency = "emergency";
  static const String driverScore = "driverScore";
  static const String pendingData = "pendingData";
  static const String singgleHistory = "singgleHistory";
  static const String podViewOnly = "podViewOnly";
  static const String detailHistoryEmergency = "detailHistoryEmergency";
  static const String billing = "billing";
  static const String incomeAndOutcome = "income";
  static const String outcome = "outcome";
  static const String listIncomeAndOutcome = "listIncomeAndOutcome";
  static const String detailIncomeAndOutcome = "detailIncomeAndOutcome";
  static const String detailWorkOrder = "detailWorkOrder";
  static const String maintenanceDetailWorkOrderPerActivity =
      "maintenanceDetailWorkOrderPerActivity";
  static const String startWorkOrder = "startworkorder";
  static const String attendance = "attendance";
  static const String atendaceReadOnly = "atendaceReadOnly";
  static const String confirmAttendance = "confirmAttendance";
  static const String listAttendance = "listAttendance";
  static const String uangJalan = "uangJalan";
  static const String detailuangJalan = "detailUangJalan";
  static const String unloadingShipmentItemDescription =
      "unloadingShipmentItemDescription";
  static const String loadingShipmentItemDescription =
      "loadingShipmentItemDescription";
  static const detailEmergencyDetail = "detailEmergencyDetail";
}

enum ParamName {
  ShipnentStcock,
  TmsShipmentPod,
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
  MaintenanceFinish,
  HistoryStock,
  TagImage,
  PathImage,
  PocketMoneyBalance,
  PocketMoneyInsentif,
  PocketMoneySeep,
  IndexDetailPocketMoney,
  Year,
  Month,
  IncomeAndOutcome,
  IncomeAndOutcomeModel,
  MaintenanceSchedule,
  WorkOrderModel,
  MaintenanceItemModel,
  EnumType,
  Attendance,
  TripAllowanceSummary,
  DestinationListId,
  ShipmentDeliveryEmergencyDetail,
}

//definisikan initial root name
String initialEouteName = RouteName.splasScreen;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  //--User Access--//
  RouteName.splasScreen: (BuildContext context) => splasScreen.Presenter(
        view: splasScreen.TransporterView(),
        onFinishSpashScreen: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushAndReplaceName(context, RouteName.checkUser);
          } else {
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            System.data.routes.pushAndReplaceName(
              context,
              RouteName.dashboard,
            );
          }
        },
      ),
  RouteName.heroComponent: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return heroComponent.HeroComponent(
      pathImage: arg[ParamName.PathImage],
      tagImage: arg[ParamName.TagImage],
    );
  },
  RouteName.checkUser: (BuildContext context) => checkUser.Presenter(
        view: checkUser.TmsView()
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
        ..logoAssets = System.data.global.companyHorizontalLogoAssets
        ..logoWidth = 150,
      username: arg[ParamName.Username],
      onLoginSuccess: (data) {
        System.data.getLocal<LocalData>().user =
            TransporterModel.fromJson(data);
        System.data.global.token = System.data.getLocal<LocalData>().user.token;
        System.data.sharedPreferences.setString(
            PrefsKey.user, json.encode(System.data.getLocal<LocalData>().user));
        ModeUtil.debugPrint("Token : ${System.data.global.token}");
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
        view: verification.TmsView(),
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
        view: password.TmsView(),
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
          menus: [
            //dashboard.TransporterMenu.History,
            dashboard.TransporterMenu.Attendance,
            dashboard.TransporterMenu.History,
            dashboard.TransporterMenu.Contact,
            dashboard.TransporterMenu.Maps,
            dashboard.TransporterMenu.Maintenance,
            dashboard.TransporterMenu.Inventory,
          ],
          onSetting: () {
            System.data.routes.pushNamed(context, RouteName.setting);
          },
          onHistory: () {
            System.data.routes.pushNamed(context, RouteName.history);
          },
          onTapAttendance: () {
            System.data.routes.pushNamed(context, RouteName.listAttendance);
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
          onTapMaintenance: () {
            System.data.routes.pushNamed(context, RouteName.maintenance);
          },
          onTapInventory: () {
            System.data.routes.pushNamed(context, RouteName.inventory);
          },
        )..companyLogoAssets = System.data.global.companyHorizontalLogoAssets,
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
  //--End User Access--//
  //--Maintenance--//
  RouteName.maintenance: (BuildContext context) => maintenance.Presenter(
        view: maintenance.MaintenanceMenuView(
          onTapMaintenanceItem: () => System.data.routes.pushNamed(
            context,
            RouteName.maintenanceItem,
            arguments: {
              ParamName.MaintenanceFinish: true,
            },
          ),
          onTapMaintenanceSchedule: () {
            System.data.routes
                .pushNamed(context, RouteName.maintenanceSchedule);
          },
          onTapWorkOrder: () {
            System.data.routes
                .pushNamed(context, RouteName.maintenanceAddWorkOrder);
          },
          onTapHistory: () => System.data.routes
              .pushNamed(context, RouteName.maintenanceWorkOrderHistory),
        ),
      ),
  RouteName.maintenanceItem: (BuildContext context) {
    return maintenanceItem.Presenter(
      addNewMaintenance: () {
        System.data.routes.pushNamed(
          context,
          RouteName.maintenanceItemAdd,
        );
      },
      detailNewMaintenance: (mm) => System.data.routes
          .pushNamed(context, RouteName.maintenanceDetail, arguments: {
        ParamName.MaintenanceItemModel: mm,
      }),
    );
  },
  RouteName.maintenanceItemAdd: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return maintenanceItemAdd.Presenter(
      getMaintenanceItemModel: arg[ParamName.MaintenanceItemModel],
      enumType: arg[ParamName.EnumType],
      sandMaintenancesModel: (mm) => System.data.routes.pushNamed(
          context, RouteName.maintenanceDetail,
          arguments: {ParamName.MaintenanceItemModel: mm}),
      backToList: () => System.data.routes.pushNamedAndRemoveUntil(
          context, RouteName.maintenanceItem, RouteName.maintenance),
    );
  },
  RouteName.maintenanceSchedule: (BuildContext context) {
    return maintenanceSchedule.Presenter(
      onSelected: (maintenanceSchedule) {
        System.data.routes
            .pushNamed(context, RouteName.maintenanceDetail, arguments: {
          ParamName.MaintenanceItemModel:
              maintenanceSchedule.maintenanceItemModel,
        });
      },
    );
  },
  RouteName.maintenanceDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return maintenanceDetail.Presenter(
      detailMaintenancesModel: arg[ParamName.MaintenanceItemModel],
      selectedMaintenancesModel: (mm) => System.data.routes.pushNamed(
          context, RouteName.maintenanceItemAdd, arguments: {
        ParamName.MaintenanceItemModel: mm,
        ParamName.EnumType: EnumType.EditData
      }),
    );
  },
  RouteName.maintenanceAddWorkOrder: (BuildContext context) {
    return maintenanceAddWorkOrder.Presenter(
      onSubmitSuccess: () {
        System.data.routes.pop(context);
      },
      getMaintenancesModel: () async {
        MaintenanceScheduleModel mm = new MaintenanceScheduleModel();
        await System.data.routes.push(
          context,
          maintenanceSchedule.Presenter(
            // tabs: [maintenanceSchedule.TabName.WillOverdue, TabName.Overdue],
            onSelected: (data) {
              mm = data;
              System.data.routes.pop(context);
            },
          ),
        );
        return mm;
      },
      getPersonInChargeModel: () async {
        PersonInChargeModel pm = PersonInChargeModel();
        await System.data.routes.push(
          context,
          personInCharge.Presenter(
            onSelectedPersonInChargeModel: (data) {
              pm = data;
              System.data.routes.pop(context);
            },
          ),
        );
        return pm;
      },
      getVendorModel: () async {
        VendorModel vm = VendorModel();
        await System.data.routes.push(
          context,
          vendor.Presenter(
            onSelectedPersonInChargeModel: (data) {
              System.data.routes.push(
                  context,
                  vendorDetail.Presenter(
                    listAction: [
                      vendorDetail.ActionButton.Confirm,
                    ],
                    vendorModel: data,
                    onTapConfirm: () {
                      vm = data;
                      System.data.routes.pop(context);
                      System.data.routes.pop(context);
                    },
                  ));
            },
          ),
        );
        return vm;
      },
    );
  },
  RouteName.maintenanceWorkOrderHistory: (BuildContext context) {
    return maintenanceWorkOrderHistory.Presenter(
      selecetedWorkOrderModel: (workOrderModel) {
        System.data.routes
            .pushNamed(context, RouteName.detailWorkOrder, arguments: {
          ParamName.WorkOrderModel: workOrderModel,
        });
      },
    );
  },
  RouteName.detailWorkOrder: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailWorkOrder.Presenter(
      view: detailWorkOrder.DetailWorkOrderView(),
      getWorkOrderModel: arg[ParamName.WorkOrderModel],
      selectedWorkOrderModel: (wo) => System.data.routes.pushNamed(
          context, RouteName.maintenanceDetailWorkOrderPerActivity,
          arguments: {ParamName.WorkOrderModel: wo}),
    );
  },
  RouteName.maintenanceDetailWorkOrderPerActivity: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return maintenanceDetailWorkOrderPerActivity.Presenter(
      view:
          maintenanceDetailWorkOrderPerActivity.DetailWorkOrderPerActivityView(
              newWorkOrder: (wo) => System.data.routes.pushNamed(
                  context, RouteName.startWorkOrder,
                  arguments: {ParamName.WorkOrderModel: wo})),
      getWorkOrderModel: arg[ParamName.WorkOrderModel],
      onTapHeroImage: (n, p) => System.data.routes
          .pushNamed(context, RouteName.heroComponent, arguments: {
        ParamName.PathImage: p,
        ParamName.TagImage: n,
      }),
    );
  },
  RouteName.startWorkOrder: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return startWorkOrder.Presenter(
      getWorkOrderModel: arg[ParamName.WorkOrderModel],
      makePurchaseOfGoods: (wo) => System.data.routes
          .pushNamed(context, RouteName.inventoryProcessPurchase),
    );
  },
  //--End Maintenance--//
  //--Inventory--//
  RouteName.inventory: (BuildContext context) {
    return inventory.Presenter(
      view: inventory.InventoryMenuView(onTapPurchase: () {
        System.data.routes.pushNamed(
          context,
          RouteName.inventoryProcessPurchase,
        );
      }, onTapStock: () {
        System.data.routes.pushNamed(
          context,
          RouteName.inventoryMutasiStock,
        );
      }, onTapHistory: () {
        System.data.routes.pushNamed(
          context,
          RouteName.inventoryStockHistory,
        );
      }),
    );
  },
  RouteName.billing: (BuildContext context) => billing.Presenter(
        ontapPay: () => System.data.routes.pushNamed(
            context, RouteName.incomeAndOutcome,
            arguments: {ParamName.IncomeAndOutcome: EnumUtil.OutCome}),
        ontapReceived: () => System.data.routes.pushNamed(
            context, RouteName.incomeAndOutcome,
            arguments: {ParamName.IncomeAndOutcome: EnumUtil.Income}),
      ),
  RouteName.incomeAndOutcome: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return incomeAndOutcome.Presenter(
      enumUtil: arg[ParamName.IncomeAndOutcome],
      ontapNext: (y, m, io) => System.data.routes.pushNamed(
        context,
        RouteName.listIncomeAndOutcome,
        arguments: {
          ParamName.Year: y,
          ParamName.Month: m,
          ParamName.IncomeAndOutcome: io,
        },
      ),
    );
  },
  RouteName.inventoryProcessPurchase: (BuildContext context) {
    return inventoryProcess.Presenter(
      view: inventoryProcess.PurchaseView(),
      onSubmitSuccess: () {
        System.data.routes.pop(context);
      },
    );
  },
  RouteName.inventoryMutasiStock: (BuildContext context) =>
      inventoryMutasiStock.Presenter(),
  RouteName.inventoryDetailHistoryStock: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return inventoryDetailHistoryStock.Presenter(
      onTapHeroImage: (n, p) => System.data.routes.pushNamed(
          context, RouteName.heroComponent,
          arguments: {ParamName.TagImage: n, ParamName.PathImage: p}),
      historyStockModel: arg[ParamName.HistoryStock],
    );
  },
  RouteName.inventoryStockHistory: (BuildContext context) =>
      historyStock.Presenter(
        onTapHeroImage: (n, p) => System.data.routes.pushNamed(
            context, RouteName.heroComponent,
            arguments: {ParamName.TagImage: n, ParamName.PathImage: p}),
        onTapDetail: (v) => System.data.routes.pushNamed(
          context,
          RouteName.inventoryDetailHistoryStock,
          arguments: {
            ParamName.HistoryStock: v,
          },
        ),
      ),
  //--End Inventory--//
  //--Uang Saku--//
  RouteName.listIncomeAndOutcome: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return listIncomeAndOutcome.Presenter(
      month: arg[ParamName.Month],
      year: arg[ParamName.Year],
      enumUtil: arg[ParamName.IncomeAndOutcome],
      ontapDetailIncomeAndOutcome: (iom) => System.data.routes.pushNamed(
        context,
        RouteName.detailIncomeAndOutcome,
        arguments: {ParamName.IncomeAndOutcomeModel: iom},
      ),
    );
  },
  RouteName.detailIncomeAndOutcome: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailIncomeAndOutcome.Presenter(
      incomeAndOutcomeModel: arg[ParamName.IncomeAndOutcomeModel],
    );
  },
  RouteName.pocketMoney: (BuildContext context) => pocketMoney.Presenter(
        onTapDetailHistoryStock: (v) => System.data.routes.pushNamed(
            context, RouteName.detailPocketMoney, arguments: {
          ParamName.PocketMoneyBalance: v,
          ParamName.IndexDetailPocketMoney: v.pokect
        }),
      ),
  RouteName.detailPocketMoney: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailPocketMoney.Presenter(
      historyStockModel: arg[ParamName.PocketMoneyBalance],
      onTapHeroImage: (n, p) => System.data.routes.pushNamed(
          context, RouteName.heroComponent,
          arguments: {ParamName.TagImage: n, ParamName.PathImage: p}),
      onTapDetail: (v) => System.data.routes.pushNamed(
        context,
        RouteName.inventoryStockHistory,
        arguments: {ParamName.HistoryStock: v},
      ),
    );
  },
  //--End Uang Saku--//
  //--Tms--//
  RouteName.history: (BuildContext context) => history.Presenter(
        onSelected: (shipment) {
          System.data.routes
              .pushNamed(context, RouteName.detailHistory, arguments: {
            ParamName.Shipment: shipment,
          });
        },
      ),
  RouteName.profile: (BuildContext context) => profile.Presenter(
        view: profile.TransporterView(),
      ),
  RouteName.changePassword: (BuildContext context) => password.Presenter(
        view: password.TmsView(),
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
    TmsShipmentModel data = arg[ParamName.Shipment];
    return detailHistory.Presenter(
      data: data,
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
      view: detailHistory.TransporterView(),
      showButtonAddTripAllowanceBalance: true,
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
      onTapAddTripAllowance: (shipment) {
        System.data.routes.pushNamed(
          context,
          RouteName.uangJalan,
          arguments: {
            ParamName.Shipment: shipment,
          },
        );
      },
      onTapViewTripAllowance: (tripAllowanceSummary) {
        System.data.routes.pushNamed(
          context,
          RouteName.detailuangJalan,
          arguments: {
            ParamName.TripAllowanceSummary: tripAllowanceSummary,
          },
        );
      },
    );
  },
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
        System.data.routes.pushNamed(context, RouteName.liveTrack, arguments: {
          ParamName.Shipment: <TmsShipmentModel>[shipment],
        });
      },
      data: shipment
          .tmsShipmentDestinationList.first.tmsShipmentDetailHistoryList,
    );
  },
  RouteName.liveMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsVehicleModel vehiclesData = arg[ParamName.TmsVehicleModel];
    return liveMap.Presenter(
      view: liveMap.TransporterView(
        tmsViewModel: liveMap.TmsViewModel(
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
  RouteName.listVehicle: (BuildContext context) =>
      listVehicle.Presenter<TmsShipmentModel>(
        view: listVehicle.View<TmsShipmentModel>(),
        userIdVts:
            System.data.getLocal<LocalData>().user.transporterIdVts ?? 65606274,
        tokenVts: System.data.getLocal<LocalData>().user.transporterTokenVts ??
            'dc5c9c3b2299c8ed1b7ba31b74936073',
        childReader: (json) =>
            TmsShipmentModel.fromJson(json, childReader: (data) {
          return data;
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
      view: detailVehicle.TmsView(),
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
      view: maps.TmsView(
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
    List<TmsShipmentModel> shipment = arg[ParamName.Shipment];
    return liveMap.Presenter(
      vehicleIconTopUrl:
          shipment.first.tmsShipmentDestinationList.first.vehicleTypeIconUrlTop,
      drawRoute: true,
      view: liveMap.TmsView(
        tmsViewModel: new liveMap.TmsViewModel(
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
  RouteName.notification: (BuildContext context) => notification.Presenter(),
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
  RouteName.about: (BuildContext context) {
    return about.Presenter();
  },
  RouteName.listAttendance: (BuildContext context) {
    return listAttendance.Presenter(
      onTapAttendance: (am) {
        System.data.routes.pushNamed(
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
      view: ReadOnlyView(),
      attendanceModel: arg[ParamName.Attendance],
      onSubmited: (am) {
        System.data.routes.pushNamed(
          context,
          RouteName.confirmAttendance,
          arguments: {ParamName.Attendance: am},
        );
      },
    );
  },
  RouteName.confirmAttendance: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return attendance.Presenter(
      view: ConfirmAttendaceView(),
      attendanceModel: arg[ParamName.Attendance],
      onSubmited: (am) {
        System.data.commit();
        System.data.routes
            .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
      },
    );
  },
  RouteName.uangJalan: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return uangJalan.Presenter(
      // view: uangJalan.TransporterView(),
      showList: false,
      showSearchSipment: false,
      shipmentNumber:
          (arg[ParamName.Shipment] as TmsShipmentModel).shipmentNumber,
      onSubmit: (angkutUangJalan) {
        System.data.routes.pushNamed(
          context,
          RouteName.detailuangJalan,
          arguments: {
            ParamName.TripAllowanceSummary: angkutUangJalan,
          },
        );
      },
      onTapSearchShipment: (uangJalanViewMOdel) {
        // System.data.routes
        //     .pushNamed(context, RouteName.listShipmentForUangJalan, arguments: {
        //   ParamName.TripAllowanceSummary: uangJalanViewMOdel,
        // });
      },
      onSuccessAddbalance: (uangJalan) {
        System.data.routes.pushAndReplaceName(
            context, RouteName.detailuangJalan,
            arguments: {ParamName.TripAllowanceSummary: uangJalan});
      },
    );
  },
  RouteName.detailuangJalan: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailuangJalan.Presenter(
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
  RouteName.podViewOnly: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return pod.Presenter(
      view: pod.ReadOnlyView(deliveryPodModel: arg[ParamName.TmsShipmentPod]),
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
//--End TMS--//
//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
