import 'presenter.dart';

mixin ReadOnlyPresenter on PresenterState {
  @override
  void getAtttendanceList() {
    return;
  }

  @override
  void submit() {
    model.loadingController.startLoading();
    if (widget.onSubmited != null) {
      widget.onSubmited(model.attendanceModel);
    }
    model.loadingController.stopLoading();
  }
}
