import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter_native_html_view/flutter_native_html_view.dart';

import 'view.dart';
import 'package:flutter/material.dart';
import 'fromHtmlPresenter.dart';

class Fromhtml extends View with FromHtmlPresenter {
  String htmlSource;
  SourceType sourceType;

  Fromhtml({
    this.htmlSource,
    this.sourceType = SourceType.Text,
  });

  @override
  Widget mainContent() {
    switch (sourceType) {
      case SourceType.Text:
        return showHtml(htmlSource ?? "<br><hallo word</b>");
        break;
      case SourceType.Asset:
        return FutureBuilder<String>(
          future: super.loadAsset(htmlSource),
          initialData: System.data.resource.loading,
          builder: (crx, snapshoot) {
            return showHtml(snapshoot.data);
          },
        );
        break;

      default:
        return Container();
        break;
    }
  }

  Widget showHtml(String html) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: FlutterNativeHtmlView(
        htmlData: html,
        onLinkTap: (String url) {
          print(url);
        },
        onError: (String message) {
          print(message);
        },
      ),
    );
  }
}

enum SourceType {
  Asset,
  Text,
}
