import 'package:flutter/material.dart';

import '../draws/canvas_page.dart';
import '../draws/colck_page/colck_page.dart';
import '../draws/grid_page.dart';
import '../draws/star_page.dart';
import '../home/home_button.dart';
import '../home/home_left_drawer.dart';
import '../home/home_right_drawer.dart';
import '../../views/home/home_menu.dart';
import '../../app/cons.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        //标签控制器
        length: Cons.homeTabs.length, //标签个数
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                title: Text("Flutter 联盟"),
                actions: <Widget>[Icon(Icons.search), HomeMenu()], //标题栏右侧按钮
                bottom: _buildHomeTabBar()),
            body: _homeContent(),
            drawer: HomeLeftDrawer(),
            //左滑页
            endDrawer: HomeRightDrawer(),
            //右滑页
            floatingActionButton: HomeButton()));
  }

  //构建标签栏
  PreferredSizeWidget _buildHomeTabBar() => TabBar(
      labelStyle: TextStyle(fontSize: 14), //字号
      labelColor: Color(0xffffffff), //当前选中文字颜色
      unselectedLabelColor: Color(0xffeeeeee), //未选中文字颜色
      tabs: Cons.homeTabs
          .map((tab) => //标签Widget
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(tab),
              ))
          .toList());

  //创建主页界面列表
  Widget _homeContent() => TabBarView(
      //根据列表创建界面列表
      children: Cons.homeTabs
          .map((text) => _buildContent(Cons.homeTabs.indexOf(text)))
          .toList());

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return GridPager();
      case 1:
        return CanvasPage();
      case 2:
        return CustomPaint(
          painter: StartPainter(),
        );
      case 3:
        return CustomPaint(
          painter: ClockPainter(),
        );
    }
  }
}
