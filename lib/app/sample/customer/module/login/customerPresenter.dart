import 'package:enerren/module/login/presenter.dart';
import 'package:enerren/util/SystemUtil.dart';

mixin CustomerPresenter on PresenterState {
  @override
  void submit() {
    System.data.versionCheck();
  }
}
