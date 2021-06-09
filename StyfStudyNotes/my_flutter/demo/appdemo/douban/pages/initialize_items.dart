import 'package:flutter/material.dart';

import 'bottom_bar_item.dart';
import 'home/home_page.dart';
import 'subject/subject_page.dart';

List<YFBottomBarItem> items = [
  YFBottomBarItem("home", "首页"),
  YFBottomBarItem("subject", "书影音"),
  YFBottomBarItem("group", "小组"),
  YFBottomBarItem("mall", "市集"),
  YFBottomBarItem("profile", "我的"),
];

List<Widget> pages = [
  YFHomePage(),
  YFSubjectPage(),
  YFSubjectPage(),
  YFSubjectPage(),
  YFSubjectPage(),
];
