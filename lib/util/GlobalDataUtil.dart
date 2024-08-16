import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/RegisterModel.dart';
import 'package:enerren/model/serchShipmentNumberHistory.dart';
import 'package:enerren/module/chat/viewModel.dart' as chat;

class GlobalDataUtil {
  String token = "";
  String getAppleEmail = "";
  String getAppleName = "";
  int pin;
  AccountModel newAccount = new AccountModel();
  String mmassagingToken = "";
  String googleMapApiKey = "AIzaSyBE996CIxSciAsuAPanJ3izkguREa6VvYA";
  int intervalUpdateMaps = 30;
  int intervalUpdateData = 10;
  List<SerchShipmentNumberHistory> historyReceiptSearch = [];
  Map<int, chat.ViewModel> chatsViewModel = {};
  RegisterModel registerModel;

  String circularProgressIndicatorAnimatorAssets;
  String circularProgressIndicatorAnimatorLightAssets;
  String circularProgressIndicatorAnimation;

  String splascreenAnimationAssets;
  String splasscreenAnimationName;
  bool splascreenAnimationAutoStart;
  Duration splascreenAutoStartDuration;

  String companyVerticalLogoAssets;
  String companyHorizontalLogoAssets;

  String otpAddressSource;

  GlobalDataUtil();
}
