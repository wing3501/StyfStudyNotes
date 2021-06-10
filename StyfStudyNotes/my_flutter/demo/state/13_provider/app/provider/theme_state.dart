import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier {
  ThemeData _themeData; //主题
  ThemeState(this._themeData);//构造

  void changeThemeData( ThemeData themeData) {//设置主题
    _themeData = themeData;
    notifyListeners();//更新
  }

  ThemeData get themeData => _themeData;//获取主题
  Color get primaryColor => _themeData.primaryColor;//获取primaryColor

  ThemeState.init([ThemeData theme]) {//初始主题
    _themeData = theme ??
        ThemeData(primarySwatch: Colors.blue,);
  }
}
