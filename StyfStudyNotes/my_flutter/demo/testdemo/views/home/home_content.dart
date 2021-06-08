import 'package:flutter/material.dart';

import '../../views/draws/colck_page/colck_page.dart';
import '../../views/draws/star_page.dart';
import '../../app/cons.dart';
import '../draws/canvas_page.dart';
import '../draws/grid_page.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        //根据列表创建界面列表
        children: Cons.homeTabs
            .map((text) => _buildContent(Cons.homeTabs.indexOf(text)))
            .toList());
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return GridPager();
        break;
      case 1:
        return CanvasPage();
        break;
      case 2:
        return CustomPaint(
          //使用CustomPaint盛放画布
          painter: StartPainter(),
        );
        break;
      case 3:
        return CustomPaint(
          //使用CustomPaint盛放画布
          painter: ClockPainter(),
        );
        break;
    }
  }
}
