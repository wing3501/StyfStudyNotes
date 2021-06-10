import 'package:flutter/material.dart';

import '../../gesturedetector/color_chooser_demo.dart';
import 'app/cons.dart';

import 'package:provider/provider.dart';

import 'app/provider/theme_state.dart';

class SlidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Consumer<ThemeState>(
            builder: (_, state, __) => ColorChooser(
                  initialIndex:
                      Cons.them_colors.indexOf(state.primaryColor) ?? 4,
                  colors: Cons.them_colors,
                  onChecked: (color) =>
                      state.changeThemeData(ThemeData(primaryColor: color)),
                )),
      ),
    );
  }
}
