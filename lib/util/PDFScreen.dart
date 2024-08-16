import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:intl/intl.dart';

class PDFScreen extends StatelessWidget {
  final String pathPDF;
  final String title;
  PDFScreen({
    this.pathPDF,
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text(toBeginningOfSentenceCase("$title")),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}