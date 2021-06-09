import 'package:flutter/material.dart';
import '../pages/serach_page.dart';
import '../utils/router_utils.dart';
import '../pages/home_page.dart';

class Router {
  static const String home = '/';


  static const String search = '/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      //根据名称跳转相应页面

      case Router.home:
        return MaterialPageRoute(builder: (_) => HomePage());

      case Router.search:
        return Left2RightRouter(child:SearchPage(),duration: 600);


      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
