import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
///////----------------------4.4.3 Wrap--------------------

    ///////---------direction属性测试------------------------------------------------------

//    var show =Wrap(
//      spacing: 10,
//      children: Axis.values.map((e){
//        count =0;
//        return Column(
//          children: <Widget>[
//            Container(
//              color: Colors.grey.withAlpha(33),
//              width: 220,
//              height: 120,
//              child: Wrap(
//                  spacing: 10.0, //列间距
//                  runSpacing: 10.0, //行间距
//                  direction: e, //元素横向方向
//                  children: <Widget>[
//                    getBox(30, Colors.red),
//                    getBox(30, Colors.cyanAccent),
//                    getBox(45, Colors.green),
//                    getBox(20, Colors.blue),
//                    getBox(30, Colors.orange),
//                    getBox(40, Colors.deepPurpleAccent),
//                    getBox(30, Colors.purple),
//                    getBox(40, Colors.amberAccent),
//                  ])),
//            SizedBox(height: 5,),
//            Text('${e}',),
//            SizedBox(height: 5,),
//          ],
//        );
//      }).toList(),
//    );

///////---------alignment属性测试------------------------------------------------------
//    var show =Wrap(
//      spacing: 10,
//      children: WrapAlignment.values.map((e){
//        count =0;
//        return Column(
//          children: <Widget>[
//            Container(
//                color: Colors.grey.withAlpha(33),
//                width: 220,
//                height: 120,
//                child: Wrap(
//                    spacing: 10.0, //列间距
//                    runSpacing: 10.0, //行间距
//                    alignment: e, //元素横向排列
//                    children: <Widget>[
//                      getBox(30, Colors.red),
//                      getBox(30, Colors.cyanAccent),
//                      getBox(45, Colors.green),
//                      getBox(20, Colors.blue),
//                      getBox(30, Colors.orange),
//                      getBox(40, Colors.deepPurpleAccent),
//                      getBox(30, Colors.purple),
//                      getBox(40, Colors.amberAccent),
//                    ])),
//            SizedBox(height: 5,),
//            Text('${e}',),
//            SizedBox(height: 5,),
//          ],
//        );
//      }).toList(),
//    );

    ///////---------crossAxisAlignment属性测试------------------------------------------------------
//    var show = Wrap(
//      spacing: 10,
//      children: WrapCrossAlignment.values.map((e) {
//        count = 0;
//        return Column(
//          children: <Widget>[
//            Container(
//                color: Colors.grey.withAlpha(33),
//                width: 220,
//                height: 120,
//                child: Wrap(
//                    spacing: 10.0, //列间距
//                    runSpacing: 10.0, //行间距
//                    crossAxisAlignment: e,
//                    children: <Widget>[
//                      getBox(30, Colors.red),
//                      getBox(30, Colors.cyanAccent),
//                      getBox(45, Colors.green),
//                      getBox(20, Colors.blue),
//                      getBox(30, Colors.orange),
//                      getBox(40, Colors.deepPurpleAccent),
//                      getBox(30, Colors.purple),
//                      getBox(40, Colors.amberAccent),
//                    ])),
//            SizedBox(
//              height: 5,
//            ),
//            Text(
//              '${e}',
//            ),
//            SizedBox(
//              height: 5,
//            ),
//          ],
//        );
//      }).toList(),
//    );

    ///////---------crossAxisAlignment属性测试------------------------------------------------------

    var show = Wrap(
      spacing: 10,
      children: WrapAlignment.values.map((e) {
        count = 0;
        return Column(
          children: <Widget>[
            Container(
                color: Colors.grey.withAlpha(33),
                width: 220,
                height: 120,
                child: Wrap(
                    spacing: 10.0, //列间距
                    runSpacing: 10.0, //行间距
                    runAlignment: e,
                    children: <Widget>[
                      getBox(30, Colors.red),
                      getBox(30, Colors.cyanAccent),
                      getBox(45, Colors.green),
                      getBox(20, Colors.blue),
                      getBox(30, Colors.orange),
                      getBox(40, Colors.deepPurpleAccent),
                      getBox(30, Colors.purple),
                      getBox(40, Colors.amberAccent),
                    ])),
            SizedBox(
              height: 5,
            ),
            Text(
              '$e',
            ),
            SizedBox(
              height: 5,
            ),
          ],
        );
      }).toList(),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(child: SingleChildScrollView(child: show)),
      ),
    );
  }
}

/// 获取一个方形盒子
/// 其中边长是[width],颜色是[color]

var count = 0;

Widget getBox(double width, Color color) {
  count++;
  return Container(
    alignment: Alignment.center,
    color: color,
    //容器的颜色
    width: width,
    //容器宽
    height: width,
    child: Text(
      '$count',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
} //容器高
