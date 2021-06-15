import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:my_flutter/module/callnative/pages/call_native.dart';
import 'package:my_flutter/module/category/pages/category.dart';
import 'package:my_flutter/module/message/pages/message_page.dart';
import 'package:my_flutter/module/my/pages/my_page.dart';
import 'package:my_flutter/module/unknow/pages/unknow_page.dart';
import 'package:my_flutter/router/router_utils.dart';
import '../module/home/pages/home_page.dart';
import '../module/main/pages/main_page.dart';

class YFRouter {
  static final String initialRoute = MainPage.routeName;

  static Map<String, FlutterBoostRouteFactory> routerMap = {
    MainPage.routeName: (settings, uniqueId) {
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (ctx, a1, a2) {
            return MainPage();
          });
    },
    HomePage.routeName: (settings, uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (ctx) {
            return HomePage();
          });
    },
    CategoryPage.routeName: (settings, uniqueId) {
      return Right2LeftRouter(settings: settings, child: CategoryPage());
    },
    MessagePage.routeName: (settings, uniqueId) => PageRouteBuilder(
        settings: settings, pageBuilder: (_, __, ___) => MessagePage()),
    MyPage.routeName: (settings, uniqueId) => PageRouteBuilder(
        settings: settings, pageBuilder: (_, __, ___) => MyPage()),
    UnknowPage.routeName: (settings, uniqueId) => PageRouteBuilder(
        settings: settings, pageBuilder: (_, __, ___) => UnknowPage()),
    CallNativePage.routeName: (settings, uniqueId) => PageRouteBuilder(
        settings: settings, pageBuilder: (_, __, ___) => CallNativePage()),
  };

  static final Map<String, WidgetBuilder> routes = {
    MainPage.routeName: (ctx) => MainPage(),
    HomePage.routeName: (ctx) => HomePage(),
    CategoryPage.routeName: (ctx) => HomePage(),
    MessagePage.routeName: (ctx) => MessagePage(),
    MyPage.routeName: (ctx) => MyPage(),
    UnknowPage.routeName: (ctx) => UnknowPage(),
    CallNativePage.routeName: (ctx) => CallNativePage()
  };

  static final RouteFactory generateRoute = (settings) {
    return null;
  };

  static final RouteFactory unknownRoute = (settings) {
    return null;
  };
}
