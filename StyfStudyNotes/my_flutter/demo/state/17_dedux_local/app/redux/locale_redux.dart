//切换语言状态
import 'dart:ui';
import 'package:redux/redux.dart';

class LocaleState {
  final Locale locale; //主题
  LocaleState(this.locale);
  factory LocaleState.init([Locale locale]) =>
      LocaleState(locale ?? Locale('zh', 'CH'));

  factory LocaleState.zh() => LocaleState(Locale('zh', 'CH'));
  factory LocaleState.en() => LocaleState(Locale('en', 'US'));
  factory LocaleState.fr() => LocaleState(Locale('fr', 'FR'));
}

//切换语言行为
class ActionSwitchLocal {
  final Locale locale;
  ActionSwitchLocal(this.locale);
}

//切换语言处理器
var localReducer =
    TypedReducer<LocaleState, ActionSwitchLocal>((state, action) => LocaleState(
          action.locale,
        ));
