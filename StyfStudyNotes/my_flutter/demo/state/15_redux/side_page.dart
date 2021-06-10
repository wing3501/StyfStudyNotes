import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'app/cons.dart';

import 'app/redux/app_redux.dart';
import 'app/redux/theme_redux.dart';
import 'widgets/color_chooser.dart';

class SlidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: StoreBuilder<AppState>(
            builder: (context, store) => ColorChooser(
                  initialIndex: Cons.them_colors
                          .indexOf(store.state.themeState.primaryColor) ??
                      4,
                  colors: Cons.them_colors,
                  onChecked: (color) => store.dispatch(
                      ActionSwitchTheme(ThemeData(primaryColor: color))),
                )),
      ),
    );
  }
}
