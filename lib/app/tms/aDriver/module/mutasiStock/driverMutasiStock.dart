import 'package:flutter/material.dart';

import 'main.dart';

class DriverMutasiStock extends View {
  @override
  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            search(vm),
            listMutasi(vm),
          ],
        ),
      ),
    );
  }
}
