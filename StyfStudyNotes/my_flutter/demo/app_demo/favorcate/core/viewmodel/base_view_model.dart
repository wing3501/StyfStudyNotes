import 'package:flutter/material.dart';

import '../model/meal_model.dart';
import 'filter_view_model.dart';

class YFBaseMealViewModel extends ChangeNotifier {
  List<YFMealModel> _meals = [];

  YFFilterViewModel _filterVM;

  set meals(List<YFMealModel> value) => this._meals = value;

  List<YFMealModel> get meals {
    return _meals.where((meal) {
      if (_filterVM.isGlutenFree && !meal.isGlutenFree) return false;
      if (_filterVM.isLactoseFree && !meal.isLactoseFree) return false;
      if (_filterVM.isVegetarian && !meal.isVegetarian) return false;
      if (_filterVM.isVegan && !meal.isVegan) return false;
      return true;
    }).toList();
  }

  List<YFMealModel> get originMeals {
    return _meals;
  }

  void updateFilters(YFFilterViewModel filterVM) {
    _filterVM = filterVM;
  }
}
