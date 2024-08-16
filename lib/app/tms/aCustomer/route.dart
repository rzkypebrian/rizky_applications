import 'dart:convert';
//import 'dart:js';

import 'package:enerren/app/tms/aCustomer/localData.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
// import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/tms/aCustomer/module/splashScreen/main.dart'
    as splashScreen;
import 'package:enerren/app/tms/module/login/main.dart' as login;
import 'package:enerren/app/tms/module/checkUser/main.dart' as checkUser;
import 'package:enerren/app/tms/aCustomer/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/app/tms/aCustomer/module/profile/main.dart' as profile;
import 'package:enerren/module/setting/main.dart' as setting;
import 'package:enerren/module/about/main.dart' as about;
import 'package:enerren/module/notification/main.dart' as notification;
import 'package:enerren/app/tms/aCustomer/module/history/main.dart' as history;
import 'package:enerren/module/track/main.dart' as track;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:enerren/app/tms/module/liveMap/main.dart' as liveMap;
import 'package:enerren/module/deliveryPod/main.dart' as pod;
import 'package:enerren/app/tms/module/password/main.dart' as password;
import 'package:enerren/app/tms/aCustomer/module/detailHistory/main.dart'
    as detailHistory;
import 'package:enerren/app/tms/aCustomer/module/ratingDriver/main.dart'
    as ratingDriver;
import 'package:enerren/app/tms/module/verification/main.dart' as verification;
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
  static const String about = "about";
  static const String unloadingShipmentItemDescription =
      "unloadingShipmentItemDescription";
  static const String loadingShipmentItemDescription =
      "loadingShipmentItemDescription";
  static const podViewOnly = "podViewOnly";
  static const detailEmergencyDetail = "detailEmergencyDetail";
}

enum ParamName {
  Username,
  Shipment,
  TmsDeliveryPodModel,
  DestinationListId,
  TmsShipmentPod,
  ShipmentDeliveryEmergencyDetail,
}

//definisikan initial root name
String initialEouteName = RouteName.splashScreen;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splashScreen: (BuildContext context) => splashScreen.Presenter(
        view: splashScreen.CustomerView(),
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
  RouteName.checkUser: (BuildContext context) => checkUser.Presenter(
        view: checkUser.TmsView(),
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
          System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        },
      ),
  RouteName.login: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return login.Presenter(
      view: login.TmsView(),
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
  RouteName.dashboard: (BuildContext context) => dashboard.Presenter(
        gotoProfile: () {
          System.data.routes.pushNamed(context, RouteName.profile);
        },
        view: dashboard.CustomerView(
          onSetting: () {
            System.data.routes.pushNamed(context, RouteName.setting);
          },
          onHistory: () {
            System.data.routes.pushNamed(context, RouteName.history);
          },
          onContactService: () {
            System.data.routes.pushNamed(context, RouteName.contactService);
          },
          onNotification: () {
            System.data.routes.pushNamed(context, RouteName.notification);
          },
        ),
      ),
  RouteName.profile: (BuildContext context) => profile.Presenter(
        view: profile.CustomerView(),
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
  RouteName.about: (BuildContext context) => about.Presenter(),
  RouteName.notification: (BuildContext context) => notification.Presenter(),
  RouteName.history: (BuildContext context) => history.Presenter(
        onSelected: (shipment) {
          // if (shipment.tmsShipmentDestinationList.length > 1) {
          //   System.data.routes
          //       .pushNamed(context, RouteName.singleHistory, arguments: {
          //     ParamName.Shipment: shipment,
          //   });
          // } else {
          System.data.routes
              .pushNamed(context, RouteName.detailHistory, arguments: {
            ParamName.Shipment: shipment,
          });
          // }
        },
      ),
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
  RouteName.liveMap: (BuildContext context) {
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
            shipment.first.tmsShipmentDestinationList.first.destinationLong,
          ),
        )
      ],
      fromDate: DateTime.now().add(Duration(hours: -2)),
    );
  },
  RouteName.pod: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return pod.Presenter(
      view: pod.ReadOnlyView(
        deliveryPodModel: arg[ParamName.TmsDeliveryPodModel],
      ),
    );
  },
  RouteName.changeLanguage: (BuildContext context) => setting.Presenter(
        view: setting.LanguageView(),
      ),
  RouteName.changePassword: (BuildContext context) => password.Presenter(
        passwordState: password.PasswordState.ChangePassword,
        view: password.TmsView(),
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
        },
      ),
  RouteName.detailHistory: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel data = arg[ParamName.Shipment];
    return detailHistory.Presenter(
      view: detailHistory.CustomerView(),
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
      showButtonAddTripAllowanceBalance: false,
      showButtonViewTripAllowanceBalance: false,
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
    );
  },
  RouteName.ratingDriver: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    TmsShipmentModel shipment = arg[ParamName.Shipment];
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

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
