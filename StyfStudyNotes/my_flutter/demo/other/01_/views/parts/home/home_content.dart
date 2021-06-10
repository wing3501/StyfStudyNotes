
import 'package:flutter/material.dart';

import 'show_page.dart';
import '../../../app/cons.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return TabBarView(
        //根据列表创建界面列表
        children: Cons.tabs.map((text) =>_buildContent(Cons.tabs.indexOf(text))).toList()
    );
  }

  Widget _buildContent(int index) {
    switch(index){
      case 0:
        return PlugsPage();
        break;
      case 1:
        return PlugsPage();
        break;
      case 2:
        return PlugsPage();
        break;
      case 3:
        return PlugsPage();
        break;

    }
  }
}

