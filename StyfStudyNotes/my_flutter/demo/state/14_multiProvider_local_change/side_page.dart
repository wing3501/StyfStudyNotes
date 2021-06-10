import 'package:flutter/material.dart';

import 'app/cons.dart';

import 'package:provider/provider.dart';

import 'app/provider/i18n/i18n.dart';
import 'app/provider/local_state.dart';
import 'app/provider/theme_state.dart';
import 'widgets/color_chooser.dart';

class SlidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var colorChooser = Consumer<ThemeState>(
        builder: (_, state, __) => ColorChooser(
              initialIndex: Cons.them_colors.indexOf(state.primaryColor) ?? 4,
              colors: Cons.them_colors,
              onChecked: (color) =>
                  state.changeThemeData(ThemeData(primaryColor: color)),
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

//enum Language { cn, en,fr }

class LanguageChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var map = <Locale, String>{
      LocaleState.zh().locale: I18N.of(context).chinese,
      LocaleState.en().locale: I18N.of(context).english,
      LocaleState.fr().locale: I18N.of(context).french,
    };

    return Consumer2<ThemeState, LocaleState>(
        builder: (_, theme, state, __) => ExpansionTile(
              title: Text(I18N.of(context).switchLocal),
              leading: Icon(
                Icons.language,
                color: theme.primaryColor,
              ),
              children: map.keys
                  .map((local) => RadioListTile(
                      activeColor: theme.primaryColor,
                      value: local,
                      title: Text(map[local]),
                      groupValue: state.locale,
                      onChanged: state.changeLocaleState))
                  .toList(),
            ));
  }
}
