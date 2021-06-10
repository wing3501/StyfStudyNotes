//切换主题状态
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ThemeState {
  final ThemeData themeData; //主题
  ThemeState(this.themeData);

  Color get primaryColor => themeData.primaryColor; //获取primaryColor

  factory ThemeState.init([ThemeData theme]) => ThemeState(theme ??
      ThemeData(
        primarySwatch: Colors.blue,
      ));
}

//切换主题行为
class ActionSwitchTheme {
  final ThemeData themeData;
  ActionSwitchTheme(this.themeData);
}

//切换主题理器
var themeDataReducer =
    TypedReducer<ThemeState, ActionSwitchTheme>((state, action) => ThemeState(
          action.themeData,
        ));
