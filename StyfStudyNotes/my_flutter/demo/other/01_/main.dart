import 'package:flutter/material.dart';
import 'views/pages/home_page.dart';

import 'app/router.dart' as router;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.Router.generateRoute, //路由生成器
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
