import 'package:enerren/component/externalLinkComponent.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback gotoProfile;
  final ViewModel data;
  final double mainContentCorner;
  final double backgroundHeighScala;

  const Presenter(
      {Key key,
      this.view,
      this.gotoProfile,
      this.data,
      this.mainContentCorner,
      this.backgroundHeighScala})
      : super(key: key);

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
    super.initState();
    if (widget.data != null) {
      model = widget.data;
    }
  }

  void openMao() {
    ExternalLinkComponent.openGooleMap(
      lat: model.headOfficeLat,
      lon: model.headOfficeLon,
    );
  }

  void openPhome() {
    ExternalLinkComponent.openPhone(model.headOfficePhone.first);
  }

  void openWa() {
    ExternalLinkComponent.openWA(model.headOfficeWhatsAppNumber.first);
  }

  void openEmail() {
    ExternalLinkComponent.openEmail(model.headOfficeEmail.first);
  }
}
