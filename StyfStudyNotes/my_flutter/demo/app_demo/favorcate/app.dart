import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize();
    return MaterialApp(
      title: '美食广场',
      theme: YFAPPTheme.norTheme,
      initialRoute: YFRouter.initialRoute,
      routes: YFRouter.routes,
      onGenerateRoute: YFRouter.generateRoute,
      onUnknownRoute: YFRouter.unknownRoute,
    );
  }
}
