//push to empty project

import 'package:enerren/util/ModeUtil.dart';

class Paging {
  int page;
  int limit;
  int totalPage;
  int totalData;
  String message;
  List<dynamic> data;

  Paging({
    this.page,
    this.limit,
    this.totalData,
    this.totalPage,
    this.data,
  });

  factory Paging.fromJson(Map<String, dynamic> jsonData) {
    Paging paging = new Paging();
    try {
      paging.page = jsonData['page'];
    } catch (e) {
      ModeUtil.debugPrint("error get page from return json ${e.toString()}");

      paging.message = "error get page from return json";
    }

    try {
      paging.limit = jsonData['limit'];
    } catch (e) {
      ModeUtil.debugPrint("error get limit from return json ${e.toString()}");

      paging.message = "${paging.message} error get limit from return json";
    }

    try {
      paging.totalPage = jsonData['total_page'];
    } catch (e) {
      ModeUtil.debugPrint(
          "error get total_page from return json ${e.toString()}");
      paging.message =
          "${paging.message} error get total_page from return json";
    }

    try {
      paging.data = jsonData['data'];
    } catch (e) {
      ModeUtil.debugPrint("error parse data ${e.toString()}");
      paging.message = "${paging.message} error parse data ${e.toString()}";
    }

    return paging;
  }
}
