import 'package:flutter/material.dart';

class SizeUtil {
  static double w1(BuildContext context, {double margin = 5}) {
    return MediaQuery.of(context).size.width - margin;
  }

  static double w2(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.width / 2) - margin;
  }

  static double w3(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.width / 3) - margin;
  }

  static double w4(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.width / 4) - margin;
  }

  static double w5(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.width / 5) - margin;
  }

  static double w6(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.width / 6) - margin;
  }

  static double widthDivide(BuildContext context, int divide,
      {double margin = 5}) {
    return (MediaQuery.of(context).size.width / divide) - margin;
  }

  static double widthPercentage(BuildContext context, double percentage,
      {double margin = 5}) {
    return ((percentage / 100) * MediaQuery.of(context).size.width) - margin;
  }

  static double h1(BuildContext context, {double margin = 5}) {
    return MediaQuery.of(context).size.height - margin;
  }

  static double h2(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.height / 2) - margin;
  }

  static double h3(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.height / 3) - margin;
  }

  static double h4(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.height / 4) - margin;
  }

  static double h5(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.height / 5) - margin;
  }

  static double h6(BuildContext context, {double margin = 5}) {
    return (MediaQuery.of(context).size.height / 6) - margin;
  }

  static double hightDivide(BuildContext context, int divide,
      {double margin = 5}) {
    return (MediaQuery.of(context).size.height / divide) - margin;
  }

  static double hightPercentage(BuildContext context, double percentage,
      {double margin = 5}) {
    return ((percentage / 100) * MediaQuery.of(context).size.height) - margin;
  }
}
