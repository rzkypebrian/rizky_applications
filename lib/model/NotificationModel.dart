import 'package:enerren/util/ModeUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'NotificationModel.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  int id;
  String userId;
  String title;
  String body;
  String smallIcon;
  String dataType;
  Map<String, dynamic> setting;
  Map<String, dynamic> data;

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.smallIcon,
    this.dataType,
    this.setting,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  //initialize database table and migration
  static Future<List<Map<String, dynamic>>> initializeTable(Database db,
      [int tblVersion = 0]) async {
    if (tblVersion == 0) {
      ModeUtil.debugPrint("create table notification version 0");
      return db.rawQuery(createTable()).then((onValue) {
        return onValue;
      }).catchError((onError) {
        throw onError;
      });
    } else {
      ModeUtil.debugPrint("re create table notification un related version ");
      return db.rawQuery(dropTable()).then((onValue) {
        db.rawQuery(createTable()).then((onValue) {
          return onValue;
        }).catchError((onError) {
          throw onError;
        });
      }).catchError((onError) {
        throw onError;
      });
    }
  }

  static String dropTable() {
    return "DROP TABLE IF EXISTS notification";
  }

  static String createTable() {
    return "CREATE TABLE notification (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT," +
        "userId Varchar(200)," +
        "title Varchar(500)," +
        "body Varchar(500)," +
        "smallIcon Varchar(1000)," +
        "dataType Varchar(200)," +
        "setting TEXT," +
        "data TEXT" +
        ")";
  }

  static Future<List<NotificationModel>> getAllData(
      Database db, String userId) async {
    try {
      return db
          .query("notification", where: "userId = $userId")
          .then((onValue) {
        return onValue.map((f) => NotificationModel.fromJson(f)).toList();
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<int> addData(Database db, NotificationModel data) {
    try {
      return db.insert("notification", data.toJson()).then((onValue) {
        return onValue;
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      throw e;
    }
  }
}
