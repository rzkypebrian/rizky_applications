import 'dart:io';
import 'dart:math';

import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'view.dart';
import 'viewModel.dart';
import '../../model/ginotaModel.dart' as ginota;

/// module_sbbi_accountVerification
/// verification phone number lewat sms melalui layanan sms cloud ginnota
/// kode verifikasi akan di generate dan dikirim ke ginnota
/// kemudian akan dicocokan dengan kode yang diinput oleh user
///
class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final String apiKey;
  final String apiSecret;
  final String senderName;
  final String phoneNumber;
  final ValueChanged<String> onVerificationValid;
  final VoidCallback onVerificationFailed;
  final bool sentSms;
  final String verificationCode;
  final bool obscureText;
  final bool scurePhoneNUmber;
  final bool withTimer;
  final Duration duration;
  final String bayPassPin;
  final int pinLenght;
  final String address;

  const Presenter({
    Key key,
    this.phoneNumber,
    this.onVerificationValid,
    this.apiKey,
    this.apiSecret,
    this.senderName,
    this.onVerificationFailed,
    this.view,
    this.sentSms = true,
    this.verificationCode,
    this.obscureText = false,
    this.scurePhoneNUmber = false,
    this.withTimer = false,
    this.duration,
    this.bayPassPin,
    this.pinLenght = 6,
    this.address = "INOVATRACK",
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
  String verificationCode = "";
  SmsQuery query = new SmsQuery();
  RegExp regxOtp = new RegExp(
    r"[0-9]{1,6}",
    caseSensitive: false,
    multiLine: false,
  );

  @override
  void initState() {
    super.initState();
    model.loadingController.stopLoading(message: "test error");
    model.ginotaModel = ginota.GinotaModel(
      apiKey: widget.apiKey,
      apiSecret: widget.apiSecret,
    );
    model.loadingController.startLoading();
    model.requestDate = DateTime.now();
    reset();
    sendSms();
    if (widget.withTimer == true) {
      model.timerCountDownController.reset(duration: widget.duration);
      model.timerCountDownController.start(
        onTick: readInbox,
      );
    }
  }

  void setPin(String pin) {
    model.pins[model.activePins] = pin;
    next();
  }

  void readSuggestion(String value) {
    model.activePins = widget.pinLenght - 1;
    model.pin = value;
    for (int i = 0; i < widget.pinLenght; i++) {
      model.pins[i] = value.substring(i, i + 1);
    }
    model.commit();
  }

  void submit() {
    bool valid = true;
    for (var i = 0; i < widget.pinLenght; i++) {
      if (model.pins[i] == null || model.pins[i].isEmpty) {
        model.pinsSate[i] = StateInput.Error;
        valid = false;
      }
    }
    model.commit();
    if (valid) {
      if (readPin() == model.verificationCode ||
          readPin() == widget.bayPassPin) {
        onValid();
      } else {
        onFailed();
      }
    } else {
      return;
    }
  }

  void next() {
    model.pinsSate[model.activePins] = StateInput.Enable;
    model.activePins = (model.activePins + 1) < model.pins.length - 1
        ? model.activePins + 1
        : model.pins.length - 1;
    model.pinsSate[model.activePins] = StateInput.Enable;
    model.commit();
  }

  void onValid() {
    model.loadingController.startLoading();
    if (widget.onVerificationValid != null) {
      widget.onVerificationValid(model.pin);
      model.loadingController.stopLoading();
    } else {
      onVerificationValid();
      model.loadingController.stopLoading();
    }
  }

  void onFailed() {
    model.loadingController.startLoading();
    if (widget.onVerificationFailed != null) {
      widget.onVerificationFailed();
    } else {
      onVerificationFailed();
    }
  }

  void onVerificationValid() {
    ModeUtil.debugPrint("Verification valid");
    model.loadingController.stopLoading();
  }

  void onVerificationFailed() {
    ModeUtil.debugPrint("verification failed");
    model.loadingController
        .stopLoading(message: System.data.resource.incorrectVerificationCode);
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void back() {
    model.pinsSate[model.activePins] = StateInput.Enable;
    if (model.pins[model.activePins] != "") {
      model.pins[model.activePins] = "";
    } else {
      model.activePins =
          (model.activePins - 1) < 0 ? 1 : (model.activePins - 1);
    }
    model.pinsSate[model.activePins] = StateInput.Enable;
    model.commit();
  }

  String readPin() {
    model.pin = "";
    for (int i = 0; i < widget.pinLenght; i++) {
      model.pin = model.pin + "${model.pins[i] ?? ""}";
    }
    return model.pin;
  }

  void reset() {
    model.clearPin(widget.pinLenght);
  }

  void sendSms() {
    if (widget.sentSms) {
      ModeUtil.debugPrint("generate verification code");
      model.verificationCode = widget.verificationCode ?? generateOtpNumber();
      ModeUtil.debugPrint("send sms");
      model.ginotaModel
          .send(ginota.GinotaMessage(
        content:
            "${model.verificationCode} ${System.data.resource.yourVerificationCodeIs}",
        dstAddr: widget.phoneNumber,
        flash: false,
        srcAddr: widget.senderName,
      ))
          .then((onValue) {
        ModeUtil.debugPrint("sms sent");
        model.loadingController.stopLoading();
      }).catchError((onError) {
        ModeUtil.debugPrint("sms sent error ");
        model.loadingController
            .stopLoading(message: "cannot send SMS please try again");
      });
    } else {
      ModeUtil.debugPrint("not set to sent SMS");
      model.verificationCode = widget.verificationCode;
      model.loadingController.stopLoading();
    }
    ModeUtil.debugPrint(model.verificationCode);
  }

  String generateOtpNumber() {
    ModeUtil.debugPrint("get randowm ${widget.pinLenght} digit number");
    String numberString = "";
    var rng = new Random();
    for (var i = 0; i < widget.pinLenght; i++) {
      numberString = "$numberString${rng.nextInt(9)}";
    }
    ModeUtil.debugPrint("verification code id $numberString ");
    return numberString;
  }

  String secureNumber(String phoneNumber) {
    var re = RegExp(r'\d(?!\d{0,2}$)');
    return phoneNumber.replaceAll(re, "*");
  }

  void resend() {
    return ModeUtil.debugPrint("resend() override this fuction");
  }

  void onSmsReceived(String message) {
    print("message received $message");
  }

  void onTimeout() {
    setState(() {
      print("message received timeout");
    });
  }

  void readInbox() {
    if (Platform.isAndroid) {
      if (widget.address != null && widget.address.isNotEmpty) {
        query.querySms(
          address: widget.address,
          count: 1,
          kinds: [SmsQueryKind.Inbox],
        ).then(
          (value) {
            if (value.isNotEmpty) {
              if (value.first.date.isAfter(model.requestDate)) {
                if (regxOtp.hasMatch(value.first.body)) {
                  model.pinSugest = [
                    regxOtp.stringMatch(value.first.body).toString()
                  ];
                  model.commit();
                }
              }
            }
          },
        );
      }
    }
  }
}
