import 'package:flutter/material.dart';

import 'app/redux/count_redux.dart';
import 'app/redux/locale_redux.dart';
import 'app/redux/theme_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'app/i18n/i18n.dart';
import 'app/redux/app_state.dart';
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
    appReducer,
    initialState: AppState(
        localeState: LocaleState.init(),
        themeState: ThemeState.init(),
        countState: CountState.init()),
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
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                I18nDelegate.delegate, //添加
              ],
              locale: store.state.localeState.locale,
              supportedLocales: [store.state.localeState.locale],
              title: 'Flutter Demo',
              theme: store.state.themeState.themeData, //获取数据
              home: MyHomePage(title: 'Flutter Demo Home Page'),
            ));
  }
}
