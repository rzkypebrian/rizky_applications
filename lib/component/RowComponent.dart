import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class RowComponent {
  static Widget rowTitleValue({
    dynamic title,
    dynamic value,
    EnumTypeFormat enumTypeFormatValue = EnumTypeFormat.String,
    EnumTypeFormat enumTypeFormatTitle = EnumTypeFormat.String,
    ValueChanged<dynamic> valueChanged,
    double widthTitle = 90,
    double widthValue = 90,
    bool statusWidgetCenter = false,
    bool titleAsValue = false,
    Widget widgetCenter,
    Decoration decorationTitle,
    Decoration decorationValue,
    Color colorTitle,
    Color colorValue,
    EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 13),
    EdgeInsetsGeometry paddingTitle = const EdgeInsets.all(0),
    EdgeInsetsGeometry paddingValue = const EdgeInsets.all(0),
    TextAlign textAlignTitle = TextAlign.start,
    TextAlign textAlignValue = TextAlign.end,
  }) {
    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          enumTypeFormatTitle == EnumTypeFormat.String
              ? Container(
                  decoration: decorationTitle,
                  width: widthTitle,
                  padding: paddingTitle,
                  child: Text(
                    toBeginningOfSentenceCase("$title"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: colorTitle ?? System.data.colorUtil.darkTextColor,
                      fontWeight:
                          titleAsValue ? FontWeight.normal : FontWeight.w500,
                    ),
                    textAlign: textAlignTitle,
                  ),
                )
              : enumTypeFormatTitle == EnumTypeFormat.List
                  ? Container(
                      width: widthTitle,
                      decoration: decorationTitle,
                      padding: paddingTitle,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: value == null
                            ? []
                            : List.generate(
                                value.length,
                                (index) => Container(
                                      margin: EdgeInsets.only(bottom: 13),
                                      child: Text(
                                        toBeginningOfSentenceCase(
                                            "${title[index].name}"),
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color: colorTitle ??
                                              System
                                                  .data.colorUtil.darkTextColor,
                                        ),
                                        textAlign: textAlignTitle,
                                      ),
                                    )),
                      ),
                    )
                  : enumTypeFormatTitle == EnumTypeFormat.Image
                      ? GestureDetector(
                          onTap: () => valueChanged(value),
                          child: Container(
                            decoration: decorationTitle,
                            width: widthTitle,
                            padding: paddingTitle,
                            child: Image.network(
                              "$title",
                              fit: BoxFit.fitHeight,
                              errorBuilder: (bb, o, st) => Container(
                                width: 28,
                                height: 16,
                                child: SvgPicture.asset(
                                    "assets/tms/erroImage.svg"),
                              ),
                            ),
                          ),
                        )
                      : enumTypeFormatTitle == EnumTypeFormat.Number
                          ? Container(
                              decoration: decorationTitle,
                              width: widthTitle,
                              padding: paddingTitle,
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${NumberFormat("#,###.#", System.data.resource.locale).format(title)}"),
                                style: System.data.textStyleUtil.mainLabel(
                                  color: colorTitle ??
                                      System.data.colorUtil.darkTextColor,
                                ),
                                textAlign: textAlignTitle,
                              ),
                            )
                          : enumTypeFormatTitle == EnumTypeFormat.Date
                              ? Container(
                                  decoration: decorationTitle,
                                  width: widthTitle,
                                  padding: paddingTitle,
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${DateFormat('yyyy-MM-dd').format(title)}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                      color: colorTitle ??
                                          System.data.colorUtil.darkTextColor,
                                    ),
                                    textAlign: textAlignTitle,
                                  ),
                                )
                              : Container(),
          statusWidgetCenter ? widgetCenter : Container(),
          enumTypeFormatValue == EnumTypeFormat.String
              ? Container(
                  decoration: decorationValue,
                  width: widthValue,
                  padding: paddingValue,
                  child: Text(
                    toBeginningOfSentenceCase("$value"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: colorValue ?? System.data.colorUtil.darkTextColor,
                    ),
                    textAlign: textAlignValue,
                  ),
                )
              : enumTypeFormatValue == EnumTypeFormat.List
                  ? Container(
                      decoration: decorationValue,
                      width: widthValue,
                      padding: paddingValue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: value == null
                            ? []
                            : List.generate(
                                value.length,
                                (index) => Container(
                                      margin: EdgeInsets.only(bottom: 13),
                                      child: Text(
                                        toBeginningOfSentenceCase(
                                            "${value[index].name}"),
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color: colorValue ??
                                              System
                                                  .data.colorUtil.darkTextColor,
                                        ),
                                        textAlign: textAlignValue,
                                      ),
                                    )),
                      ),
                    )
                  : enumTypeFormatValue == EnumTypeFormat.Image
                      ? GestureDetector(
                          onTap: () => valueChanged(value),
                          child: Container(
                            decoration: decorationValue,
                            width: widthValue,
                            padding: paddingValue,
                            child: Image.network(
                              "$value",
                              fit: BoxFit.fitHeight,
                              errorBuilder: (bb, o, st) => Container(
                                width: 28,
                                height: 16,
                                child: SvgPicture.asset(
                                    "assets/tms/erroImage.svg"),
                              ),
                            ),
                          ),
                        )
                      : enumTypeFormatValue == EnumTypeFormat.Number
                          ? Container(
                              decoration: decorationValue,
                              width: widthValue,
                              padding: paddingValue,
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${NumberFormat("#,###.#", System.data.resource.locale).format(value)}"),
                                style: System.data.textStyleUtil.mainLabel(
                                  color: colorValue ??
                                      System.data.colorUtil.darkTextColor,
                                ),
                                textAlign: textAlignValue,
                              ),
                            )
                          : enumTypeFormatValue == EnumTypeFormat.Date
                              ? Container(
                                  decoration: decorationValue,
                                  width: widthValue,
                                  padding: paddingValue,
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${DateFormat('yyyy-MM-dd').format(value)}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                      color: colorValue ??
                                          System.data.colorUtil.darkTextColor,
                                    ),
                                    textAlign: textAlignValue,
                                  ),
                                )
                              : Container(),
        ],
      ),
    );
  }
}
