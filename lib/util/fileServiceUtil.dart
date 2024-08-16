import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as fileUtil;
import 'package:path_provider/path_provider.dart';
import 'package:enerren/model/FileModel.dart' as model;

typedef void OnDownloadProgressCallback(int receivedBytes, int totalBytes);
typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

class FileServiceUtil {
  // static String baseUrl = ;

  static bool trustSelfSigned = true;

  static HttpClient getHttpClient() {
    HttpClient httpClient = new HttpClient()
          ..connectionTimeout = const Duration(seconds: 10)
        // ..badCertificateCallback =
        //     ((X509Certificate cert, String host, int port) => trustSelfSigned)
        ;

    return httpClient;
  }

  static fileGetAllMock() {
    return List.generate(
      20,
      (i) => model.FileModel(
          fileName: 'filename $i.jpg',
          dateModified: DateTime.now().add(Duration(minutes: i)),
          size: i * 1000),
    );
  }

  static Future<List<model.FileModel>> fileGetAll({
    @required String url,
  }) async {
    var httpClient = getHttpClient();

    // final url = '$baseUrl/api/file';
    // final url = '$url';

    var httpRequest = await httpClient.getUrl(Uri.parse(url));

    var httpResponse = await httpRequest.close();

    var jsonString = await readResponseAsString(httpResponse);

    return model.fileFromJson(jsonString);
  }

  static Future<String> fileDelete(
    String fileName, {
    @required String url,
  }) async {
    var httpClient = getHttpClient();

    // final url = Uri.encodeFull('$baseUrl/api/file/$fileName');

    var httpRequest = await httpClient.deleteUrl(Uri.parse(url));

    var httpResponse = await httpRequest.close();

    var response = await readResponseAsString(httpResponse);

    return response;
  }

  static Future<String> fileUpload({
    File file,
    OnUploadProgressCallback onUploadProgress,
    @required String url,
  }) async {
    assert(file != null);

    // final url = '$baseUrl/api/file';

    final fileStream = file.openRead();

    int totalByteLength = file.lengthSync();

    final httpClient = getHttpClient();

    final request = await httpClient.postUrl(Uri.parse(url));

    request.headers.set(HttpHeaders.contentTypeHeader, ContentType.binary);

    request.headers.add("filename", fileUtil.basename(file.path));

    request.contentLength = totalByteLength;

    int byteCount = 0;
    Stream<List<int>> streamUpload = fileStream.transform(
      new StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }

          sink.add(data);
        },
        handleError: (error, stack, sink) {
          print(error.toString());
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();

    if (httpResponse.statusCode != 200) {
      throw Exception('Error uploading file');
    } else {
      return await readResponseAsString(httpResponse);
    }
  }

  static Future<String> fileUploadMultipart({
    String field,
    File file,
    OnUploadProgressCallback onUploadProgress,
    @required String url,
    String token,
  }) async {
    assert(file != null);

    // final url = '$baseUrl/api/file';

    final httpClient = getHttpClient();

    final request = await httpClient.postUrl(
      Uri.parse(url),
    );

    int byteCount = 0;

    var multipart = await http.MultipartFile.fromPath(
        field ?? fileUtil.basename(file.path), file.path);

    // final fileStreamFile = file.openRead();

    // var multipart = MultipartFile("file", fileStreamFile, file.lengthSync(),
    //     filename: fileUtil.basename(file.path));

    var requestMultipart = http.MultipartRequest(
      "",
      Uri.parse("uri"),
    );

    requestMultipart.files.add(multipart);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader]);

    request.headers.set(HttpHeaders.authorizationHeader, token);

    Stream<List<int>> streamUpload = msStream.transform(
      new StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();
//
    var statusCode = httpResponse.statusCode;

    if (statusCode ~/ 100 != 2) {
      throw Exception(
          'Error uploading file, Status code: ${httpResponse.statusCode}');
    } else {
      return await readResponseAsString(httpResponse);
    }
  }

  static Future<String> byteDataUploadMultipart({
    String field,
    ByteData byteData,
    OnUploadProgressCallback onUploadProgress,
    @required String url,
    String token,
  }) async {
    assert(byteData != null);

    // final url = '$baseUrl/api/file';
    ModeUtil.debugPrint("upload url : $url");

    final httpClient = getHttpClient();

    final request = await httpClient.postUrl(
      Uri.parse(url),
    );

    int byteCount = 0;

    var multipart = http.MultipartFile.fromBytes(
      field ?? "file",
      byteData.buffer.asInt8List(),
    );

    // final fileStreamFile = file.openRead();

    // var multipart = MultipartFile("file", fileStreamFile, file.lengthSync(),
    //     filename: fileUtil.basename(file.path));

    var requestMultipart = http.MultipartRequest(
      "",
      Uri.parse("uri"),
    );

    requestMultipart.files.add(multipart);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader]);

    request.headers.set(HttpHeaders.authorizationHeader, token);

    Stream<List<int>> streamUpload = msStream.transform(
      new StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();
//
    var statusCode = httpResponse.statusCode;

    if (statusCode ~/ 100 != 2) {
      throw Exception(
          'Error uploading file, Status code: ${httpResponse.statusCode}');
    } else {
      return await readResponseAsString(httpResponse);
    }
  }

  static Future<String> fileDownload({
    String fileName,
    OnUploadProgressCallback onDownloadProgress,
    @required String url,
  }) async {
    assert(fileName != null);

    // final url = Uri.encodeFull('$baseUrl/api/file/$fileName');

    final httpClient = getHttpClient();

    final request = await httpClient.getUrl(Uri.parse(url));

    request.headers
        .add(HttpHeaders.contentTypeHeader, "application/octet-stream");

    var httpResponse = await request.close();

    int byteCount = 0;
    int totalBytes = httpResponse.contentLength;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    //appDocPath = "/storage/emulated/0/Download";

    File file = new File(appDocPath + "/" + fileName);

    var raf = file.openSync(mode: FileMode.write);

    Completer completer = new Completer<String>();

    httpResponse.listen(
      (data) {
        byteCount += data.length;

        raf.writeFromSync(data);

        if (onDownloadProgress != null) {
          onDownloadProgress(byteCount, totalBytes);
        }
      },
      onDone: () {
        raf.closeSync();

        completer.complete(file.path);
      },
      onError: (e) {
        raf.closeSync();
        file.deleteSync();
        completer.completeError(e);
      },
      cancelOnError: true,
    );

    return completer.future;
  }

  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = new Completer<String>();
    var contents = new StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
