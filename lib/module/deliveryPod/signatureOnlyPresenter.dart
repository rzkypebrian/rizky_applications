import 'package:enerren/main.dart';
import 'package:flutter/material.dart';
import 'signatureOnlyView.dart';
import 'ViewModel.dart';
import 'package:enerren/util/StringExtention.dart';

class SignatureOnlyPresenter extends StatefulWidget {
  final String title;
  final ValueChanged<ViewModel> onSubmit;
  final ViewModel viewModel;
  final State<SignatureOnlyPresenter> view;

  SignatureOnlyPresenter({
    Key key,
    this.title,
    this.onSubmit,
    this.viewModel,
    this.view,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return SignatureOnlyView();
    }
  }
}

abstract class SignatureOnlyPresenterState
    extends State<SignatureOnlyPresenter> {
  ViewModel model = new ViewModel();

  @override
  void initState() {
    model.loadingController.stopLoading();
    if (widget.viewModel != null) {
      model.copyFrom(widget.viewModel);
    }
    super.initState();
  }

  bool validateSignature() {
    model.signatureComponentController.setState(
      () {
        model.isSignatureValid =
            model.signatureComponentController.getBase64.isNullOrEmpty()
                ? false
                : true;
      },
    );
    return model.isSignatureValid == true ? null : false;
  }

  bool validate() {
    bool isValid = true;
    isValid = validateSignature() ?? isValid;
    isValid = loadingController.onLoading ? false : true;
    model.commit();
    return isValid;
  }

  void submit() {
    if (!validate()) return;
    if (widget.onSubmit != null) {
      widget.onSubmit(model);
    }
  }
}
