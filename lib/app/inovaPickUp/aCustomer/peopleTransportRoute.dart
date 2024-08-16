import 'dart:convert';
import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/app/angkut/util/AngkutOrderUtil.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/customeGoogleMap/objectData.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/model/LocationModel.dart';
import 'package:enerren/model/PaymentMethodeDetailModel.dart';
import 'package:enerren/model/RegisterModel.dart';
import 'package:enerren/model/TmsVoucherModel.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NavigationUtil.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/MarkerUtil.dart';
import 'package:enerren/app/inovaPickUp/aCustomer/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/app/angkut/aCustomer/module/detailLocation/main.dart'
    as detailLocation;
import 'package:enerren/module/locationPicker/main.dart' as locationPicker;
import 'package:enerren/app/angkut/aCustomer/module/service/main.dart'
    as service;
import 'package:enerren/app/inovaPickUp/aCustomer/module/confirm/main.dart'
    as confirm;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:enerren/app/angkut/aCustomer/module/login/main.dart' as login;
import 'package:enerren/app/angkut/aCustomer/module/verification/main.dart'
    as verification;
import 'package:enerren/module/register/main.dart' as register;
import 'package:enerren/app/angkut/aCustomer/module/history/main.dart'
    as history;
import 'package:enerren/app/inovaPickUp/aCustomer/module/orderDetail/main.dart'
    as orderDetail;
import 'package:enerren/app/angkut/aCustomer/module/password/main.dart'
    as password;
import 'package:enerren/app/angkut/aCustomer/module/setting/main.dart'
    as setting;
import 'package:enerren/module/track/main.dart' as track;
import 'package:enerren/app/angkut/module/liveMap/main.dart' as liveMap;
import 'package:enerren/app/angkut/aCustomer/module/processOrder/main.dart'
    as processOrder;
import 'package:enerren/app/angkut/aCustomer/module/trackShipment/main.dart'
    as trackShipment;
import 'package:enerren/app/angkut/aCustomer/module/splashScreen/main.dart'
    as splashScreen;
import 'package:enerren/module/contactAddress/main.dart' as contactAddress;
import 'package:enerren/app/angkut/aCustomer/module/profile/main.dart'
    as profile;
import 'package:enerren/app/angkut/module/notification/main.dart'
    as notification;
import 'package:enerren/module/deleveryEmergencyDetail/main.dart'
    as deliveryEmergencyDetail;
import 'package:enerren/app/angkut/aDriver/module/profile/main.dart'
    as driverProfile;
import 'package:enerren/module/do/main.dart' as dos;
import 'package:enerren/module/shipmentItemDescription/main.dart'
    as shipmentItemDescription;
import 'package:enerren/module/deliveryPod/main.dart' as pod;
import 'package:enerren/module/termAndCondition/main.dart' as termAndCondition;
import 'package:enerren/app/inovaPickUp/util/ResourceUtil.dart';
import 'package:enerren/module/paymentMethode/main.dart' as paymentMethode;
import 'package:enerren/app/angkut/aCustomer/module/paymentGateWay/main.dart'
    as paymentGateWayPage;
import 'package:enerren/app/angkut/aCustomer/module/inputPhoneNumber/main.dart'
    as inputPhoneNumber;
import 'package:enerren/app/angkut/aCustomer/module/ratingDriver/main.dart'
    as ratingDriver;
import 'package:enerren/util/StringExtention.dart';
import 'package:enerren/module/voucherList/main.dart' as voucherList;
import 'package:enerren/app/angkut/aCustomer/module/voucherDetail/main.dart'
    as voucherDetail;

//definisikan enum name alur program anda disini

