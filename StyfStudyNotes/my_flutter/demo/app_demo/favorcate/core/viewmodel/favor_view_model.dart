import '../model/meal_model.dart';
import 'base_view_model.dart';

class YFFavorViewModel extends YFBaseMealViewModel {
  void addMeal(YFMealModel meal) {
    originMeals.add(meal);
    notifyListeners();
  }

  void removeMeal(YFMealModel meal) {
    originMeals.remove(meal);
    notifyListeners();
  }

  void handleMeal(YFMealModel meal) {
    if (isFavor(meal)) {
      removeMeal(meal);
    } else {
      addMeal(meal);
    }
  }

  bool isFavor(YFMealModel meal) {
    return originMeals.contains(meal);
  }
}
