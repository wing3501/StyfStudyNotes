import 'package:flutter/material.dart';

class LocaleState with ChangeNotifier {
  Locale _locale;
  LocaleState(this._locale);

  factory LocaleState.zh() => LocaleState(Locale('zh', 'CH')); //中文
  factory LocaleState.en() => LocaleState(Locale('en', 'US')); //英文
  factory LocaleState.fr() => LocaleState(Locale('fr', 'FR')); //法文

  void changeLocaleState(Locale state) {
    _locale = state;
    notifyListeners();
  }

  Locale get locale => _locale; //获取语言
}
