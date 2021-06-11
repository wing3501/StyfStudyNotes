import 'package:flutter/material.dart';

class YFAPPTheme {
  static const double bodyFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 20;
  static const double largeFontSize = 24;
  static const double xlargeFontSize = 30;

  static const Color norTextColors = Colors.red;
  static final ThemeData norTheme = ThemeData(
      primarySwatch: Colors.pink,
      accentColor: Colors.amber,
      //全局页面背景色
      canvasColor: Color.fromRGBO(255, 254, 222, 1),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: bodyFontSize),
        headline4: TextStyle(fontSize: smallFontSize, color: Colors.black),
        headline3: TextStyle(fontSize: normalFontSize, color: Colors.black),
        headline2: TextStyle(fontSize: largeFontSize, color: Colors.black),
        headline1: TextStyle(fontSize: xlargeFontSize, color: Colors.black),
      ));

  static const Color darkTextColors = Colors.green;
  static final ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      textTheme: TextTheme(
          bodyText2:
              TextStyle(fontSize: normalFontSize, color: darkTextColors)));
}
