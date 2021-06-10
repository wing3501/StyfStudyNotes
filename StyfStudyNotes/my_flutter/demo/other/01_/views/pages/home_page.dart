import 'package:flutter/material.dart';
import '../parts/home/home_content.dart';
import '../parts/home/home_tab_bar.dart';
import '../../app/cons.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Cons.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter联盟"),
          bottom: HomeTabBar(), //标题栏右侧按钮
          actions: <Widget>[Icon(Icons.search)], //标题栏右侧按钮
        ),
        body: HomeContent(),
      ),
    );
  }
}
