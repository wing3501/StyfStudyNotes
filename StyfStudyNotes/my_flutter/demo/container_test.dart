import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
///////----------------------4.3.1  Container的基本使用----------------------
//    var show = Container(//容器组件
//      width: 150,//容器宽
//      height: 100,//容器高
//      color: Colors.lightBlueAccent,//容器的颜色
//      padding: EdgeInsets.fromLTRB(10, 20, 30, 40),//内边距
//      margin: EdgeInsets.fromLTRB(10, 20, 30, 40),//外边距
//      child: Text("Container"),//容器内部组件
//      alignment: Alignment.center,//对齐方式
//    );
///////---------------------------------------------------------------

///////----------------------4.3.2  Container的Padding----------------------
//    var show = Padding(padding: EdgeInsets.only(left: 30),
//      child: Image.asset(  "images/wy_200x300.jpg", fit: BoxFit.cover, ),);
///////---------------------------------------------------------------

///////----------------------4.3.3  Container的边线装饰----------------------
////Container装饰线对象
    //圆形图片容器
    var show = Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5), //颜色
              offset: const Offset(0.0, 0.0), //偏移
              blurRadius: 6.0, //阴影模糊度
              spreadRadius: 0.0,
            ),
          ],
          image: DecorationImage(
              image: AssetImage('images/wy_200x300.jpg'), fit: BoxFit.cover),
        ));

//    //圆角矩形图片容器
//    var radius = BorderRadius.all(Radius.circular(15));
//    var show = Container(
//        height: 100,
//        width: 100,
//        decoration: ShapeDecoration(
//          shape: RoundedRectangleBorder(
//              side: BorderSide(
//                  width: 2.0,
//                  color: Colors.blue),
//              borderRadius: radius),
//          image: DecorationImage(
//              image: AssetImage('images/wy_200x300.jpg'),
//              fit: BoxFit.cover),
//        ));

///////---------------------------------------------------------------

///////----------------------4.3.4  Container的约束----------------------
//    var show = Container(  constraints: BoxConstraints(
//      minWidth: 50,//最小宽
//      minHeight: 50,//最小高
//      maxHeight: 100,//最大高
//      maxWidth: 100,//最大宽
//    ),
//      child: Container(width: 150, height: 10,
//        color: Colors.cyanAccent,),
//    );
///////---------------------------------------------------------------

///////----------------------4.3.4  Container的变换----------------------
////Matrix4待测试项数组
//    var matrix4 = [
//      Matrix4.rotationX(45 * pi / 180),
//      Matrix4.rotationY(45 * pi / 180),
//      Matrix4.rotationZ(45 * pi / 180),
//      Matrix4.skew(30 * pi / 180, -45 * pi / 180),
//      Matrix4.skewX(45 * pi / 180),
//      Matrix4.skewY(45 * pi / 180),
//      Matrix4.translationValues(10, 10, 10),
//      Matrix4.diagonal3Values(0.5, 0.8, 1)
//    ];
//  //文字描述信息
//    var strInfo = [
//      "rotationX(45°)",
//      "rotationY(45°)",
//      "rotationZ(45°)",
//      "skew（30°，-45°）",
//      "skewX（45°）",
//      "skewY（45°）",
//      "translationValues\n(10,10,10)",
//      "diagonal3Values\n(0.5, 0.8, 1)"];
//    int i = -1;
//    var show = Wrap(
//      children: matrix4.map((e) {
//        i++;
//        return Padding(
//            padding: EdgeInsets.only(left: 50),
//            child: Column(children: <Widget>[
//              Container(
//                width: 50,
//                height: 50,
//                color: Colors.grey,
//                child: Container(
//                  color: Colors.cyanAccent,
//                  transform: e,
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(top: 10, bottom: 10),
//                child: Text(strInfo[i]),
//              ) ]));
//      }).toList(),);
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
