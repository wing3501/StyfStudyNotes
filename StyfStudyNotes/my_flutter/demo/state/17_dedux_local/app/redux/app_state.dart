import 'count_redux.dart';
import 'locale_redux.dart';
import 'theme_redux.dart';

class AppState {
  ThemeState themeState; //管理主题
  LocaleState localeState; //管理语言
  final CountState countState; //状态

  AppState({this.themeState, this.localeState, this.countState});
}

//总处理器--分封职责
AppState appReducer(AppState prev, dynamic action) {
  return AppState(
    themeState: themeDataReducer(prev.themeState, action),
    localeState: localReducer(prev.localeState, action),
    countState: countReducer(prev.countState, action),
  );
}
