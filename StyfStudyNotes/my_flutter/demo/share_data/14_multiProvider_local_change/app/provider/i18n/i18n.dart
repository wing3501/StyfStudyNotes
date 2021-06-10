/// Power By 张风捷特烈--- Generated file. Do not edit.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data.dart';

///多语言代理类
class I18nDelegate extends LocalizationsDelegate<I18N> {
  @override //是否支持
  bool isSupported(Locale locale) => [
        'en',
        'zh',
        'fr',
      ].contains(locale.languageCode);
  @override //加载当前语言下的字符串
  Future<I18N> load(Locale locale) => SynchronousFuture<I18N>(I18N(locale));
  @override
  bool shouldReload(LocalizationsDelegate<I18N> old) => false;
  static I18nDelegate delegate = I18nDelegate(); //全局静态的代理
}

class I18N {
  final Locale _locale;
  I18N(this._locale);
  static I18N of(BuildContext context) => Localizations.of(context, I18N);
  static Map<String, Map<String, String>> _localizedValues = {
    'en': Data.en,
    'zh': Data.zh,
    'fr': Data.fr,
  };
  get title => _localizedValues[_locale.languageCode]['title'];
  get countInfo => _localizedValues[_locale.languageCode]['countInfo'];
  get switchLocal => _localizedValues[_locale.languageCode]['switchLocal'];
  get chinese => _localizedValues[_locale.languageCode]['chinese'];
  get french => _localizedValues[_locale.languageCode]['french'];
  get english => _localizedValues[_locale.languageCode]['english'];
}
