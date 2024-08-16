import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/module/setting/main.dart';

mixin DriverPresenter on PresenterState {
  bool statusGoHome = false;
  CircularProgressIndicatorController loadingController =
      CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }
}
