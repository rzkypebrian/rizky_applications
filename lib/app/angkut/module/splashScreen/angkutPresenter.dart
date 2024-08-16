import 'package:enerren/module/splashScreen/presenter.dart';

mixin AngkutPresenter on PresenterState {
  bool autoStart;

  @override
  void initState() {
    super.autoStart = autoStart ?? false;
    super.initState();
  }
}
