import 'dart:convert';
import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NavigationUtil.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/angkut/module/checkUser/main.dart' as chekUser;
import 'package:enerren/app/angkut/aDriver/module/history/main.dart' as history;
import 'package:enerren/app/angkut/module/login/main.dart' as login;
import 'package:enerren/app/angkut/aDriver/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/app/angkut/aDriver/module/setting/main.dart' as setting;
import 'package:enerren/app/angkut/aDriver/module/liveMap/main.dart' as liveMap;
import 'package:enerren/app/angkut/module/orderDetail/main.dart' as detailOrder;
import 'package:enerren/app/angkut/module/verification/main.dart'
    as verification;
import 'package:enerren/app/angkut/aDriver/module/emergencyReport/main.dart'
    as emergency;

import 'package:enerren/app/angkut/aDriver/module/doPhoto/main.dart' as doPhoto;
import 'package:enerren/app/angkut/aDriver/module/doPhotoFinish/main.dart'
    as doPhotoFinish;

import 'package:enerren/app/angkut/aDriver/module/do/main.dart' as dos;
import 'package:enerren/app/angkut/aDriver/module/doFinish/main.dart'
    as doFinish;
import 'package:enerren/app/angkut/aDriver/module/podPickup/main.dart'
    as podPicUp;
import 'package:enerren/app/angkut/aDriver/module/podFinish/main.dart'
    as podFinish;
import 'package:enerren/module/tripAllowance/main.dart' as uangJalan;
import 'package:enerren/app/angkut/module/password/main.dart' as password;
import 'package:enerren/app/angkut/aDriver/module/splashScreen/main.dart'
    as splashScreen;
import 'package:enerren/app/angkut/module/notification/main.dart'
    as notification;
import 'package:enerren/app/angkut/aDriver/module/profile/main.dart' as profile;
import 'package:enerren/app/angkut/aDriver/module/driverScore/main.dart'
    as driverScore;
import 'package:enerren/module/track/main.dart' as track;
import 'package:enerren/module/deleveryEmergencyDetail/main.dart'
    as deliveryEmergencyDetail;
import 'package:enerren/app/angkut/aDriver/module/profile/main.dart'
    as driverProfile;
import 'package:enerren/module/shipmentItemDescription/main.dart'
    as shipmentItemDescription;
import 'package:enerren/module/deliveryPod/main.dart' as pod;
import 'package:enerren/app/angkut/util/ResourceUtil.dart';
import 'package:enerren/module/chat/main.dart' as chat;

import '../../../util/MarkerUtil.dart';

//definisikan enum name alur program anda disini

class RouteName {
  static const String chekUser = "chekUser";
  static const String login = "login";
  static const String dashboard = "dashboard";
  static const String setting = "setting";
  static const String changeLanguage = "changeLanguage";
  static const String history = "history";
  static const String liveMap = "liveMap";
  static const String detailOrder = "detailOrder";
  static const String verificationNewLogin = "verificationNewLogin";
  static const String emergency = "emergency";
  static const String podPickup = "podPickup";
  static const String podFinish = "podFinish";
  static const String doPhoto = "doPhoto";
  static const String dos = "dos";
  static const String doPhotoFinish = "doPhotoFinish";
  static const String doFinish = "doFinish";
  static const String uangJalan = "uangJalan";
  static const String listUangJalan = "listUangJalan";
  static const String password = "password";
  static const String splashScreen = "splashScreen";
  static const String changePassword = "changePassword";
  static const String createPassword = "createPassword";
  static const String verification = "forgotPassword";
  static const String notification = "notification";
  static const String profile = "profile";
  static const String driverScore = "driverScore";
  static const String verificationResetPassword = "verificationResetPassword";
  static const String track = "track";
  static const String detailEmergencyDetail = "detailEmergency";
  static const String driverProfile = "driverProfile";
  static const String dosView = "dosView";
  static const String loadingShipmentItemDescription =
      "loadingShipmentItemDescription";
  static const String unloadingShipmentItemDescription =
      "unloadingShipmentItemDescription";
  static const String readOnlyPod = "readOnlyPod";
  static const String chat = "chat";
}

enum ParamName {
  UserName,
  AngkutShipmentModel,
  OnTapAccept,
  OnTapDoPHotoPod,
  OnTapDoPhotoItem,
  DestinationListId,
  MapViewModel,
  AngkutUangJalanSummaryViewModel,
  AccountModel,
  TmsShipmentModel,
  ShipmentDeliveryEmergencyDetail,
  ProfileModel,
  TmsShipmentPodModel,
  ShowShipmentNumber,
  IsPodFinish,
}

