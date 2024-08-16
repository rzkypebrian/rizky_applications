import 'package:enerren/util/InternalDataUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataConponent {
  static Widget internalDataConsumer(
    Widget Function(BuildContext, InternalDataUtil, Widget) builder,
  ) {
    return Consumer<InternalDataUtil>(
      builder: builder,
    );
  }
}
