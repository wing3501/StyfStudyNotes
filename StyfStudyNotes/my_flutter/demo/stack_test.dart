import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(App());

/// 获取一个方形盒子
/// 其中边长是[width],颜色是[color]
Widget getBox(double width, Color color) => Container(
      color: color, //容器的颜色
      width: width, //容器宽
      height: width,
    ); //容器高

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
///////----------------------4.4.2  Stack叠放布局----------------------
    var show = Stack(
      children: <Widget>[
        getBox(80, Colors.yellow),
        getBox(70, Colors.red),
        getBox(60, Colors.green),
        getBox(50, Colors.cyanAccent),
      ],
    );
///////---------------------------------------------------------------

///////--------------------4.4.2  Stack与Positioned----------------------
//    var show = Stack(
//      children: <Widget>[
//        getBox(80, Colors.yellow),
//        getBox(70, Colors.red),
//        getBox(60, Colors.green),
//        Positioned(
//          child: getBox(50, Colors.cyanAccent),
//          top: 5,
//          right: 5,
//        ), ],);
///////---------------------------------------------------------------

///////--------------------4.4.2  IndexStack----------------------
//    var show = IndexedStack(
//        index: 3,//指定显示元素的索引
//        alignment: Alignment(3, 3), //对齐方式
//        children: <Widget>[
//          getBox(80, Colors.yellow),
//          getBox(70, Colors.red),
//          getBox(60, Colors.green),
//          getBox(50, Colors.cyanAccent),]);
///////---------------------------------------------------------------
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(child: show),
      ),
    );
  }
}
