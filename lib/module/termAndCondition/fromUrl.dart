import 'package:webview_flutter/webview_flutter.dart';

import 'view.dart';
import 'package:flutter/material.dart';

class FromUrl extends View {
  String url;

  FromUrl({
    this.url,
  });

  @override
  Widget mainContent() {
    return Container(
      child: WebView(
        initialUrl: url ?? "https://www.google.com/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
