import 'package:favorcate/core/services/meal_request.dart';
import 'package:favorcate/core/viewmodel/base_view_model.dart';

class YFMealViewModel extends YFBaseMealViewModel {
  YFMealViewModel() {
    YFMealRequest.getMealData().then((value) {
      meals = value;
      notifyListeners();
    });
  }
}
