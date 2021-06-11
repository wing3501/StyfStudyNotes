import '../services/meal_request.dart';
import 'base_view_model.dart';

class YFMealViewModel extends YFBaseMealViewModel {
  YFMealViewModel() {
    YFMealRequest.getMealData().then((value) {
      meals = value;
      notifyListeners();
    });
  }
}