//definisikan initial root name
String initialEouteName = RouteName.splashScreen;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splashScreen: (BuildContext context) => splashScreen.Presenter(
        view: splashScreen.DriverView()
          ..animationAssets = System.data.global.splascreenAnimationAssets
          ..animationName = System.data.global.splasscreenAnimationName
          ..autoStart = false,
        onFinishSpashScreen: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes
                .pushNamedAndRemoveUntil(context, RouteName.login, "");
          } else {
            print("token ${System.data.getLocal<LocalData>().user.token}");
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            System.data.routes
                .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
            ModeUtil.debugPrint("Token ${System.data.global.token}");
          }
        },
      ),
  RouteName.chekUser: (BuildContext context) => chekUser.Presenter(
        view: chekUser.AngkutView(),
        onUserIsActive: (account) {
          System.data.routes.pushNamed(context, RouteName.login, arguments: {
            ParamName.UserName: account.username,
          });
        },
      ),
  RouteName.login: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return login.Presenter(
      view: login.AngkutView(),
      username: arg[ParamName.UserName],
      onLoginSuccess: (data) {
        System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
        System.data.global.token = System.data.getLocal<LocalData>().user.token;
        System.data.sharedPreferences.setString(PrefsKey.user,
            json.encode(System.data.getLocal<LocalData>().user.toJson()));
        System.data.routes
            .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
      },
      onAccessDenied: (username, password, data) {
        System.data.global.newAccount = AccountModel.fromJson(data);
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
  RouteName.dashboard: (BuildContext context) => dashboard.Presenter(
        gotoProfile: () {
          System.data.routes.pushNamed(context, RouteName.profile);
        },
        view: dashboard.AngkutView(
            logoAssets: System.data.global.companyHorizontalLogoAssets,
            onTapSetting: () {
              System.data.routes.pushNamed(context, RouteName.setting);
            },
            onTapHistory: () {
              System.data.routes.pushNamed(context, RouteName.history);
            },
            onTapLiveMap: (shipment) {
              System.data.routes.pushNamed(
                context,
                RouteName.liveMap,
                arguments: {
                  ParamName.AngkutShipmentModel: shipment,
                },
              );
            },
            onTapEmergency: (shipment) {
              System.data.routes.pushNamed(
                context,
                RouteName.emergency,
                arguments: {
                  ParamName.AngkutShipmentModel: shipment,
                },
              );
            },
            onTapUangJalan: () {
              System.data.routes.pushNamed(
                context,
                RouteName.listUangJalan,
              );
            },
            onTapNotification: () {
              System.data.routes.pushNamed(
                context,
                RouteName.notification,
              );
            },
            onTapScore: () {
              System.data.routes.pushNamed(
                context,
                RouteName.driverScore,
              );
            }),
      ),
  RouteName.setting: (BuildContext context) => setting.Presenter(
        view: setting.DriverView(language: () {
          System.data.routes.pushNamed(context, RouteName.changeLanguage);
        }, logout: () {
          System.data.sharedPreferences.setString(PrefsKey.user, null);
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.login, "");
        }, changePassword: () {
          System.data.routes.pushNamed(context, RouteName.changePassword);
        }),
      ),
  RouteName.changeLanguage: (BuildContext context) => setting.Presenter(
        view: setting.LanguageView(
          onTapId: () {
            System.data.resource = ResourceUtil.ind().angkutId();
            System.commit();
          },
        ),
      ),
  RouteName.history: (BuildContext context) => history.Presenter(
        onSelected: (historyViewModel, shipment) {
          System.data.routes.pushNamed(
            context,
            RouteName.detailOrder,
            arguments: {
              ParamName.AngkutShipmentModel: shipment,
              ParamName.ShowShipmentNumber: shipment.shipmentStatusId == 1 ||
                      shipment.shipmentStatusId == 2
                  ? false
                  : true,
              ParamName.OnTapAccept:
                  (detailOrder.ViewModel detailOrderViewModel) {
                System.data.routes.pop(context);
                System.data.routes.pushNamed(
                  context,
                  RouteName.liveMap,
                  arguments: {
                    ParamName.AngkutShipmentModel: shipment,
                  },
                );
              }
            },
          );
        },
      ),
  RouteName.liveMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel angkutShipment =
        (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel);

    return liveMap.Presenter(
      vehicleId: angkutShipment.tmsShipmentDestinationList.first.vehicleIdVts,
      vehicleIconTopUrl:
          angkutShipment.tmsShipmentDestinationList.first.vehicleTypeIconUrlTop,
      vehicleIconTopSize: angkutShipment
              .tmsShipmentDestinationList.first.vehicleTypeIconTopSize ??
          150,
      destination: MarkerUtil.readPointDestination(
        destinations: angkutShipment.tmsShipmentDestinationList,
        markerOriginIcon: "assets/angkut/track_destination.png",
        markerOriginIconSize: 100,
        markerDestinationIcon: "assets/angkut/flag_destination.png",
        markerDestinationIconSize: 100,
        showDestinationNumber: true,
      ),
      fromDate: DateTime.now().add(Duration(hours: -2)),
      folowTheVehicle: true,
      usingLastPositionOnEmpty: true,
      showHistoryLine: false,
      view: liveMap.ANgkutView(
          angkutShipmentModel: arg[ParamName.AngkutShipmentModel],
          onTapPickup: (mapViewModel) {
            System.data.routes.pushNamed(
              context,
              RouteName.dos,
              arguments: {
                ParamName.AngkutShipmentModel: mapViewModel.angkutShipmentModel,
                ParamName.MapViewModel: mapViewModel,
              },
            );
          },
          onTapFinish: (mapViewModel, idDestination) {
            System.data.routes
                .pushNamed(context, RouteName.doFinish, arguments: {
              ParamName.MapViewModel: mapViewModel,
              ParamName.AngkutShipmentModel: mapViewModel.angkutShipmentModel,
              ParamName.DestinationListId: idDestination,
            });
          },
          onTapStart: () {},
          onTapDetail: (mapViewMOdel) {
            System.data.routes
                .pushNamed(context, RouteName.detailOrder, arguments: {
              ParamName.AngkutShipmentModel: mapViewMOdel.angkutShipmentModel,
            });
          },
          onTapEmergency: (mapViewMOdel) {
            System.data.routes
                .pushNamed(context, RouteName.emergency, arguments: {
              ParamName.AngkutShipmentModel: mapViewMOdel.angkutShipmentModel,
            });
          },
          onTapChat: (shipment) {
            System.data.routes.pushNamed(context, RouteName.chat, arguments: {
              ParamName.AngkutShipmentModel: shipment,
            });
          }),
    );
  },
  RouteName.detailOrder: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailOrder.Presenter(
      onTapReceive: arg[ParamName.OnTapAccept],
      showShipmentNumber: arg[ParamName.ShowShipmentNumber],
      shipment: arg[ParamName.AngkutShipmentModel],
      view: detailOrder.HiddenDiscount(),
      onTapLiveMap: (shipment) {
        System.data.routes.pushNamedAndRemoveUntil(
          context,
          RouteName.liveMap,
          RouteName.dashboard,
          arguments: {
            ParamName.AngkutShipmentModel: shipment,
          },
        );
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
              ParamName.DestinationListId: destinationId,
            });
      },
      onTapUnloadingDetail: (angkutShipmentModel, destinationId) {
        System.data.routes.pushNamed(
            context, RouteName.unloadingShipmentItemDescription,
            arguments: {
              ParamName.AngkutShipmentModel: angkutShipmentModel,
              ParamName.DestinationListId: destinationId,
            });
      },
    );
  },
  RouteName.verificationNewLogin: (BuildContext context) =>
      verification.Presenter(
        view: verification.NewLoginView(onSuccessLogin: (data) {
          System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.sharedPreferences.setString(PrefsKey.user,
              json.encode(System.data.getLocal<LocalData>().user.toJson()));
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
  RouteName.emergency: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return emergency.Presenter(
      titleLabel: System.data.resource.tripReport,
      view: emergency.AngkutView(
        shipmentModel: arg[ParamName.AngkutShipmentModel],
        onSuccess: () {
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        },
      ),
      shipmentId: 1,
      customerName: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
          .customerName,
      shipmentNumber:
          (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
              .shipmentNumber,
      fotoLabel: System.data.resource.photosThatCompleteTheObstacles,
    );
  },
  RouteName.doPhoto: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return doPhoto.Presenter(
      angkutShipmentModel: arg[ParamName.AngkutShipmentModel],
      onTapDO: () {
        System.data.routes.pushNamed(context, RouteName.dos, arguments: {
          ParamName.AngkutShipmentModel: arg[ParamName.AngkutShipmentModel],
        });
      },
      onTapNext: (am) {
        (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap)
            .angkutShipmentModel = am;
        (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap).commit();
        System.data.routes.pop(context);
      },
      onTapPhoto: () {
        System.data.routes.pushNamed(context, RouteName.podPickup, arguments: {
          ParamName.AngkutShipmentModel: arg[ParamName.AngkutShipmentModel],
        });
      },
    );
  },
  RouteName.podPickup: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    liveMap.ViewModeliveMap liveMapViewModel =
        (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap);
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
    AngkutShipmentModel shipment = arg[ParamName.AngkutShipmentModel];
    return pod.ProductOnlyPresenter(
      destinationId: shipment.tmsShipmentDestinationList.first.detailshipmentId,
      isPod: false,
      imageQuality: null,
      title: null,
      loadUploadedImage: false,
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
            loadUploadedImage: false,
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
                    shipment: arg[ParamName.AngkutShipmentModel],
                    onSuccessSubmit: (am) {
                      // (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap)
                      //     .angkutShipmentModel = am;
                      // (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap)
                      //     .commit();
                      liveMapViewModel.angkutShipmentModel = am;
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
  RouteName.dos: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return dos.Presenter(
      tmsShipmentId: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
          .tmsShipmentId,
      detailShipmentId:
          (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
              .tmsShipmentDestinationList
              .first
              .detailshipmentId,
      isPod: false,
      user: "Driver ${System.data.getLocal<LocalData>().user.driverName}",
      destinations: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
          .tmsShipmentDestinationList,
      view: dos.AngkutView(),
      onSubmitSuccess: () {
        System.data.routes.pushNamed(
          context,
          RouteName.podPickup,
          arguments: {
            ParamName.AngkutShipmentModel: arg[ParamName.AngkutShipmentModel],
            ParamName.MapViewModel: arg[ParamName.MapViewModel]
          },
        );
      },
    );
  },
  RouteName.doFinish: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return doFinish.Presenter(
      tmsShipmentId: (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
          .tmsShipmentId,
      detailShipmentId: (arg[ParamName.AngkutShipmentModel]
              as AngkutShipmentModel)
          .tmsShipmentDestinationList[(arg[ParamName.DestinationListId] as int)]
          .detailshipmentId,
      // detailShipmentId: 0,
      isPod: true,
      user: System.data.getLocal<LocalData>().user.driverName,
      view: doFinish.AngkutView(),
      onSubmitSuccess: () {
        System.data.routes.pushNamed(context, RouteName.podFinish, arguments: {
          ParamName.AngkutShipmentModel: arg[ParamName.AngkutShipmentModel],
          ParamName.MapViewModel: arg[ParamName.MapViewModel],
          ParamName.DestinationListId: arg[ParamName.DestinationListId]
        });
      },
    );
  },
  RouteName.podFinish: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    // liveMap.ViewModeliveMap liveMapViewModel =
    //     (arg[ParamName.MapViewModel] as liveMap.ViewModeliveMap);

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
    AngkutShipmentModel shipment = arg[ParamName.AngkutShipmentModel];
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
                    shipment: arg[ParamName.AngkutShipmentModel],
                    idDestination: arg[ParamName.DestinationListId],
                    // isFinish: arg[ParamName.IsPodFinish],
                    onSuccessSubmit: (v) {
                      //-- jika ingin kembali ke peta
                      System.data.routes.pushNamedAndRemoveUntil(
                          context, RouteName.liveMap, RouteName.dashboard,
                          arguments: {
                            ParamName.AngkutShipmentModel:
                                arg[ParamName.AngkutShipmentModel]
                          });
                      //-- jika ingin kembali ke peta end
                      // System.data.routes.pushNamedAndRemoveUntil(
                      //     context, RouteName.dashboard, "");
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
  RouteName.doPhotoFinish: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return doPhotoFinish.Presenter(
      view: doPhotoFinish.DoPhotoFinishView(
        shipment: arg[ParamName.AngkutShipmentModel],
        idDestination: arg[ParamName.DestinationListId],
        onTapDO: () {
          System.data.routes.pushNamed(context, RouteName.doFinish, arguments: {
            ParamName.AngkutShipmentModel: arg[ParamName.AngkutShipmentModel],
            ParamName.DestinationListId: arg[ParamName.DestinationListId],
          });
        },
        onTapNext: (shipment) {
          System.data.routes.pop(context);
          System.data.routes.pushNamedAndRemoveUntil(
            context,
            RouteName.liveMap,
            RouteName.dashboard,
            arguments: {
              ParamName.AngkutShipmentModel: shipment,
            },
          );
        },
        onTapPhoto: () {
          System.data.routes
              .pushNamed(context, RouteName.podFinish, arguments: {
            ParamName.AngkutShipmentModel: arg[ParamName.AngkutShipmentModel],
            ParamName.DestinationListId: arg[ParamName.DestinationListId],
            ParamName.MapViewModel: arg[ParamName.MapViewModel],
          });
        },
      ),
    );
  },
  RouteName.uangJalan: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return uangJalan.Presenter(
      tripAllowanceSummary: arg[ParamName.AngkutUangJalanSummaryViewModel],
    );
  },
  RouteName.password: (BuildContext context) => password.Presenter(
        view: password.AngkutView(),
        passwordState: password.PasswordState.ChangePassword,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
        },
      ),
  RouteName.changePassword: (BuildContext context) => password.Presenter(
        view: password.AngkutView(),
        passwordState: password.PasswordState.ChangePassword,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
        },
      ),
  RouteName.verification: (BuildContext context) => verification.Presenter(
        phoneNumber: System.data.global.newAccount.sendTo,
        view: verification.ForgotPasswordView(),
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
          System.data.getLocal<LocalData>().user = DriverModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        },
      ),
  RouteName.notification: (BuildContext context) => notification.Presenter(
        view: notification.AngkutView(onTapNotif: (shipment) {
          System.data.routes
              .pushAndReplaceName(context, RouteName.detailOrder, arguments: {
            ParamName.AngkutShipmentModel: shipment,
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
  RouteName.profile: (BuildContext context) => profile.Presenter(
        view: profile.DriverView(),
      ),
  RouteName.driverScore: (BuildContext context) {
    return driverScore.Presenter(
      view: driverScore.AngkutView(),
      score: System.data.getLocal<LocalData>().user.score,
    );
  },
  RouteName.track: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel shipment = arg[ParamName.AngkutShipmentModel];
    return track.Presenter(
      shipmentNumber: shipment.shipmentNumber,
      showButtonMap:
          shipment.shipmentStatusId > 2 && shipment.shipmentStatusId != 10
              ? true
              : false,
      onTapLiveMap: () {
        System.data.routes.pushNamed(context, RouteName.liveMap, arguments: {
          ParamName.AngkutShipmentModel: shipment,
        });
      },
      onTapDetailShipment: () {
        System.data.routes
            .pushNamed(context, RouteName.detailOrder, arguments: {
          ParamName.AngkutShipmentModel: shipment,
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
  RouteName.dosView: (BuildContext context) {
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
      destinationId: arg[ParamName.DestinationListId],
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
  RouteName.unloadingShipmentItemDescription: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel angkutShipmentModel =
        arg[ParamName.AngkutShipmentModel];
    return shipmentItemDescription.Presenter(
      token: System.data.global.token,
      tmsShipmentId: angkutShipmentModel.tmsShipmentId,
      destinationId: arg[ParamName.DestinationListId],
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
  RouteName.chat: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments;
    AngkutShipmentModel shipmentModel = arg[ParamName.AngkutShipmentModel];
    return chat.Presenter(
      tmsShipmentId: shipmentModel.tmsShipmentId,
      senderId: System.data.getLocal<LocalData>().user.driverId,
      senderName: System.data.getLocal<LocalData>().user.driverName,
      senderTypeId: 2,
      title: "${shipmentModel.shipmentNumber}",
      subTitle: System.data.resource.chat,
      avatarAssets: "assets/angkut/logo_angkut.png",
      getListFlareAnimationAsset:
          "assets/flares/angkut/angkut_circular_indicator_blue.flr",
      getListFlareAnimationName: "loading2",
      senderFlareAnimationAsset:
          "assets/flares/angkut/angkut_circular_indicator_white.flr",
      senderFlareAnimationName: "loading2",
    );
  }
  // RouteName.verificationResetPassword: (BuildContext context) {
  //   Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
  //   AccountModel cust = arg[ParamName.AccountModel];
  //   return verification.Presenter(
  //     view: verification.ForgotPasswordView(),
  //     duration: Duration(seconds: 60),
  //     verificationCode: cust.otpCode,
  //     phoneNumber: cust.sendTo,
  //     scurePhoneNUmber: true,
  //     withTimer: true,
  //     onVerificationValid: (otp) {
  //       System.data.routes.pushNamed(
  //         context,
  //         RouteName.createPassword,
  //       );
  //     },
  //   );
  // },
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
