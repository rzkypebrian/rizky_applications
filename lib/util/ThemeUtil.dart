import 'package:enerren/util/FontUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/dateTImePicker.dart' as dateTimePicker;

class ThemeUtil {
  ThemeData primary() {
    return ThemeData(fontFamily: FontUtil().primary);
  }

  ThemeData scondary() {
    return ThemeData(fontFamily: FontUtil().scondary);
  }

  dateTimePicker.DatePickerSetting datePickerTheme({
    DateTime initialDate,
    DateTime firstDate,
  }) {
    return dateTimePicker.DatePickerSetting(
      
      initialDate: initialDate,
      firstDate: firstDate,
    );
  }

  dateTimePicker.TimePickerSetting timePickerTheme() {
    return dateTimePicker.TimePickerSetting();
  }
}