class RouteName {
  static const String dashboard = "dashboard";
  static const String detailLocation = "detailLocation";
  static const String locationPicker = "locationPicker";
  static const String service = "service";
  static const String confirm = "confirm";
  static const String login = "login";
  static const String verificationNewLogin = "verificationNewLogin";
  static const String register = "register";
  static const String history = "history";
  static const String orderDetail = "orderDetail";
  static const String createPasseord = "createPasseord";
  static const String setting = "setting";
  static const String changeLanguage = "changeLanguage";
  static const String track = "track";
  static const String liveMap = "liveMap";
  static const String processOrder = "processOrder";
  static const String trackShipment = "trackShipment";
  static const String splashScreen = "splashScreen";
  static const String changePassword = "changePassword";
  static const String resetPassword = "resetPassword";
  static const String contactAddress = "contactAddress";
  static const String profile = "profile";
  static const String notification = "notification";
  static const String verificationRegister = "verificationRegister";
  static const String verificationResetPassword = "verificationResetPassword";
  static const String verificationChangePhoneNumber =
      "verificationChangePhoneNumber";
  static const String createPassword = "createPassword";
  static const String detailEmergencyDetail = "detailEmergency";
  static const String driverProfile = "driverProfile";
  static const String dos = "dos";
  static const String loadingShipmentItemDescription =
      "loadingShipmentItemDescription";
  static const String unloadingShipmentItemDescription =
      "unloadingShipmentItemDescription";
  static const String readOnlyPod = "readOnlyPod";
  static const String termAndCondition = "termAndCondition";
  static const String changeProfile = "changeProfile";
  static const String priceSimulation = "priceSimulation";
  static const String paymentMethode = "paymentMethode";
  static const String paymentGateWayPage = "paymentGateWayPage";
  static const String inputPhoneNumber = "inputPhoneNumber";
  static const String ratingDriver = "ratingDriver";
  static const String voucherList = "voucherList";
  static const String voucherDetail = "voucherDetail";
}

enum ParamName {
  UserName,
  OnLocationSelected,
  OnDetailLocationSubmited,
  LocationDetailViewModel,
  AngkutShipmentModel,
  LatLong,
  ActiveTab,
  Otp,
  AccountModel,
  ContactNameLabel,
  ShipmentDeliveryEmergencyDetail,
  ProfileModel,
  TmsShipmentPodModel,
  IsFromConfirm,
  CustomerModel,
  ConfirmViewModel,
  PhoneNumber,
  DestinationId,
  Voucher,
}

