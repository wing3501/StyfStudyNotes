import 'theme_redux.dart';

class AppState {
  final ThemeState themeState; //主题状态

  AppState({this.themeState});
}

//总处理器--分封职责
AppState appReducer(AppState prev, dynamic action) {
  return AppState(themeState: themeDataReducer(prev.themeState, action));
}
