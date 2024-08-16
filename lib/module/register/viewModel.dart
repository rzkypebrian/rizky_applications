import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/foundation.dart';

class ViewModel extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  String name;
  String phone;
  String email;
  DateTime birthdate;
  String address;
  bool selected;
  bool phoneNumberPaternInValid;
  bool emailPaternInValid;
  bool isAgree;

  ViewModel({
    this.name,
    this.email,
    this.phone,
    this.birthdate,
    this.address,
    this.selected,
    this.phoneNumberPaternInValid,
    this.emailPaternInValid,
    this.isAgree = false,
  });

  Map<String, dynamic> toJson() => {
        "name": "$name",
        "email": "$email",
        "phone": "$phone",
        "birthday": "$birthdate",
        "address": "$address",
      };

  static ViewModel dummy() {
    return ViewModel(
      name: "Sagita",
      phone: "082386858984",
      email: "sagita@gmail.com",
      birthdate: DateTime(2019, 10, 12),
    );
  }

  void commit() {
    notifyListeners();
  }
}
