import 'package:flutter/material.dart';

class YFBottomBarItem extends BottomNavigationBarItem {
  YFBottomBarItem(String iconName, String title)
      : super(
            label: title,
            icon: Image.asset(
              "assets/tabbar/$iconName.png",
              width: 30,
            ),
            activeIcon: Image.asset(
              "assets/tabbar/${iconName}_active.png",
              width: 30,
              gaplessPlayback: true,
            ));
}
