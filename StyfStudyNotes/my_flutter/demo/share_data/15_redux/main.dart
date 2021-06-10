import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'app/redux/app_redux.dart';
import 'app/redux/theme_redux.dart';
import 'home_page.dart';
import 'package:redux/redux.dart';

void main() => runApp(Wrapper(
      child: MyApp(),
    ));

class Wrapper extends StatelessWidget {
  final Widget child;

  Wrapper({this.child});

  final store = Store<AppState>(
    //初始状态
    appReducer, //总处理器
    initialState: AppState(
      //初始状态
      themeState: ThemeState.init(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(store: store, child: child);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
        builder: (context, store) => MaterialApp(
              //对点消费
              title: 'Flutter Demo',
              theme: store.state.themeState.themeData, //获取数据
              home: MyHomePage(title: 'Flutter Demo Home Page'),
            ));
  }
}
