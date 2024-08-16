import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:enerren/component/dateTImePicker.dart' as dateTimePicker;
import 'package:enerren/util/ModeUtil.dart';

// TypeInput.date
// context required
class InputData {
  static Widget inputData<T>({
    BuildContext context,
    String title,
    double widTitle = 120,
    InputComponentTextEditingController controller,
    String valueString,
    TypeInput typeInput = TypeInput.Text,
    TextInputType keyboardType = TextInputType.text,
    List<T> list,
    T selectedItem,
    ValueChanged<T> onChangeds,
    bool obscureText = false,
    Widget sufix,
    Widget prefix,
    String hint,
    dateTimePicker.PickerMode pickerMode = dateTimePicker.PickerMode.Date,
    double borderWidth = 1,
    Color colorBorder,
    DateTime initialDate,
    bool isBorder = true,
    EdgeInsetsGeometry contentPadding,
    bool getNames = true,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title != null
              ? Container(
                  width: widTitle,
                  margin: EdgeInsets.only(right: 5),
                  child: Text(
                    toBeginningOfSentenceCase("$title"),
                    textAlign: TextAlign.start,
                    style: System.data.textStyleUtil
                        .mainLabel(fontWeight: FontWeight.w500),
                  ),
                )
              : Container(),
          Expanded(
            child: Container(
              child: typeInput == TypeInput.Strings
                  ? Text(
                      toBeginningOfSentenceCase("$valueString"),
                      textAlign: TextAlign.start,
                      style: System.data.textStyleUtil
                          .mainLabel(fontWeight: FontWeight.w500),
                    )
                  : typeInput == TypeInput.Text
                      ? InputComponent.inputTextWithCorner(
                          // isBorder: isBorder,
                          controller: controller,
                          obscureText: obscureText,
                          keyboardType: keyboardType,
                          corner: 2,
                          onChanged: (string) {
                            onChangeds(string as T);
                          },
                          borderWidth: borderWidth,
                          contentPadding:
                              contentPadding ?? EdgeInsets.only(left: 10),
                          suffixIcon: sufix,
                          prefixIcon: prefix,
                          hintText: hint,
                        )
                      : typeInput == TypeInput.Number
                          ? InputComponent.inputTextWithCorner(
                              controller: controller,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              fontSize: System.data.fontUtil.xl,
                              numberOnly: true,
                              contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                            )
                          : typeInput == TypeInput.Date
                              ? InputComponent.inputTextWithCorner(
                                  // isBorder: isBorder,
                                  controller: controller,
                                  obscureText: obscureText,
                                  keyboardType: keyboardType,
                                  corner: 2,
                                  borderWidth: borderWidth,
                                  onChanged: (string) {
                                    onChangeds(string as T);
                                  },
                                  contentPadding: contentPadding ??
                                      EdgeInsets.only(left: 10),
                                  suffixIcon: GestureDetector(
                                    onTap: () => dateTimePicker
                                        .showDateTimePicker(
                                      context,
                                      datePickerSetting:
                                          dateTimePicker.DatePickerSetting(
                                        initialDate:
                                            initialDate ?? DateTime.now(),
                                        selectorColor:
                                            System.data.colorUtil.primaryColor,
                                        cancleTextStyle:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                        okTextStyle:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                        backgroundHeader:
                                            System.data.colorUtil.primaryColor,
                                        currentDateColor:
                                            System.data.colorUtil.primaryColor,
                                      ),
                                      timePickerSetting:
                                          dateTimePicker.TimePickerSetting(
                                        initialTime: TimeOfDay.fromDateTime(
                                            initialDate ?? DateTime.now()),
                                        headerBackgroundColor:
                                            System.data.colorUtil.primaryColor,
                                        cancelBtnStyle:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                        okBtnStyle:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                        selcetorColor:
                                            System.data.colorUtil.primaryColor,
                                      ),
                                      mode: pickerMode,
                                    )
                                        .then((value) {
                                      if (pickerMode ==
                                          dateTimePicker.PickerMode.Date)
                                        controller.text =
                                            "${DateFormat("yyyy-MM-dd", System.data.resource.dateLocalFormat).format(value)}";
                                      else
                                        controller.text =
                                            "${DateFormat("yyyy-MM-dd H:m:s ", System.data.resource.dateLocalFormat).format(value)}";
                                      ModeUtil.debugPrint(
                                          "dateTimePicker.showDateTimePicker result $value");
                                    }).catchError((e) {
                                      ModeUtil.debugPrint(
                                          "dateTimePicker.showDateTimePicker error $e");
                                    }),
                                    child: sufix,
                                  ),
                                  hintText: hint,
                                )
                              : InputComponent.dropDownWithCorner<T>(
                                  corner: 2,
                                  items: List.generate(list.length, (i) {
                                    return DropdownMenuItem<T>(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          toBeginningOfSentenceCase(
                                            "${getNames ? getName(list[i]) : list[i]}",
                                          ),
                                        ),
                                      ),
                                      value: list[i],
                                    );
                                  }),
                                  value: selectedItem,
                                  onChangeds: (v) => onChangeds(v),
                                  hint: hint,
                                  icons: Container(
                                    width: 31,
                                    padding: EdgeInsets.only(
                                        top: 14, bottom: 14, left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        color:
                                            System.data.colorUtil.primaryColor),
                                    child: Icon(
                                      FontAwesomeSolid(
                                          FontAwesomeId.fa_chevron_down),
                                      color:
                                          System.data.colorUtil.secondaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
            ),
          ),
        ],
      ),
    );
  }

  static dynamic getName(dynamic a) {
    if (a.runtimeType.toString() == "ProductModel")
      return a.productName;
    else
      return a.name;
  }
}

enum TypeInput { Text, Dropdown, Strings, Date, Number }
