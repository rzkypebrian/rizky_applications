import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback gotoProfile;
  final String iconAdminContact;
  final String iconPhone;
  final String adminPhoneNumber;
  final String iconMessage;
  final String adminWhatsAppNumber;
  final String iconTransporterContact;
  final String transporterPhoneNumber;
  final String transporterWhatsAppNumber;
  final Color iconAdminContactColor;
  final Color iconTransporterContactColor;
  final Color iconPhoneColor;
  final Color iconMessageColor;
  final bool showAdminContact;
  final bool showTransporterContact;

  const Presenter({
    Key key,
    this.view,
    this.gotoProfile,
    this.iconAdminContact,
    this.iconPhone,
    this.adminPhoneNumber,
    this.iconMessage,
    this.adminWhatsAppNumber,
    this.iconTransporterContact,
    this.transporterPhoneNumber,
    this.transporterWhatsAppNumber,
    this.iconAdminContactColor,
    this.iconTransporterContactColor,
    this.iconPhoneColor,
    this.iconMessageColor,
    this.showAdminContact = true,
    this.showTransporterContact = true,
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
  var tick = 1;
  var profile = ProfileModel.dummy();

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  FlareController flare1;

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }

  void gotoProfile(BuildContext context) {
    if (widget.gotoProfile != null) {
      widget.gotoProfile();
    }
  }
}
