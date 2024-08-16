import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  String headOfficeImage;
  String headOfficeAddress;
  double headOfficeLat;
  double headOfficeLon;
  List<String> headOfficePhone;
  String headOfficeFax;
  List<String> headOfficeWhatsAppNumber;
  List<String> headOfficeEmail;

  ViewModel({
    this.headOfficeImage,
    this.headOfficeAddress,
    this.headOfficeLat,
    this.headOfficeLon,
    this.headOfficePhone,
    this.headOfficeFax,
    this.headOfficeWhatsAppNumber,
    this.headOfficeEmail,
  });
}
