import 'package:flutter/widgets.dart';

import 'view.dart';

mixin HeViewGeneral on View {
  @override
  Widget grade() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget vaksin() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget numberOfBonusDelivery() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget bonusReceived() {
    return Container(
      height: 0,
      width: 0,
    );
  }
}

class HeView extends View with HeViewGeneral {}
