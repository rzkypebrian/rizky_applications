import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:http/http.dart' as http;
import 'package:enerren/module/verification/main.dart';

mixin TmsPresenter on PresenterState {
  @override
  void resend() {
    AccountModel.checkAccount(
            username: System.data.global.newAccount.username,
            isResetPassword: false,
            token: "")
        .then((onValue) {
      ModeUtil.debugPrint("new verificationCode ${onValue.otpCode}");
      model.verificationCode = onValue.otpCode;
      model.timerCountDownController.reset();
      model.timerCountDownController.start(onTick: readInbox);
    }).catchError((onError) {
      try {
        http.Response error = onError;
        model.loadingController.stopLoading(
            message:
                "${error.body.isNotEmpty ? error.body : error.statusCode}");
      } catch (e) {
        model.loadingController.stopLoading(message: "$onError");
      }
    });
  }
}
