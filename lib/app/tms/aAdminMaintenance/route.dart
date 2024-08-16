import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/module/maintenaceMenu/main.dart' as menu;
import 'package:enerren/module/maintenanceDetail/main.dart'
    as maintenanceDetail;
import 'package:enerren/module/maintenanceAddWorkOrder/main.dart'
    as maintenanceAddWorkOrder;
import 'package:enerren/module/maintenanceHistoryWorkOrder/main.dart'
    as maintenanceHistoryWorkOrder;
import 'package:enerren/module/maintenanceDetailWorkOrderPerActivity/main.dart'
    as maintenanceDetailWorkOrderPerActivity;
import 'package:enerren/module/personInCharge/main.dart' as personInCharge;
import 'package:enerren/module/personInChargeModel/main.dart'
    as detailPersonInCharge;
import 'package:enerren/module/vendor/main.dart' as vendor;
import 'package:enerren/module/vendorDetail/main.dart' as vendorDetail;
import 'package:enerren/module/maintenanceSchedule/main.dart'
    as scheduleMaintenance;
import 'package:enerren/module/maintenanceItem/main.dart' as listMaintenance;
import 'package:enerren/module/maintenanceItemAdd/main.dart' as addMaintenance;
import 'package:enerren/module/maintenanceDetailWorkOrder/main.dart'
    as detailWorkOrder;
import 'package:enerren/component/HeroComponent.dart' as heroComponent;

class RouteName {
  static const String menu = "menu";
  static const String listMaintenance = "listMaintenance";
  static const String addMaintenance = "addMaintenance";
  static const String maintenanceDetail = "maintenanceDetail";
  static const String maintenanceAddWorkOrder = "maintenanceAddWorkOrder";
  static const String scheduleMaintenance = "scheduleMaintenance";
  static const String personInCharge = "personInCharge";
  static const String detailPersonInCharge = "detailPersonInCharge";
  static const String vendor = "vendor";
  static const String vendorDetail = "vendorDetail";
  static const String maintenanceHistoryWorkOrder =
      "maintenanceHistoryWorkOrder";
  static const String detailWorkOrder = "detailWorkOrder";
  static const String heroComponent = "heroComponent";
  static const String maintenanceDetailWorkOrderPerActivity =
      "maintenanceDetailWorkOrderPerActivity";
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
  StockProcess,
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
  MaintenanceItemModel,
  PersonInChargeModel,
  EnumType,
  WorkOrderModel,
}

//definisikan initial root name
String initialEouteName = RouteName.menu;
//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.menu: (BuildContext context) {
    return menu.Presenter(
      view: menu.MaintenanceMenuView(
        onTapMaintenanceItem: () =>
            System.data.routes.pushNamed(context, RouteName.listMaintenance),
        onTapWorkOrder: () => System.data.routes
            .pushNamed(context, RouteName.maintenanceAddWorkOrder),
        onTapMaintenanceSchedule: () => System.data.routes
            .pushNamed(context, RouteName.scheduleMaintenance),
        onTapHistory: () => System.data.routes
            .pushNamed(context, RouteName.maintenanceHistoryWorkOrder),
      ),
    );
  },
  RouteName.personInCharge: (BuildContext context) {
    return personInCharge.Presenter(
      onSelectedPersonInChargeModel: (pm) => System.data.routes.pushNamed(
        context,
        RouteName.detailPersonInCharge,
        arguments: {ParamName.PersonInChargeModel: pm},
      ),
    );
  },
  RouteName.detailPersonInCharge: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailPersonInCharge.Presenter(
      onSelectedPersonInChargeModel: arg[ParamName.PersonInChargeModel],
    );
  },
  RouteName.listMaintenance: (BuildContext context) {
    return listMaintenance.Presenter(
      addNewMaintenance: () =>
          System.data.routes.pushNamed(context, RouteName.addMaintenance),
      detailNewMaintenance: (mm) => System.data.routes
          .pushNamed(context, RouteName.maintenanceDetail, arguments: {
        ParamName.MaintenanceItemModel: mm,
      }),
    );
  },
  RouteName.addMaintenance: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return addMaintenance.Presenter(
      getMaintenanceItemModel: arg[ParamName.MaintenanceItemModel],
      enumType: arg[ParamName.EnumType],
      sandMaintenancesModel: (mm) => System.data.routes.pushNamed(
          context, RouteName.maintenanceDetail,
          arguments: {ParamName.MaintenanceItemModel: mm}),
      backToList: () =>
          System.data.routes.pushNamed(context, RouteName.listMaintenance),
    );
  },
  RouteName.scheduleMaintenance: (BuildContext context) {
    return scheduleMaintenance.Presenter(
      tabs: [MaintenanceTab.WillOverdue, MaintenanceTab.Overdue],
      onSelected: (v) => System.data.routes.pushNamed(
          context, RouteName.maintenanceDetail,
          arguments: {ParamName.MaintenanceItemModel: v}),
    );
  },
  RouteName.vendor: (BuildContext context) {
    return vendor.Presenter();
  },
  RouteName.vendorDetail: (BuildContext context) {
    return vendorDetail.Presenter();
  },
  RouteName.maintenanceHistoryWorkOrder: (BuildContext context) {
    return maintenanceHistoryWorkOrder.Presenter(
      selecetedWorkOrderModel: (wo) => System.data.routes.pushNamed(
          context, RouteName.detailWorkOrder,
          arguments: {ParamName.WorkOrderModel: wo}),
    );
  },
  RouteName.detailWorkOrder: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailWorkOrder.Presenter(
      getWorkOrderModel: arg[ParamName.WorkOrderModel],
      selectedWorkOrderModel: (wo) => System.data.routes.pushNamed(
          context, RouteName.maintenanceDetailWorkOrderPerActivity,
          arguments: {ParamName.WorkOrderModel: wo}),
    );
  },
  RouteName.maintenanceDetailWorkOrderPerActivity: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return maintenanceDetailWorkOrderPerActivity.Presenter(
      getWorkOrderModel: arg[ParamName.WorkOrderModel],
      workorder: () => System.data.routes.pushNamed(
        context,
        RouteName.addMaintenance,
      ),
      onTapHeroImage: (n, p) => System.data.routes
          .pushNamed(context, RouteName.heroComponent, arguments: {
        ParamName.PathImage: p,
        ParamName.TagImage: n,
      }),
    );
  },
  RouteName.heroComponent: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return heroComponent.HeroComponent(
      pathImage: arg[ParamName.PathImage],
      tagImage: arg[ParamName.TagImage],
    );
  },
  RouteName.maintenanceDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return maintenanceDetail.Presenter(
      detailMaintenancesModel: arg[ParamName.MaintenanceItemModel],
      selectedMaintenancesModel: (mm) => System.data.routes.pushNamed(
          context, RouteName.addMaintenance, arguments: {
        ParamName.MaintenanceItemModel: mm,
        ParamName.EnumType: EnumType.EditData
      }),
    );
  },
  RouteName.maintenanceAddWorkOrder: (BuildContext context) {
    return maintenanceAddWorkOrder.Presenter(
      getMaintenancesModel: () async {
        MaintenanceScheduleModel mm = new MaintenanceScheduleModel();
        await System.data.routes.push(
          context,
          scheduleMaintenance.Presenter(
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
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
