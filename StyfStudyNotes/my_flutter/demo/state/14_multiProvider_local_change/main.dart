import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app/provider/i18n/i18n.dart';
import 'app/provider/local_state.dart';
import 'app/provider/theme_state.dart';
import 'home_page.dart';

void main() {
  runApp(Wrapper(
    child: MyApp(),
  ));
}

class Wrapper extends StatelessWidget {
  final Widget child;

  Wrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState.init()),
        ChangeNotifierProvider(create: (_) => LocaleState.zh()),
        //在这提供provider
      ],
      child: child, //孩子
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleState, ThemeState>(
        builder: (ctx, LocaleState localeState, ThemeState themeState, __) =>
            MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                I18nDelegate.delegate, //添加
              ],
              locale: localeState.locale,
              supportedLocales: [localeState.locale],
              title: 'Flutter Demo',
              theme: themeState.themeData, //获取数据
              home: MyHomePage(),
            ));
  }
}
