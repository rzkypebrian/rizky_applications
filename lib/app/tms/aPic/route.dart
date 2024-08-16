import 'package:enerren/app/tms/aPic/module/maintenance/main.dart'
    as maintenanceMenu;
import 'package:enerren/module/maintenanceHistoryWorkOrder/main.dart'
    as workOrderHistory;
import 'package:enerren/module/inventoryProcess/main.dart' as inventoryProcess;
import 'package:enerren/component/HeroComponent.dart' as heroComponent;
import 'package:enerren/app/tms/aPic/module/detailWorkOrder/main.dart'
    as detailWorkOrder;
import 'package:enerren/app/tms/aPic/module/detailWorkOrderPerActivity/main.dart'
    as maintenanceDetailWorkOrderPerActivity;
import 'package:enerren/app/tms/aPic/module/startWorkOrder/main.dart'
    as startWorkOrder;
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String maintenanceMenu = "maintenanceMenu";
  static const String workOrderHistory = "workOrderHistory";
  static const String heroComponent = "heroComponent";
  static const String maintenanceListVehicle = "maintenanceListVehicle";
  static const String detailWorkOrder = "detailWorkOrder";
  static const String startWorkOrder = "startWorkOrder";
  static const String maintenanceDetailWorkOrderPerActivity =
      "maintenanceDetailWorkOrderPerActivity";
  static const String inventoryProcess = "inventoryProcess";
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
  WorkOrderModel,
}

//definisikan initial root name
String initialEouteName = RouteName.maintenanceMenu;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.maintenanceMenu: (BuildContext context) =>
      maintenanceMenu.Presenter(
        view: maintenanceMenu.PicMaintenanceMenuView()
          ..onTapHistory = () => System.data.routes.pushNamed(
                context,
                RouteName.workOrderHistory,
              ),
      ),
  RouteName.workOrderHistory: (BuildContext context) =>
      workOrderHistory.Presenter(
        selecetedWorkOrderModel: (v) => System.data.routes.pushNamed(
          context,
          RouteName.detailWorkOrder,
          arguments: {ParamName.WorkOrderModel: v},
        ),
      ),
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
      makePurchaseOfGoods: (wo) =>
          System.data.routes.pushNamed(context, RouteName.inventoryProcess),
    );
  },
  RouteName.inventoryProcess: (BuildContext context) {
    // Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return inventoryProcess.Presenter();
  },
  RouteName.heroComponent: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return heroComponent.HeroComponent(
      pathImage: arg[ParamName.PathImage],
      tagImage: arg[ParamName.TagImage],
    );
  },
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
