import 'package:favorcate/ui/pages/detail/detail.dart';
import 'package:favorcate/ui/pages/filter/filter.dart';
import 'package:favorcate/ui/pages/main/main_screen.dart';
import 'package:favorcate/ui/pages/meal/meal.dart';
import 'package:flutter/material.dart';

class YFRouter {
  static final String initialRoute = YFMainSceen.routeName;

  static final Map<String, WidgetBuilder> routes = {
    YFMainSceen.routeName: (ctx) => YFMainSceen(),
    YFMealScreen.routeName: (ctx) => YFMealScreen(),
    YFDetailScreen.routeName: (ctx) => YFDetailScreen()
  };

  static final RouteFactory generateRoute = (settings) {
    if (settings.name == YFFilterScreen.routeName) {
      return MaterialPageRoute(
          builder: (context) {
            return YFFilterScreen();
          },
          fullscreenDialog: true);
    }
    return null;
  };

  static final RouteFactory unknownRoute = (settings) {
    return null;
  };
}
