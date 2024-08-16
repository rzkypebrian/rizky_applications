import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Home Module"),
            Container(
                width: 300,
                margin: EdgeInsets.only(top: 10),
                child: TextFormField(
                    controller: nama,
                    keyboardType: TextInputType.number,
                    onChanged: (a) => onChange(nama),
                    inputFormatters: [NumericTextFormatter()]))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          ModeUtil.debugPrint("masuk sini");
          widget.onTapModule();
        },
      ),
    );
  }
}

class NumericTextFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = new NumberFormat("#,###", System.data.resource.locale);
      int num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(num);
      return new TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
