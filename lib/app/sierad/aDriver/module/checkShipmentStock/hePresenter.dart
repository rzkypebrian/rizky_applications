import 'presenter.dart';

mixin HePresenter on PresenterState {
  @override
  bool validate() {
    bool isValid = true;
    isValid = validateNumberOfDoc() ?? isValid;
    isValid = validateNumberOfDead() ?? isValid;
    isValid = validateNumberOfBox() ?? isValid;
    return isValid;
  }
}
