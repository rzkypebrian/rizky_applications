import 'package:enerren/module/splashScreen/presenter.dart';

mixin TmsPresenter on PresenterState {
  @override
  void initState() {
    super.autoStart = true;
    super.initState();
  }
}
