import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseUtil {
  final String dbName = "DataBase";
  Database db;

  // return the path
  Future<String> checkDb(String dbName, {bool deleteOldDb = false}) async {
    var databasePath = await getDatabasesPath();
    // print(databasePath);
    String path = join(databasePath, dbName);

    // make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      if (deleteOldDb) {
        await deleteDatabase(path);
      }
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  Future<DataBaseUtil> initializeDb({
    bool deleteOldDb = false,
    Function(Database, int) onCreate,
  }) async {
    String path = await checkDb(this.dbName, deleteOldDb: deleteOldDb);
    Database db = await openDatabase(path);
    db.getVersion().then((version) {
      initializeGeneralTable(db, version).then((value) {
        db.setVersion(value);
        onCreate(db, version);
      }).catchError(
        (onError) {
          throw (onError);
        },
      );
    });
    this.db = db;
    return this;
  }

  Future<Database> openConnection() async {
    String path = await checkDb(this.dbName);
    Database db = await openDatabase(path);
    this.db = db;
    return db;
  }

  Future<void> closeConnection() async {
    try {
      return this.db.close().then((onValue) {
        return;
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      throw e;
    }
  }

  //initialize table migration
  Future<int> initializeGeneralTable(Database db, [int dbVersion = 0]) async {
    //initialize generatl tabel by database version
    switch (dbVersion) {
      //initialize jika database masih baru
      case 0:
        try {
          await db.rawQuery(createTableMigration());
          return 1;
        } catch (e) {
          throw e;
        }
        break;
      //return versi database terkini jika tidak ada update
      default:
        return dbVersion;
        break;
    }
  }

  Future<int> updateTableVersion(String tableName, int tableVersion) {
    return db
        .rawUpdate(
            "Update table_migration set table_version = '$tableVersion' where table_name = '$tableName'")
        .then((value) {
      return value;
    }).catchError((onError) {
      throw onError;
    });
  }

  Future<int> getTableVersion(String tableName) async {
    return db
        .rawQuery(
            "SELECT * From table_migration where table_name = '$tableName'")
        .then((value) async {
      int _result = 0;
      if (value.isEmpty) {
        _result = await db.insert("table_migration", {
          "table_name": tableName,
          "table_version": 0,
        });
        return _result;
      } else {
        _result = value[0]["table_version"] as int;
        return _result;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static String createTableMigration() {
    return "CREATE TABLE table_migration (" +
        "table_name Varchar(500) PRIMARY KEY," +
        "table_version int" +
        ")";
  }

  static String dropTableMigration() {
    return "DROP TABLE IF EXISTS table_migration";
  }
}
