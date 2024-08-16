// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:component_icons/font_awesome.dart';

class BarcodeReaderComponent extends StatelessWidget {
  final BarcodeReaderComponentController controller;

  const BarcodeReaderComponent({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BarcodeReaderComponentValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${value.result}",
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(FontAwesomeRegular(FontAwesomeId.fa_barcode_read)),
                onPressed: () {
                  controller.startBarcodeScanStream();
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class BarcodeReaderComponentValue {
  String result = "";
  Color borderColor;
  bool enable = true;

  BarcodeReaderComponentValue({
    this.result = "",
  });
}

class BarcodeReaderComponentController
    extends ValueNotifier<BarcodeReaderComponentValue> {
  BarcodeReaderComponentController({BarcodeReaderComponentValue value})
      : super(value == null ? BarcodeReaderComponentValue() : value);

  void startBarcodeScanStream({
    Color lineColor = Colors.red,
    String cancelText = "Cancel",
    bool flashIcon = true,
    ValueChanged<String> onResult,
  }) async {
    String barcodeScanRes = "BARCODE SCAN TELAH DI CABUT DARI DEPEDENSI";
    // try {
    //   barcodeScanRes = await BarcodeScanner.scan();
    // } on PlatformException catch (e) {
    //   if (e.code == BarcodeScanner.CameraAccessDenied) {
    //     barcodeScanRes = 'The user did not grant the camera permission!';
    //   } else {
    //     barcodeScanRes = 'Unknown error: $e';
    //   }
    // } on FormatException {
    //   barcodeScanRes =
    //       'null (User returned using the "back"-button before scanning anything. Result)';
    // } catch (e) {
    //   barcodeScanRes = 'Unknown error: $e';
    // }

    value.result = barcodeScanRes;
    if (onResult != null) {
      onResult(value.result);
    }
    notifyListeners();
  }

  String get result {
    return value.result;
  }

  set result(String result) {
    value.result = result;
    notifyListeners();
  }
}
