import 'presenter.dart';

mixin BasketPresenter on PresenterState {
  @override
  void initState() {
    // numberOfDocDeadController.content = "0";
    super.initState();
  }

  @override
  bool validate() {
    bool isValid = true;
    // isValid = validateNumberOfDoc() ?? isValid;
    // isValid = validateNumberOfDead() ?? isValid;
    // isValid = validateNumberOfBonus() ?? isValid;
    isValid = validateNumberOfBox() ?? isValid;
    return isValid;
  }
}
