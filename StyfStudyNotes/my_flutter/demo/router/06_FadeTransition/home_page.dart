import 'package:flutter/material.dart';

import 'router.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hero = Hero(
      //定义Hero,添加tag标签,此中组件共享
      tag: 'user-head',
      child: Image.asset(
        "assets/images/icon_head.png",
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );

    var hero2 = Hero(
      //定义Hero,添加tag标签,此中组件共享
      tag: 'user-head2',
      child: Image.asset(
        "assets/images/icon_head.png",
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
    return Scaffold(
      body: Center(
        //点击跳转
        child: GestureDetector(
          child: Container(
              color: Colors.orange.withAlpha(11),
              alignment: Alignment(-0.8, -0.8),
              child: Row(
                children: <Widget>[hero, hero2],
              ),
              width: 250,
              height: 250 * 0.618),
          onTap: () => Navigator.of(context).pushNamed(RouterTool.detail),
        ),
      ),
    );
  }
}
