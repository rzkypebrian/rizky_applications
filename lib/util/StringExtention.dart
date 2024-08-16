import 'dart:convert';

extension StringExtenction on String {
  bool isNullOrEmpty() {
    if (this == null) {
      return true;
    } else if (this.isEmpty) {
      return true;
    }
    return false;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  Map<String, dynamic> decode() {
    return json.decode(this);
  }

  int get width {
    LineSplitter _ls = new LineSplitter();
    List<String> _strings = _ls.convert(this);
    int _width = 0;
    for (var str in _strings) {
      if (str.trim().length > _width) {
        _width = str.trim().length;
      }
    }
    return _width;
  }
}
