import 'package:flutter/material.dart';

import '../goods_widget.dart';

class DetailPager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hero = Hero(
      //定义一个Hero,为其添加标签，两个标签相同，则可以共享
      tag: 'user-head',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Image.asset(
          "assets/images/icon_head.png",
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
    var hero2= Hero(
      //定义Hero,添加tag标签,此中组件共享
      tag: 'user-head2',
      child:  Image.asset(
        "assets/images/icon_head.png",
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: hero,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.bottomRight,
        color: Colors.cyan.withAlpha(11),
        child: hero2,
      ),
    );
  }
}
