import 'package:favorcate/core/model/meal_model.dart';
import 'package:favorcate/core/services/http_request.dart';

class YFMealRequest {
  static Future<List<YFMealModel>> getMealData() async {
    final url = "/meal";
    final result = await HttpRequest.request(url);

    final mealArray = result["meal"];
    List<YFMealModel> meals = [];
    for (var json in mealArray) {
      meals.add(YFMealModel.fromJson(json));
    }
    return meals;
  }
}
