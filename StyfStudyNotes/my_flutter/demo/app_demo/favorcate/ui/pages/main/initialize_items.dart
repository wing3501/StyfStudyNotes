import 'package:flutter/material.dart';

import '../favor/favor.dart';
import '../home/home.dart';

final List<Widget> pages = [YFHomeScreen(), YFFavorScreen()];
final List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
  BottomNavigationBarItem(icon: Icon(Icons.star), label: "收藏"),
];
