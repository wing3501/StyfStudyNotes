import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/viewmodel/favor_view_model.dart';
import 'core/viewmodel/filter_view_model.dart';
import 'core/viewmodel/meal_view_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => YFFilterViewModel(),
      ),
      ChangeNotifierProxyProvider<YFFilterViewModel, YFMealViewModel>(
        create: (context) => YFMealViewModel(),
        update: (context, filterVM, mealVM) {
          mealVM.updateFilters(filterVM);
          return mealVM;
        },
      ),
      ChangeNotifierProxyProvider<YFFilterViewModel, YFFavorViewModel>(
        create: (context) => YFFavorViewModel(),
        update: (context, filterVM, mealVM) {
          mealVM.updateFilters(filterVM);
          return mealVM;
        },
      ),
    ],
    child: MyApp(),
  ));
}
