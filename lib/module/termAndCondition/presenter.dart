import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final String submitTextLabel;
  final VoidCallback onTapSubmit;
  final VoidCallback onTapAgree;
  final VoidCallback onTapDisagree;
  final AgreementMode agreementMode;

  Presenter({
    this.view,
    this.submitTextLabel,
    this.onTapSubmit,
    this.onTapAgree,
    this.onTapDisagree,
    this.agreementMode = AgreementMode.SubmitOnly,
  });

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  //
}

enum AgreementMode {
  AgreeDisagree,
  SubmitOnly,
  CheckForAgree,
}
