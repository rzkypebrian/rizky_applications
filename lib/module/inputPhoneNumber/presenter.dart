import 'package:enerren/component/InputComponent.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<String> onSubmitSuccess;

  const Presenter({
    Key key,
    this.onSubmitSuccess,
    this.view,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();

  @override
  void initState() {
    model.loadingController.stopLoading();
    super.initState();
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  bool validatePhoneNumber() {
    print("youre phone ${model.phoneController.text}");
    if (model.phoneController.text.isEmpty || model.validPhone == false) {
      model.phoneState = StateInput.Error;
      model.commit();
      return false;
    } else {
      model.phoneState = StateInput.Enable;
      model.commit();
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validatePhoneNumber() ?? isValid;
    return isValid;
  }

  void submit() {
    if (!validate()) return;
    model.loadingController.startLoading();
    if (widget.onSubmitSuccess != null) {
      widget.onSubmitSuccess(model.phoneController.text);
    } else {
      print("phone number is ${model.phoneController.text}");
    }
  }
}
