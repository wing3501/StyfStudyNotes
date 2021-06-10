import 'dart:io';
import 'package:path/path.dart' as path;

main() async {
  var dataPath = "lib/day09/16/app/i18n/data.dart";
  var dataFile = File(path.join(Directory.current.path, dataPath));
  var dataContent = await dataFile.readAsString(); //读取数据
  var supportLi = <String>[]; //提取支持的语言
  var keys = <String>{}; //提取关键字，用Set集合
  RegExp regSupport = RegExp(r"final(.*?)=");
  for (Match m in regSupport.allMatches(dataContent)) {
    supportLi.add(m.group(1).trim());
  }
  RegExp regKey = RegExp(r'"(.*?)"\s?:');
  for (Match m in regKey.allMatches(dataContent)) {
    keys.add(m.group(1).trim());
  }
  var support = "[";
  supportLi.forEach((e) => support += "'$e',");
  support += "]";
  String i18nDe = """
  /// Power By 张风捷特烈--- Generated file. Do not edit.
 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data.dart';
///多语言代理类
class I18nDelegate extends LocalizationsDelegate<I18N> {
  @override//是否支持
  bool isSupported(Locale locale) => """ +
      support +
      """.contains(locale.languageCode);
  @override//加载当前语言下的字符串
  Future<I18N> load(Locale locale) => SynchronousFuture<I18N>( I18N(locale));
  @override
  bool shouldReload(LocalizationsDelegate<I18N> old) => false;
  static I18nDelegate delegate =  I18nDelegate();//全局静态的代理
}
  """;
  var mapStr = "static Map<String, Map<String,String>> _localizedValues = {";
  supportLi.forEach((e) => mapStr += "'$e':Data.$e,");
  mapStr += "};\n";
  var keyStr = "";
  keys.forEach((e) =>
      keyStr += "get $e => _localizedValues[_locale.languageCode]['$e'];\n");
  print(keyStr);
  var i18n = """
  class I18N {
  final Locale _locale;
  I18N(this._locale);
  static I18N of(BuildContext context) => Localizations.of(context, I18N);
  """ +
      mapStr +
      keyStr +
      "}";
  var fileOut = File(path.join(dataFile.parent.path, "i18n.dart"));
  if (!await fileOut.exists()) {
    await fileOut.create(recursive: true);
  }
  fileOut.writeAsString(i18nDe + "\n" + i18n);
}
