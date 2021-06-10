import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'app/cons.dart';

import 'app/i18n/i18n.dart';
import 'app/redux/app_state.dart';
import 'app/redux/locale_redux.dart';
import 'app/redux/theme_redux.dart';
import 'widgets/color_chooser.dart';

class SlidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var colorChooser = StoreBuilder<AppState>(
        builder: (context, store) => ColorChooser(
              initialIndex: Cons.them_colors
                      .indexOf(store.state.themeState.primaryColor) ??
                  4,
              colors: Cons.them_colors,
              onChecked: (color) => store
                  .dispatch(ActionSwitchTheme(ThemeData(primaryColor: color))),
            ));

    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0, bottom: 30),
            child: colorChooser,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LanguageChooser(),
          )
        ],
      ),
    );
  }
}

class LanguageChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var map = <Locale, String>{
      LocaleState.zh().locale: I18N.of(context).chinese,
      LocaleState.en().locale: I18N.of(context).english,
      LocaleState.fr().locale: I18N.of(context).french,
    };

    return StoreBuilder<AppState>(
        builder: (context, store) => ExpansionTile(
              title: Text(I18N.of(context).switchLocal),
              leading: Icon(
                Icons.language,
                color: store.state.themeState.primaryColor,
              ),
              children: map.keys
                  .map((local) => RadioListTile(
                      activeColor: store.state.themeState.primaryColor,
                      value: local,
                      title: Text(map[local]),
                      groupValue: store.state.localeState.locale,
                      onChanged: (locale) =>
                          store.dispatch(ActionSwitchLocal(locale))))
                  .toList(),
            ));
  }
}
