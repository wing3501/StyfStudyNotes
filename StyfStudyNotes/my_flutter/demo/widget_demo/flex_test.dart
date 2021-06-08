import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
///////----------------------4.4.1.4  Flex--测试1--------------------
//    var redBox = Container(
//      color: Colors.red, height: 50, width: 50,);
//    var blueBox = Container(
//      color: Colors.blue, height: 30, width: 60,);
//    var yellowBox = Container(
//      color: Colors.yellow, height: 50, width: 100,);
//    var show = Flex(direction: Axis.horizontal,
//      children: <Widget>[redBox,blueBox,yellowBox],);
///////---------------------------------------------------------------

///////----------------------4.4.1.4 Flex--测试2--------------------
//    var redBox = Container(
//      color: Colors.red, height: 50, width: 50,);
//    var blueBox = Container(
//      color: Colors.blue, height: 30, width: 60,);
//    var yellowBox = Container(
//      color: Colors.yellow, height: 50, width: 100,);
//    var show= Flex(direction: Axis.horizontal,
//      children: <Widget>[redBox,
//        Expanded(child: blueBox),yellowBox],
//    );
///////---------------------------------------------------------------

///////----------------------4.4.1.4 Flex--测试3--------------------
//    var redBox = Container(
//      color: Colors.red, height: 50, width: 50,);
//    var blueBox = Container(
//      color: Colors.blue, height: 30, width: 60,);
//    var yellowBox = Container(
//      color: Colors.yellow, height: 50, width: 100,);
//    var show= Flex(direction: Axis.horizontal,
//        children: <Widget>[
//          Expanded(child: redBox ),
//          Expanded(child: blueBox),yellowBox]
//    );
///////---------------------------------------------------------------

///////----------------------4.4.1.4 Flex--测试4--------------------
//    var redBox = Container(
//      color: Colors.red, height: 50, width: 50,);
//    var blueBox = Container(
//      color: Colors.blue, height: 30, width: 60,);
//    var yellowBox = Container(
//      color: Colors.yellow, height: 50, width: 100,);
//    var show = Flex(direction: Axis.horizontal,
//      children: <Widget>[
//        Expanded(child: redBox,flex: 3,),
//        Expanded(child: blueBox,flex: 2,),
//        yellowBox],
//    );
///////---------------------------------------------------------------

///////----------------------4.4.1.6  Flex布局使用练习1--------------------
//    var text = Text("附近",style: TextStyle(fontSize: 18),);
//    var iconLeft = Icon(
//      Icons.add_location,size: 30,color: Colors.pink,);
//    var iconRight = Icon(
//        Icons.keyboard_arrow_right,color: Colors.black38);
//    var show = Container( height: 70,  color: Color(0x4484FFFF),
//        child: Row( children: <Widget>[
//          Padding(child: iconLeft,
//            padding: EdgeInsets.only(left: 25,right: 20),),
//          Expanded(  child: text, ),
//          Padding(child: iconRight,
//            padding: EdgeInsets.only(right: 25),),
//        ],
//        )
//    );
///////---------------------------------------------------------------

///////----------------------4.4.1.6  Flex布局使用练习2--------------------
    var infoStyle = TextStyle(color: Color(0xff999999), fontSize: 13);
    var littleStyle = TextStyle(color: Colors.black, fontSize: 16);

    var top = Row(children: <Widget>[
      //顶部
      Image.asset("images/icon_head.png", width: 20, height: 20),
      SizedBox(width: 5),
      Expanded(child: Text("张风捷特烈")),
      Text("Flutter/Dart", style: infoStyle)
    ]);

    var content = Column(
        //中间文字内容
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("[Flutter必备]-Flex布局完全解读",
              style: littleStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
          SizedBox(height: 5),
          Text(
              "也就是水平排放还是竖直排放，可以看出默认情况下都是主轴顶头,"
              "交叉轴居中比如horizontal下主轴为水平轴，",
              style: infoStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis)
        ]);

    var center = Row(//中间的部分
        children: <Widget>[
      Expanded(child: content),
      SizedBox(width: 5),
      ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Image(
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              image: AssetImage("images/wy_200x300.jpg")))
    ]);

    var end = Row(//底部
        children: <Widget>[
      Icon(Icons.grade, color: Colors.green, size: 20),
      Text("3000W", style: infoStyle),
      SizedBox(width: 10),
      Icon(Icons.tag_faces, color: Colors.lightBlueAccent, size: 20),
      Text("3000W", style: infoStyle)
    ]);

    var show = Container(
        height: 160,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[top, center, end]));
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
