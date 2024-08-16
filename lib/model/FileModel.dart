import 'dart:convert';

// USED https://app.quicktype.io/ TO CREATE THIS FILE FROM /api/file GET

List<FileModel> fileFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<FileModel>.from(jsonData.map((x) => FileModel.fromJson(x)));
}

String fileToJson(List<FileModel> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class FileModel {
  String fileName;
  DateTime dateModified;
  int size;

  FileModel({
    this.fileName,
    this.dateModified,
    this.size,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    //print( "Datum: ${json["dateModified"]}");

    return new FileModel(
      fileName: json["fileName"],
      dateModified: DateTime.parse(json["dateModified"]),
      size: json["size"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "dateModified": dateModified,
        "size": size,
      };
}
