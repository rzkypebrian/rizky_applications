import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

Widget titleValueListItem({
  @required String title,
  @required String value,
}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$title",
          style: System.data.textStyleUtil.mainLabel(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "$value",
          style: System.data.textStyleUtil.mainLabel(),
        )
      ],
    ),
  );
}
