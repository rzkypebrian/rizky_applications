import 'package:flutter/material.dart';
import 'custom/date_picker_custom.dart' as datePicker;
import 'custom/time_picker_custom.dart' as timePicker;

Future<DateTime> selectDate(
    BuildContext context, DatePickerSetting setting) async {
  final DateTime picked = await datePicker.showDatePicker(
      context: context,
      backgroundHeader: setting.backgroundHeader,
      backgroundColor: setting.backgroundColor,
      initialDate: setting.initialDate ?? DateTime.now(),
      firstDate: setting.firstDate ?? DateTime(1990),
      lastDate: setting.lastDate ?? DateTime(9999),
      builder: setting.builder,
      cancleText: setting.cancleText,
      cancleTextStyle: setting.cancleTextStyle,
      currentDateColor: setting.currentDateColor,
      currentDateStyle: setting.currentDateStyle,
      dayColor: setting.dayColor,
      dayStyles: setting.dayStyles,
      iconBack: setting.iconBack,
      iconBackColor: setting.iconBackColor,
      iconNext: setting.iconNext,
      iconNextColor: setting.iconNextColor,
      initialDatePickerMode: setting.initialDatePickerMode,
      locale: setting.locale,
      okText: setting.okText,
      okTextStyle: setting.okTextStyle,
      selectableDayPredicate: setting.selectableDayPredicate,
      selectorColor: setting.selectorColor,
      textDirection: setting.textDirection,
      textHeaderColor: setting.textHeaderColor,
      textHeaderStyle: setting.textHeaderStyle,
      textItemColor: setting.textItemColor,
      textItemStyle: setting.textItemStyle,
      textMountColor: setting.textMountColor,
      textMountStyle: setting.textMountStyle,
      textSelectedColor: setting.textSelectedColor,
      textSelectedStyle: setting.textSelectedStyle,
      yearColor: setting.yearColor,
      yearStyles: setting.yearStyles);
  return picked;
}

Future<TimeOfDay> selectTime(
    BuildContext context, TimePickerSetting setting) async {
  final TimeOfDay picked = await timePicker.showTimePicker(
    context: context,
    use24HourDials: setting.use24HourDials ?? true,
    headerBackgroundColor: setting.headerBackgroundColor,
    selcetorColor: setting.selcetorColor,
    initialTime: setting.initialTime ?? new TimeOfDay(hour: 0, minute: 0),
    backgroundColor: setting.backgroundColor,
    builder: setting.builder,
    cancelBtnStyle: setting.cancelBtnStyle,
    cancelBtnTitle: setting.cancelBtnTitle,
    headerActiveColor: setting.headerActiveColor,
    headerInActiveColor: setting.headerInActiveColor,
    labelStyle: setting.labelStyle,
    okBtnStyle: setting.okBtnStyle,
    okBtnTitle: setting.okBtnTitle,
    pickerBackgroundColor: setting.pickerBackgroundColor,
  );
  return picked;
}

Future<DateTime> showDateTimePicker(
  BuildContext context, {
  PickerMode mode,
  DatePickerSetting datePickerSetting,
  TimePickerSetting timePickerSetting,
}) async {
  DateTime date;
  datePickerSetting = datePickerSetting ?? new DatePickerSetting();
  timePickerSetting = timePickerSetting ?? new TimePickerSetting();

  if (mode == PickerMode.Date || mode == PickerMode.DateTime) {
    await selectDate(context, datePickerSetting).then((onValue) {
      date = onValue;
    });
  }

  if (mode == PickerMode.Time || mode == PickerMode.DateTime) {
    await selectTime(context, timePickerSetting).then((onValue) {
      date = date ?? new DateTime(0, 0, 0);
      date = new DateTime(
          date.year, date.month, date.day, onValue.hour, onValue.minute);
    });
  }

  return date;
}

class DatePickerSetting {
  final BuildContext context;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final SelectableDayPredicate selectableDayPredicate;
  final datePicker.DatePickerMode initialDatePickerMode =
      datePicker.DatePickerMode.day;
  final Locale locale;
  final TextDirection textDirection;
  final TransitionBuilder builder;
  final Color backgroundColor;
  final TextStyle cancleTextStyle;
  final TextStyle okTextStyle;
  final String okText;
  final String cancleText;
  final Color backgroundHeader;
  final Color dayColor;
  final TextStyle dayStyles;
  final Color yearColor;
  final TextStyle yearStyles;
  final IconData iconBack;
  final Color iconBackColor;
  final IconData iconNext;
  final Color iconNextColor;
  final Color currentDateColor;
  final TextStyle currentDateStyle;
  final Color selectorColor;
  final Color textHeaderColor;
  final TextStyle textHeaderStyle;
  final Color textItemColor;
  final TextStyle textItemStyle;
  final Color textMountColor;
  final TextStyle textMountStyle;
  final Color textSelectedColor;
  final TextStyle textSelectedStyle;

  DatePickerSetting(
      {this.context,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.selectableDayPredicate,
      this.locale,
      this.textDirection,
      this.builder,
      this.backgroundColor,
      this.cancleTextStyle,
      this.okTextStyle,
      this.okText,
      this.cancleText,
      this.backgroundHeader,
      this.dayColor,
      this.dayStyles,
      this.yearColor,
      this.yearStyles,
      this.iconBack,
      this.iconBackColor,
      this.iconNext,
      this.iconNextColor,
      this.currentDateColor,
      this.currentDateStyle,
      this.selectorColor,
      this.textHeaderColor,
      this.textHeaderStyle,
      this.textItemColor,
      this.textItemStyle,
      this.textMountColor,
      this.textMountStyle,
      this.textSelectedColor,
      this.textSelectedStyle});
}

class TimePickerSetting {
  final BuildContext context;
  final TimeOfDay initialTime;
  final TransitionBuilder builder;
  final Color backgroundColor;
  final TextStyle cancelBtnStyle;
  final String cancelBtnTitle;
  final TextStyle okBtnStyle;
  final String okBtnTitle;
  final bool use24HourDials;
  final Color headerActiveColor;
  final Color headerBackgroundColor;
  final Color headerInActiveColor;
  final TextStyle labelStyle;
  final Color pickerBackgroundColor;
  final Color selcetorColor;

  TimePickerSetting(
      {this.context,
      this.initialTime,
      this.builder,
      this.backgroundColor,
      this.cancelBtnStyle,
      this.cancelBtnTitle,
      this.okBtnStyle,
      this.okBtnTitle,
      this.use24HourDials,
      this.headerActiveColor,
      this.headerBackgroundColor,
      this.headerInActiveColor,
      this.labelStyle,
      this.pickerBackgroundColor,
      this.selcetorColor});
}

enum PickerMode {
  Date,

  Time,

  DateTime
}