//definisikan initial root name
String initialRouteName = RouteName.splashScreen;
// String initialEouteName = RouteName.login;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splashScreen: (BuildContext context) => splashScreen.Presenter(
        view: splashScreen.CustomerView()
          ..animationAssets = System.data.global.splascreenAnimationAssets
          ..animationName = System.data.global.splasscreenAnimationName
          ..autoStart =
              System.data.global.splascreenAnimationAutoStart ?? false,
        onFinishSpashScreen: () {
          if (System.data.getLocal<LocalData>().user != null) {
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            ModeUtil.debugPrint(
                "urlimage ${System.data.getLocal<LocalData>().user.imageUrl}");
            System.data.routes.pushAndReplaceName(
              context,
              RouteName.dashboard,
            );
          } else {
            System.data.routes.pushAndReplaceName(
              context,
              RouteName.login,
            );
          }
        },
        autoStartDuration: System.data.global.splascreenAutoStartDuration,
      ),
  RouteName.profile: (BuildContext context) => profile.Presenter(
        onChangeProfile: () {
          System.data.routes
              .pushAndReplaceName(context, RouteName.changeProfile, arguments: {
            ParamName.ProfileModel: new ProfileModel(
              address: "-",
              email: System.data.getLocal<LocalData>().user.customerEmail,
              name: System.data.getLocal<LocalData>().user.customerName,
              phone: System.data.getLocal<LocalData>().user.adminPhoneNumber,
              registeredDate:
                  System.data.getLocal<LocalData>().user.registeredDate,
              urlImmage: System.data.getLocal<LocalData>().user.imageUrl,
            )
          });
        },
        view: profile.CustomerView(),
      ),
  RouteName.changeProfile: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return profile.Presenter(
      view: profile.UpdateView(
        onValidatePhone: (otp, customer, callback) {
          NavigationUtil.navTo(
              context,
              verification.Presenter(
                sentSms: false,
                withTimer: true,
                verificationCode: otp,
                scurePhoneNUmber: true,
                duration: Duration(seconds: 60),
                phoneNumber: customer.customerMobile,
                obscureText: true,
                onVerificationValid: (otp) {
                  Navigator.of(context).pop();
                  callback();
                },
              ));
        },
      ),
      profileModel: arg[ParamName.ProfileModel],
      onUpdateSuccess: (profile) {
        System.data.routes.pushAndReplaceName(context, RouteName.profile);
      },
    );
  },
  RouteName.dashboard: (BuildContext context) => dashboard.Presenter(
        view: dashboard.PeopleTransportView(),
        useValidateIdenticalContact: false,
        pickUpAssetsIcon: "assets/inovapickup/man.svg",
        pickUpWidthIcon: 10,
        onSelectLocation: (viewModel, i) {
          System.data.routes.pushNamed(
            context,
            RouteName.detailLocation,
            arguments: {
              ParamName.LocationDetailViewModel:
                  viewModel.googleMapControllers.getListPoint[0][i].data,
              ParamName.ContactNameLabel:
                  i > 0 ? System.data.resource.receiverName : null,
              ParamName.OnDetailLocationSubmited:
                  (detailLocation.ViewModel detailLocationViewModel) {
                viewModel.googleMapControllers.editPoint(
                  layer: 0,
                  index: i,
                  reCreateMarker: true,
                  showPolyLine: false,
                  showPolygon: false,
                  pointData: ObjectData<detailLocation.ViewModel>(
                    name: "${detailLocationViewModel.name}",
                    snipset: "${detailLocationViewModel.address}",
                    address: "${detailLocationViewModel.address}",
                    markerIcon: i == 0
                        ? "assets/inovapickup/man.png"
                        // : "assets/angkut/flag_destination.png",
                        : "assets/angkut/marker_map.png",
                    iconSize: i == 0 ? 50 : 70,
                    latLng: LatLng(
                      detailLocationViewModel.lat,
                      detailLocationViewModel.lon,
                    ),
                    data: detailLocationViewModel,
                  ),
                );
                if (viewModel.googleMapControllers.getListPoint[0]
                        .any((e) => e.latLng == null) ==
                    false) {
                  viewModel.drawRoute();
                }
                System.data.routes.pop(context);
              }
            },
          );
        },
        onSubmit: (viewModel, selectedVehicle) {
          System.data.getLocal<LocalData>().newOrder.vehicleTypeId =
              selectedVehicle.vehicleTypeId;
          System.data.getLocal<LocalData>().newOrder.detailDestinationList =
              readDestinationModel(
                  viewModel.googleMapControllers.getListPoint[0]);
          System.data.routes.pushNamed(context, RouteName.service);
        },
        onTapTrack: () {
          System.data.routes.pushNamed(context, RouteName.trackShipment);
        },
        onTapHistory: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushNamed(context, RouteName.login);
          } else {
            System.data.routes.pushNamed(context, RouteName.history);
          }
        },
        onTapHelp: () {
          System.data.routes.pushNamed(context, RouteName.contactAddress);
        },
        onTapSetting: () {
          System.data.routes.pushNamed(context, RouteName.setting);
        },
        onTapProfile: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushNamed(context, RouteName.login);
          } else {
            System.data.routes.pushNamed(context, RouteName.profile);
          }
        },
        onTapNotification: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushNamed(context, RouteName.login);
          } else {
            System.data.routes.pushNamed(context, RouteName.notification);
          }
        },
        // onTapPriceSimulation: () {
        //   System.data.routes.pushNamed(context, RouteName.priceSimulation);
        // },
      ),
  RouteName.detailLocation: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    ModeUtil.debugPrint(arg[ParamName.LocationDetailViewModel]);
    detailLocation.ViewModel data;
    try {
      data = arg[ParamName.LocationDetailViewModel] as detailLocation.ViewModel;
    } catch (e) {
      data = null;
    }
    return detailLocation.Presenter(
      contactNameLabel: arg[ParamName.ContactNameLabel],
      onSubmit: arg[ParamName.OnDetailLocationSubmited],
      useSenderNameField: false,
      usePhoneNumberField: false,
      onInitData: (model) {
        if (data != null) {
          model.address = data.address;
          model.kecamatan = data.kecamatan;
          model.kabupaten = data.kabupaten;
          model.provinsi = data.provinsi;
          model.detailAdress = data.detailAdress;
          model.lat = data.lat;
          model.lon = data.lon;
          model.name = data.name;
          model.phoneNumber = data.phoneNumber;
          model.noteForDriver = data.noteForDriver;
        }
      },
      onSelectLocation: (data) {
        System.data.routes
            .pushNamed(context, RouteName.locationPicker, arguments: {
          ParamName.LatLong: data.lat != null && data.lon != null
              ? LatLng(data.lat, data.lon)
              : null,
          ParamName.OnLocationSelected: (LocationModel location) {
            data.address = location.address;
            data.kecamatan = location.kecamatan;
            data.kabupaten = location.kabupaten;
            data.provinsi = location.propinsi;
            data.lat = location.lat;
            data.lon = location.lon;
            data.commit();
            System.data.routes.pop(context);
          }
        });
      },
    );
  },
  RouteName.locationPicker: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return locationPicker.Presenter(
      useCurrentLocation: true,
      onPickLocation: arg[ParamName.OnLocationSelected],
      center: arg[ParamName.LatLong],
    );
  },
  RouteName.service: (BuildContext context) => service.Presenter(
        extraPeopleMinValue: 1,
        useInsuranceField: false,
        onSubmitSuccess: (angkutShipment) {
          System.data.routes.pushNamed(context, RouteName.confirm, arguments: {
            ParamName.AngkutShipmentModel: angkutShipment,
          });
        },
      ),
  RouteName.confirm: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return confirm.Presenter(
      showInchargePersoneSelector: false,
      showdetailPayment: false,
      showContactPerson: false,
      showInchageStatus: false,
      view: confirm.PeopleTransportView(),
      shipment: arg[ParamName.AngkutShipmentModel],
      onBeforeLogin: (shipment) {
        System.data.routes.pushNamed(context, RouteName.login, arguments: {
          ParamName.IsFromConfirm: true,
          ParamName.AngkutShipmentModel: shipment,
        });
      },
      onSuccessSubmit: (shipment) {
        if (System.data
            .getLocal<LocalData>()
            .user
            .customerMobile
            .isNullOrEmpty()) {
          System.data.routes
              .pushNamed(context, RouteName.inputPhoneNumber, arguments: {
            ParamName.AngkutShipmentModel: shipment,
          });
        } else {
          System.data.routes.pushNamedAndRemoveUntil(
              context, RouteName.processOrder, RouteName.dashboard,
              arguments: {
                ParamName.AngkutShipmentModel: shipment,
              },
              onBack: () {});
        }
      },
      onTapPaymentMethode: (viewModel) {
        System.data.routes.pushNamed(
          context,
          RouteName.paymentMethode,
          arguments: {
            ParamName.ConfirmViewModel: viewModel,
          },
        );
      },
      onTapVoucher: (viewModel) {
        System.data.routes.pushNamed(
          context,
          RouteName.voucherList,
          arguments: {
            ParamName.ConfirmViewModel: viewModel,
          },
        );
      },
    );
  },
  RouteName.login: (BuildContext context) {
    return login.Presenter(
      view: login.AngkutCustomerView(
        showThirdPartyLogin: false,
        onTapRegister: () {
          System.data.routes.pushNamed(context, RouteName.register);
        },
      ),
      onLoginSuccess: (jsonData) {
        System.data.getLocal<LocalData>().user =
            CustomerModel.fromJson(jsonData);
        System.data.global.token = System.data.getLocal<LocalData>().user.token;
        System.commit();
        ModeUtil.debugPrint(System.data.global.token);
        System.data.sharedPreferences.setString(
            PrefsKey.user, json.encode(System.data.getLocal<LocalData>().user));
        System.data.routes.pushAndReplaceName(context, RouteName.dashboard);
      },
      onAccessDenied: (username, password, account) {
        System.data.global.newAccount = AccountModel.fromJson(account);
        System.data.global.newAccount.username = username;
        System.data.global.newAccount.password = password;
        System.data.routes.pushNamed(context, RouteName.verificationNewLogin);
      },
      onForgotPasswordSuccess: (accountModel) {
        System.data.global.newAccount = accountModel;
        System.data.routes.pushNamed(
          context,
          RouteName.verificationResetPassword,
          arguments: {
            ParamName.AccountModel: accountModel,
          },
        );
      },
      onThirdPartyLoginDenied: (jsonResponse) {
        System.data.global.registerModel.email =
            jsonResponse[ConstantUtil.userName];
        System.data.global.registerModel.fullName =
            jsonResponse[ConstantUtil.fullName];
        System.data.routes.pushNamed(context, RouteName.register);
      },
    );
  },
  RouteName.verificationNewLogin: (BuildContext context) =>
      verification.Presenter(
        view: verification.NewLoginView(onSuccessLogin: (data) {
          System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.routes.pop(context);
          System.data.routes.pop(context);
          // System.data.routes
          //     .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        }),
        sentSms: false,
        verificationCode: System.data.global.newAccount.otpCode,
        withTimer: true,
        scurePhoneNUmber: true,
        duration: Duration(seconds: 60),
        phoneNumber: System.data.global.newAccount.sendTo,
      ),
  RouteName.register: (BuildContext context) => register.Presenter(
        onSubmitSuccess: (viewModel, json) {
          System.data.global.registerModel = new RegisterModel(
            address: viewModel.address,
            birthDate: viewModel.birthdate,
            email: viewModel.email,
            fullName: viewModel.name,
            phoneNum: viewModel.phone,
            userNik: "",
            imei: "",
            os: "",
            userId: 0,
            deviceId: System.data.global.mmassagingToken,
          );
          System.commit();
          System.data.routes
              .pushNamed(context, RouteName.verificationRegister, arguments: {
            ParamName.Otp: json["otpCode"],
          });
        },
        onTapTermAndCondition: () {
          System.data.routes.pushNamed(context, RouteName.termAndCondition);
        },
        onTapPrivacyPolicy: () {
          System.data.routes.pushNamed(context, RouteName.termAndCondition);
        },
      ),
  RouteName.verificationRegister: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return verification.Presenter(
      view: verification.View(),
      sentSms: false,
      phoneNumber: System.data.global.registerModel.phoneNum,
      verificationCode: arg[ParamName.Otp],
      duration: Duration(seconds: 6),
      onVerificationValid: (otp) {
        System.data.routes.pushNamed(context, RouteName.createPasseord);
      },
    );
  },
  RouteName.history: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return history.Presenter(
      activeTab: arg[ParamName.ActiveTab] ?? 0,
      showPrice: false,
      showExtraPeople: true,
      onSelected: (viewmode, shipment) {
        System.data.routes.pushNamed(
          context,
          RouteName.orderDetail,
          arguments: {
            ParamName.AngkutShipmentModel: shipment,
          },
        );
      },
    );
  },
  RouteName.orderDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return orderDetail.Presenter(
      showContactPerson: false,
      showInchargeStatus: false,
      showPaymentDetail: false,
      shipment: arg[ParamName.AngkutShipmentModel],
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
          context,
          RouteName.unloadingShipmentItemDescription,
          arguments: {
            ParamName.AngkutShipmentModel: angkutShipmentModel,
            ParamName.DestinationId: destinationId,
          },
        );
      },
      onSuccessCancel: () {
        System.data.routes.pushNamedAndRemoveUntil(
          context,
          RouteName.history,
          RouteName.dashboard,
          arguments: {
            ParamName.ActiveTab: 4,
          },
        );
      },
      view: orderDetail.PeopleTransportView()
        ..onTapPaynow = (shipment) {
          System.data.routes.pushNamed(
            context,
            RouteName.paymentGateWayPage,
            arguments: {
              ParamName.AngkutShipmentModel: shipment,
            },
          );
        }
        ..onTapRatintDriver = (shipment) {
          System.data.routes
              .pushNamed(context, RouteName.ratingDriver, arguments: {
            ParamName.AngkutShipmentModel: shipment,
          });
        }
        ..confirmCamcelIlustrationAssets =
            "assets/inovapickup/inova_pickup_people_transport_cancel_order.svg",
    );
  },
  RouteName.createPasseord: (BuildContext context) => password.Presenter(
        view: password.CustomerView(),
        passwordState: password.PasswordState.CreatePassword,
        onSubmitSuccess: (data) {
          {
            System.data.getLocal<LocalData>().user =
                CustomerModel.fromJson(data);
            System.data.global.token =
                System.data.getLocal<LocalData>().user.token;
            System.data.sharedPreferences.setString(PrefsKey.searchResiHistory,
                json.encode(System.data.getLocal<LocalData>().user.toJson()));
            System.commit();
            System.data.routes.pop(context);
            System.data.routes.pop(context);
            System.data.routes.pop(context);
            System.data.routes.pop(context);
          }
        },
      ),
  RouteName.setting: (BuildContext context) => setting.Presenter(
        view: setting.CustomerView(language: () {
          System.data.routes.pushNamed(context, RouteName.changeLanguage);
        }, logout: () {
          System.data.getLocal<LocalData>().user = null;
          System.data.sharedPreferences.setString(PrefsKey.user, null);
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        }, changePassword: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushNamed(context, RouteName.login);
          } else {
            System.data.routes.pushNamed(context, RouteName.changePassword);
          }
        }),
      ),
  RouteName.changeLanguage: (BuildContext context) => setting.Presenter(
        view: setting.LanguageView(onTapId: () {
          System.data.resource = ResourceUtil.ind().peopleTransportId();
          System.commit();
        }, onTapEn: () {
          System.data.resource = ResourceUtil.ind().peopleTransportEn();
          System.commit();
        }),
      ),
  RouteName.liveMap: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    List<TmsShipmentDestinationModel> destinationShipment =
        (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
            .tmsShipmentDestinationList;
    return liveMap.Presenter(
      view: liveMap.AngkutView(
        shipmentModel: arg[ParamName.AngkutShipmentModel],
      ),
      vehicleId: destinationShipment.first.vehicleIdVts,
      vehicleIconTopUrl: destinationShipment.first.vehicleTypeIconUrlTop,
      vehicleIconTopType: MarkerIconType.Network,
      usingDelayedMarker: false,
      vehicleIconTopSize:
          destinationShipment.first.vehicleTypeIconTopSize ?? 150,
      usingLastPositionOnEmpty: true,
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
      isExpandBottomDock: true,
    );
  },
  RouteName.processOrder: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return processOrder.Presenter(
      shipmentModel: arg[ParamName.AngkutShipmentModel],
      showPrize: false,
      showExtraPeople: true,
      animationAssets: "assets/flares/inovapickup/process_order.flr",
      animationName: "play",
      buttonFinishTitle:
          (arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
                      .shipmentInvoice
                      .methodDetailIpay88Id !=
                  null
              ? System.data.resource.paynow
              : null,
      onTapButtonFInish: (shipment) {
        if ((arg[ParamName.AngkutShipmentModel] as AngkutShipmentModel)
                .shipmentInvoice
                .methodDetailIpay88Id !=
            null) {
          System.data.routes
              .pushNamed(context, RouteName.paymentGateWayPage, arguments: {
            ParamName.AngkutShipmentModel: shipment,
          });
        } else {
          System.data.routes.pushNamedAndRemoveUntil(
              context, RouteName.history, RouteName.dashboard);
        }
      },
    );
  },
  RouteName.trackShipment: (BuildContext context) =>
      trackShipment.Presenter<AngkutShipmentModel>(
        view: trackShipment.AngkutView(),
        onShipmentFound: (shipment) {
          System.data.routes.pushNamed(context, RouteName.track, arguments: {
            ParamName.AngkutShipmentModel: shipment,
          });
        },
      ),
  RouteName.track: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel shipment = arg[ParamName.AngkutShipmentModel];
    return track.Presenter(
      shipmentNumber: shipment.shipmentNumber,
      showButtonMap: shipment.shipmentStatusId > 2 ? true : false,
      onTapLiveMap: () {
        System.data.routes.pushNamed(context, RouteName.liveMap, arguments: {
          ParamName.AngkutShipmentModel: shipment,
        });
      },
      onTapDetailShipment: () {
        System.data.routes
            .pushNamed(context, RouteName.orderDetail, arguments: {
          ParamName.AngkutShipmentModel: shipment,
        });
      },
      // data: shipment
      //     .tmsShipmentDestinationList.first.tmsShipmentDetailHistoryList,
      data: shipment.tmsShipmentHistoryList,
    );
  },
  RouteName.changePassword: (BuildContext context) => password.Presenter(
        view: password.AngkutView(),
        passwordState: password.PasswordState.ChangePassword,
        onSubmitSuccess: (data) {
          System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.commit();
        },
      ),
  RouteName.contactAddress: (BuildContext context) => contactAddress.Presenter(
        mainContentCorner: 0,
        backgroundHeighScala: 3.3,
        data: contactAddress.ViewModel(
          headOfficeImage: "assets/inovapickup/pusat_bantuan.svg",
          headOfficeAddress:
              "Jl. Kemang Raya No.4, RT.11/RW.1, Bangka, Kec. Mampang Prpt., Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12730",
          headOfficePhone: ["+62 21 719 8634"],
          headOfficeWhatsAppNumber: ["+62 815-9309-500"],
          headOfficeEmail: ["info@enerren.com"],
          headOfficeLon: 106.8115211,
          headOfficeLat: -6.2560945,
        ),
      ),
  RouteName.notification: (BuildContext context) {
    return notification.Presenter(
      view: notification.AngkutView(
        onTapNotif: (shipment) {
          System.data.routes
              .pushNamed(context, RouteName.orderDetail, arguments: {
            ParamName.AngkutShipmentModel: shipment,
          });
        },
      ),
      loadingIndicatorDecoration: (controller) {
        return DecorationComponent.circularLOadingIndicator(
            controller: controller);
      },
    );
  },
  RouteName.verificationResetPassword: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AccountModel cust = arg[ParamName.AccountModel];
    return verification.Presenter(
      view: verification.ForgotPasswordView(),
      duration: Duration(seconds: 60),
      verificationCode: cust.otpCode,
      phoneNumber: cust.sendTo,
      scurePhoneNUmber: true,
      withTimer: true,
      onVerificationValid: (otp) {
        System.data.routes.pushNamed(context, RouteName.resetPassword);
      },
    );
  },
  RouteName.resetPassword: (BuildContext context) {
    return password.Presenter(
      view: password.AngkutView(),
      passwordState: password.PasswordState.CreatePassword,
      onSubmitSuccess: (data) {
        {
          System.data.getLocal<LocalData>().user = CustomerModel.fromJson(data);
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.sharedPreferences.setString(PrefsKey.searchResiHistory,
              json.encode(System.data.getLocal<LocalData>().user.toJson()));
          System.commit();
          System.data.routes.pop(context);
          System.data.routes.pop(context);
          System.data.routes.pop(context);
          System.data.routes.pop(context);
        }
      },
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
      iconItemAssets: "assets/inovapickup/man.svg",
      showQtyField: false,
      showUnitField: false,
      view: shipmentItemDescription.LoadingGroupByDestination(
        destinations: angkutShipmentModel.tmsShipmentDestinationList,
      ),
      tmsShipmentId: angkutShipmentModel.tmsShipmentId,
      destinationId: arg[ParamName.DestinationId],
      loadingDecoration: (controller) {
        return DecorationComponent.circularLOadingIndicator(
            controller: controller);
      },
      token: System.data.global.token,
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
      tmsShipmentId: angkutShipmentModel.tmsShipmentId,
      destinationId: arg[ParamName.DestinationId],
      iconItemAssets: "assets/inovapickup/man.svg",
      showQtyField: false,
      showUnitField: false,
      loadingDecoration: (controller) {
        return DecorationComponent.circularLOadingIndicator(
            controller: controller);
      },
      view: shipmentItemDescription.UnloadingView(),
      token: System.data.global.token,
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
  RouteName.termAndCondition: (BuildContext context) {
    return termAndCondition.Presenter(
      submitTextLabel: System.data.resource.ok,
      onTapSubmit: () {
        System.data.routes.pop(context);
      },
      view: termAndCondition.Fromhtml(
        sourceType: termAndCondition.SourceType.Asset,
        htmlSource: "assets/angkut/termandcondition.html",
      ),
    );
  },
  RouteName.priceSimulation: (BuildContext context) {
    return dashboard.Presenter(
      view: dashboard.SimulationView(),
      onSelectLocation: (viewModel, index) {
        System.data.routes
            .pushNamed(context, RouteName.locationPicker, arguments: {
          ParamName.LatLong: viewModel.googleMapControllers
                          .getListPoint[0][index]?.latLng?.latitude !=
                      null &&
                  viewModel.googleMapControllers.getListPoint[0][index]?.latLng
                          ?.longitude !=
                      null
              ? LatLng(
                  viewModel.googleMapControllers.getListPoint[0][index].latLng
                      .latitude,
                  viewModel.googleMapControllers.getListPoint[0][index].latLng
                      .longitude)
              : null,
          ParamName.OnLocationSelected: (LocationModel location) {
            viewModel.googleMapControllers.editPoint(
              layer: 0,
              index: index,
              reCreateMarker: true,
              showPolyLine: false,
              showPolygon: false,
              pointData: ObjectData<detailLocation.ViewModel>(
                name: "${location.address}",
                snipset: "${location.address}",
                address: "${location.address}",
                markerIcon: index == 0
                    ? "assets/angkut/track_destination.png"
                    : "assets/angkut/flag_destination.png",
                iconSize: 100,
                latLng: LatLng(
                  location.lat,
                  location.lon,
                ),
                data: new detailLocation.ViewModel(
                  lat: location.lat,
                  lon: location.lon,
                  address: location.address,
                  detailAdress: location.addressLabel,
                  kabupaten: location.kabupaten,
                  kecamatan: location.kecamatan,
                  provinsi: location.propinsi,
                  phoneNumber: "",
                  name: "",
                ),
              ),
            );
            if (viewModel.googleMapControllers.getListPoint[0]
                    .any((e) => e.latLng == null) ==
                false) {
              viewModel.drawRoute();
            }
            viewModel.commit();
            System.data.routes.pop(context);
          }
        });
      },
    );
  },
  RouteName.paymentMethode: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments;
    confirm.ViewModel model = arg[ParamName.ConfirmViewModel];
    return paymentMethode.Presenter(
      currentPaymentMethode: PaymentMethodeDetailModel(
        methoDetailId: model.shipment.shipmentInvoice.methodDetailId,
      ),
      onSelectPaymentMethode: (paymentMethode) {
        model.shipment.shipmentInvoice.methodId = paymentMethode.methodId;
        model.shipment.shipmentInvoice.methodCode =
            paymentMethode.methodDetailCode;
        model.shipment.shipmentInvoice.methodName =
            paymentMethode.methodDetailName;
        model.shipment.shipmentInvoice.methodDetailId =
            paymentMethode.methoDetailId;
        model.shipment.shipmentInvoice.methodDetailName =
            paymentMethode.methodDetailName;
        model.shipment.shipmentInvoice.methodDetailCode =
            paymentMethode.methodDetailCode;
        model.shipment.shipmentInvoice.methodDetailIpay88Id =
            paymentMethode.ipay88Id;
        model.shipment.shipmentInvoice.bankIconUrl = paymentMethode.iconUrl;
        model.commit();
      },
    );
  },
  RouteName.paymentGateWayPage: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel shipment = arg[ParamName.AngkutShipmentModel];
    return paymentGateWayPage.Presenter(
      view: paymentGateWayPage.AngkutView(),

      onTapViewOrder: () {
        System.data.routes.pushNamedAndRemoveUntil(
            context, RouteName.history, RouteName.dashboard);
      },
      paymentUrl: System.data.apiEndPointUtil.getPaymentGateWayPage(
        shipmentId: shipment.tmsShipmentId,
        methodeId: shipment.shipmentInvoice.methodDetailIpay88Id,
      ),
      // paymentUrl:
      //     "http://dev.enerren.com/AngkutPaymentGateway/Ipay88Payment/Index?shipmentId=6&payMethodId=",
    );
  },
  RouteName.inputPhoneNumber: (BuildContext context) {
    return inputPhoneNumber.Presenter(
      view: inputPhoneNumber.CustomerView(),
      onSubmitSuccess: (rawData) {
        NavigationUtil.navTo(
          context,
          verification.Presenter(
            view: verification.CustomerChangePhoneNumberView(),
            sentSms: false,
            withTimer: true,
            verificationCode: json.decode(rawData)["otpCode"],
            scurePhoneNUmber: true,
            duration: Duration(seconds: 60),
            phoneNumber: json.decode(rawData)["sendTo"],
            obscureText: true,
            onVerificationValid: (otp) {
              System.data.getLocal<LocalData>().user.customerMobile =
                  json.decode(rawData)["sendTo"];
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        );
      },
      // System.data.routes.pushNamed(
      //   context,
      //   RouteName.verificationChangePhoneNumber,
      //   arguments: {
      //     ParamName.PhoneNumber: json.decode(rawData)[""],
      //     ParamName.Otp: json.decode(rawData)[""],
      //   },
      // );
      // },
    );
  },
  RouteName.verificationChangePhoneNumber: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return verification.Presenter(
      view: verification.CustomerChangePhoneNumberView(),
      sentSms: false,
      duration: Duration(
        seconds: 30,
      ),
      withTimer: true,
      phoneNumber: arg[ParamName.PhoneNumber],
      onVerificationValid: (json) {
        System.data.getLocal<LocalData>().user = CustomerModel.fromJson(json);
        System.data.routes.pop(context);
      },
    );
  },
  RouteName.ratingDriver: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    AngkutShipmentModel shipment = arg[ParamName.AngkutShipmentModel];
    return ratingDriver.Presenter(
      view: ratingDriver.AngkutView(),
      customerNo: shipment.customerId.toString(),
      driverId: shipment.tmsShipmentDestinationList.first.driverId,
      driverImageUrl: shipment.tmsShipmentDestinationList.first.driverImageUrl,
      driverName: shipment.tmsShipmentDestinationList.first.driverName,
      driverNik: shipment.tmsShipmentDestinationList.first.driverId.toString(),
      shipmentId: shipment.tmsShipmentId,
      onSubmitSuccess: () {
        System.data.routes.pushNamedAndRemoveUntil(
          context,
          RouteName.dashboard,
          "",
        );
      },
    );
  },
  RouteName.voucherList: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments;
    confirm.ViewModel viewModel = arg[ParamName.ConfirmViewModel];
    return voucherList.Presenter(
      onSelected: (voucher) {
        System.data.routes
            .pushNamed(context, RouteName.voucherDetail, arguments: {
          ParamName.Voucher: voucher,
          ParamName.ConfirmViewModel: viewModel,
        });
      },
    );
  },
  RouteName.voucherDetail: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments;
    confirm.ViewModel viewModel = arg[ParamName.ConfirmViewModel];
    TmsVoucherModel voucher = arg[ParamName.Voucher];
    return voucherDetail.Presenter(
      view: voucherDetail.AngkutView(
        shipmentModel: viewModel.shipment,
        onApply: (wngkutShipmentModel) {
          viewModel.shipment = wngkutShipmentModel;
          viewModel.commit();
        },
      ),
      voucher: voucher,
      onApplay: () {
        System.data.routes.pop(context);
        System.data.routes.pop(context);
      },
    );
  }
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
