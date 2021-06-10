import 'package:flutter/material.dart';
import '../../../app/cons.dart';
class HomeTabBar extends TabBar {
  HomeTabBar()
      : super(
          labelStyle: TextStyle(fontSize: 14), //字号
          labelColor: Color(0xffffffff), //当前选中文字颜色
          unselectedLabelColor: Color(0xffeeeeee), //未选中文字颜色
          tabs: Cons.tabs.map((tab) => //标签Widget
                  Container(height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(tab),)).toList(),
        );
}
