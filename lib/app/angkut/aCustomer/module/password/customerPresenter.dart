import 'package:enerren/app/angkut/module/password/angkutPresenter.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';

mixin CustomerPresenter on AngkutPresenter {
  @override
  void createNewPassword() {
    loadingController.startLoading();
    //read password inser to register account
    ModeUtil.debugPrint("read password inser to new account");
    System.data.global.registerModel.password = newPasswordController.text;
    System.data.global.registerModel.confirmPassword =
        confirmPasswordController.text;
    //send register to server
    ModeUtil.debugPrint(System.data.global.registerModel.toJson());
    AccountModel.register(
      registerModel: System.data.global.registerModel,
    ).then((onValue) {
      if (widget.onSubmitSuccess != null) {
        widget.onSubmitSuccess(onValue);
      }
      loadingController.startLoading();
    }).catchError((onError) {
      onSubmitError(onError);
    });
  }
}
