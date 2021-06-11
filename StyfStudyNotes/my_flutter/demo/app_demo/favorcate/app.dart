import 'package:flutter/material.dart';

import 'core/router/route/router.dart';
import 'ui/shared/app_theme.dart';
import 'ui/shared/size_fit.dart';

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
