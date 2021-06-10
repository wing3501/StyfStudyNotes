import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/provider/theme_state.dart';
import 'home_page.dart';

void main() => runApp(Wrapper(child: MyApp(),));

class Wrapper extends StatelessWidget {
  final Widget child;
  Wrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState.init()),//提供状态
      ],
      child: child, //孩子
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
        builder: (_,ThemeState state, __) => MaterialApp(//对点消费
              title: 'Flutter Demo',
              theme: state.themeData, //获取数据
              home: MyHomePage(title: 'Flutter Demo Home Page'),
            ));
  }
}
