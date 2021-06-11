import 'dart:convert';

import 'package:flutter/services.dart';

class JsonParse {
  static Future<List<YFCategoryModel>> getCategoryData() async {
    final jsonString = await rootBundle.loadString("assets/json/category.json");
    final result = json.decode(jsonString);
    final resultList = result["category"];
    List<YFCategoryModel> categories = [];
    for (var json in resultList) {
      categories.add(YFCategoryModel.fromJson(json));
    }
    return categories;
  }
}
