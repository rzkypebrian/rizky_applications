import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:enerren/util/DatabaseUtil.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:path_provider/path_provider.dart';
part 'PendingDataModel.g.dart';

@JsonSerializable(explicitToJson: true)
class PendingDataModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "key")
  String key;
  @JsonKey(name: "data_type")
  String dataType;
  @JsonKey(name: "raw_data")
  String rawData;
  @JsonKey(name: "status")
  String status;

  static String get tableName {
    return "pending_data";
  }

  PendingDataModel({
    this.key,
    this.dataType,
    this.rawData,
    this.status,
  });

  factory PendingDataModel.fromJson(Map<String, dynamic> json) {
    return _$PandingDataModelFromJson(json);
  }

  Map<String, dynamic> toJson({String mode}) {
    Map<String, dynamic> _json = _$PandingDataModelToJson(this);
    switch (mode) {
      case "add":
        _json.remove("id");
        break;
      case "update":
        _json.remove("id");
        break;
      default:
        break;
    }
    return _json;
  }

  static Future<void> initializeTable(
    DataBaseUtil dataBaseUtil, [
    int tableVersion,
  ]) async {
    //chek table version
    try {
      if (tableVersion == null) {
        tableVersion = await dataBaseUtil.getTableVersion(tableName);
        print("tabel version is = $tableVersion");
      }
    } catch (e) {
      throw "failed to check table version of panding_data table $e";
    }

    //migration table version
    try {
      switch (tableVersion) {
        case 1:
          await dataBaseUtil.db.rawQuery(createTableQuery());
          tableVersion = 2;
          break;
        default:
          tableVersion = tableVersion;
          break;
      }
    } catch (e) {
      throw "failed for migrate panding_data table $e";
    }

    //update table version to table_migration
    try {
      dataBaseUtil.updateTableVersion(tableName, tableVersion);
    } catch (e) {
      throw "failed for update version info of panding_data table $e";
    }
  }

  static String createTableQuery() {
    return "CREATE TABLE pending_data (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT," +
        "key Varchar(500)," +
        "data_type Varchar(500)," +
        "raw_data TEXT," +
        "status Varchar(200)" +
        ")";
  }

  Future<PendingDataModel> save(DataBaseUtil dataBaseUtil) {
    if (this.id == null) {
      return add(dataBaseUtil).then((value) {
        return value;
      }).catchError((onError) {
        throw onError;
      });
    } else {
      return update(dataBaseUtil, id: this.id).then((value) {
        return value;
      }).catchError((onError) {
        throw onError;
      });
    }
  }

  Future<PendingDataModel> add(DataBaseUtil dataBaseUtil) {
    return dataBaseUtil.db
        .insert(tableName, this.toJson(mode: "add"))
        .then((value) {
      return getById(dataBaseUtil, value).then((value) {
        return value;
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      throw "failed to add panding_data $onError";
    });
  }

  Future<PendingDataModel> update(
    DataBaseUtil dataBaseUtil, {
    int id,
    String key,
    String dataType,
    String rawData,
    String status,
  }) {
    return dataBaseUtil.db
        .update(tableName, this.toJson(mode: "update"),
            where: generateWhere(
              id: id,
              key: key,
              rawData: rawData,
              dataType: dataType,
              status: status,
            ))
        .then((value) {
      return getById(dataBaseUtil, this.id).then((value) {
        return value;
      }).catchError((onError) {
        throw "failed get updated panding_data $onError";
      });
    }).catchError((onError) {
      throw "failed update panding_data $onError";
    });
  }

  Future<bool> remove(DataBaseUtil dataBaseUtil) {
    return dataBaseUtil.db
        .delete(tableName,
            where: generateWhere(
              id: this.id,
              // dataType: this.dataType,
              // key: this.key,
              // rawData: this.rawData,
              // status: this.status,
            ))
        .then((value) {
      return true;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<PendingDataModel> getById(DataBaseUtil dataBaseUtil, int id) {
    return dataBaseUtil.db.query(tableName, where: "id = $id").then((value) {
      if (value.isEmpty) {
        return null;
      } else {
        return PendingDataModel.fromJson(value[0]);
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<PendingDataModel>> get(
    DataBaseUtil dataBaseUtil, {
    int id,
    String key,
    String dataType,
    String status,
    int skip,
    int take,
  }) {
    return dataBaseUtil.db
        .query(
      tableName,
      where: generateWhere(
        id: id,
        key: key,
        dataType: dataType,
        status: status,
      ),
      offset: skip,
      limit: take,
    )
        .then((value) {
      if (value.isEmpty) {
        return <PendingDataModel>[];
      } else {
        return value.map((e) => PendingDataModel.fromJson(e)).toList();
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static String generateWhere({
    int id,
    String key,
    String dataType,
    String rawData,
    String status,
  }) {
    String _where;

    if (id != null) {
      _where = "${!_where.isNullOrEmpty() ? "$_where and " : ""} id='$id'";
    }

    if (!key.isNullOrEmpty()) {
      _where = "${!_where.isNullOrEmpty() ? "$_where and " : ""} key='$key'";
    }

    if (!dataType.isNullOrEmpty()) {
      _where =
          "${!_where.isNullOrEmpty() ? "$_where and " : ""} data_type='$dataType'";
    }

    if (!dataType.isNullOrEmpty()) {
      _where =
          "${!_where.isNullOrEmpty() ? "$_where and " : ""} raw_data='$rawData'";
    }

    if (!status.isNullOrEmpty()) {
      _where =
          "${!_where.isNullOrEmpty() ? "$_where and " : ""} status='$status'";
    }

    return _where;
  }

  Future<PendingDataModel> saveToFile() async {
    try {
      //get directory app
      final Directory _appDocDir = await getApplicationDocumentsDirectory();

      //write directory pending data
      final Directory _appDataFolder =
          Directory("${_appDocDir.path}/data/pending/${this.dataType}");
      if (await _appDataFolder.exists() == false) {
        await _appDataFolder.create(recursive: true);
      }

      //remove all some key
      final files = await _appDataFolder.list(recursive: false).toList();
      var someKey = files
          .where((e) => e.path.split("/").last.split("_").first == this.key)
          .toList();

      for (var file in someKey) {
        await file.delete(recursive: true);
      }

      //create new file
      final File file =
          File("${_appDataFolder.path}/${key}_${this.status}.json");

      print("new file ${file.path}");
      if (await file.exists() == true) {
        file.create(recursive: true);
      }

      file.writeAsString(this.rawData);

      return this;
    } catch (e) {
      throw e;
    }
  }

  Future<PendingDataModel> removeFromFile() async {
    try {
      //get directory app
      final Directory _appDocDir = await getApplicationDocumentsDirectory();

      //write directory pending data
      final Directory _appDataFolder =
          Directory("${_appDocDir.path}/data/pending/${this.dataType}");

      //delete file
      final File file =
          File("${_appDataFolder.path}/${key}_${this.status}.json");

      if (await file.exists() == true) {
        file.delete(recursive: true);
      }

      return this;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<PendingDataModel>> getFromFile({
    String dataType,
    String key,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dir =
          Directory("${directory.path}/data/pending/${dataType ?? ""}/");
      if (await dir.exists()) {
        return readDir(dir, dataType, key);
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<List<PendingDataModel>> readDir(
    Directory dir,
    String dataType,
    String key,
  ) async {
    final files = await dir.list(recursive: false).toList();
    List<PendingDataModel> data = [];
    for (var file in files) {
      if (await FileSystemEntity.isDirectory(file.path) == true) {
        data.addAll(
          await readDir(Directory(file.path), file.path.split("/").last, key),
        );
      } else {
        print(
            "pemding file ${file.path} last : ${file.path.split("/").last.split("_")[0]}");
        if (key.isNullOrEmpty() ||
            file.path.split("/").last.split("_")[0] == key) {
          data.add(
            new PendingDataModel(
              dataType: dataType,
              key: file.path.split("/").last.split("_")[0],
              rawData: await File(file.path).readAsString(),
              status: file.path.replaceAll(".json", "").split("_").last,
            ),
          );
        }
      }
    }
    return data;
  }
}
