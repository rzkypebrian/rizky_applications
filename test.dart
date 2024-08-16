Map<String, dynamic> json = {
  "app_id": "8857c98d-aba9-45c2-abd8-692ad94f9521",
  "headings": {"en": "Pemberitahuan | Promo"},
  "contents": {"en": "Test Content One Signal"},
  "include_player_ids": ["7bec0c3e-db42-4a00-bf41-083eb9e67ea9"],
  // "small_icon": "https://sufismart.sfi.co.id/sufismart/assets/img/logo_sufismart.png",
  "big_picture":
      "https://www.sfi.co.id/assets/images/news/Template_Promo_IG_Sept-09.png",
  "data": {
    "title": "Title Notifikasi",
    "konten": "Konten Notifikasi",
    "id": "123",
    "tipe": "All"
  }
};

//mengambil data
void getData() {
  Map<String, dynamic> data = json["data"];

  //test
  print(data["title"]);
  print(data["konten"]);
  print(data["id"]);
  print(data["tipe"]);
}

//cara conversi ke object / model

class DataModel {
  Map<String, dynamic> _source;
  int id;
  String type;
  String title;
  String konten;

  set source(Map<String, dynamic> json) {
    this.source = json;
  }

  Map<String, dynamic> get source => this._source;

  DataModel({
    this.id,
    this.type,
    this.konten,
    this.title,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json["data"];

    DataModel dataModel = DataModel(
      id: data["id"],
      konten: data["konten"],
      title: data["title"],
      type: data["type"],
    );

    dataModel.source = json;

    return dataModel;
  }

  Map<String, dynamic> tojson() {
    this.source["data"]["id"] = this.id;
    this.source["data"]["konten"] = this.konten;
    this.source["data"]["title"] = this.title;
    this.source["data"]["type"] = this.type;

    return this.source;
  }
}

//cara panggil
DataModel readData() {
  DataModel data = DataModel.fromJson(json);
  return data;
}
