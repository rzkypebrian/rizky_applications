import 'package:enerren/module/menuList/presenter.dart';
import 'main.dart';

mixin MaintenanceMenuPresenter on PresenterState {
  ViewModel viewModel = ViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.controller.stopLoading();
  }
}
