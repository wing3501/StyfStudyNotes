import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:my_flutter/module/main/pages/main_page.dart';
import 'app/app_theme.dart';
import 'app/custom_interceptor.dart';
import 'app/global_page_visibility_observer.dart';
import 'router/router.dart';

void main() {
  // PageVisibilityBinding.instance
  //     .addGlobalObserver(AppGlobalPageVisibilityObserver());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Route<dynamic> routeFactory(RouteSettings settings, String uniqueId) {
    FlutterBoostRouteFactory func = YFRouter.routerMap[settings.name];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

  Widget appBuilder(Widget home) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            primaryColor: Color(0xFFFFFFFF),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        home: home);
  }

  @override
  Widget build(BuildContext context) {
    // return FlutterBoostApp(
    //   routeFactory,
    //   interceptors: [CustomInterceptor()],
    //   appBuilder: appBuilder,
    //   initialRoute: MainPage.routeName,
    // );

    return MaterialApp(
      title: 'styf',
      theme: appTheme,
      routes: YFRouter.routes,
      initialRoute: YFRouter.initialRoute,
    );
  }
}
