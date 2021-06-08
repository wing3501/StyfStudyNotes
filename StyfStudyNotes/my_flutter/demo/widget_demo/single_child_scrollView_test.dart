import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: ScrollTest3(),
        ),
      ),
    );
  }
}

class ScrollTest3 extends StatefulWidget {
  @override
  _ScrollTestState3 createState() => _ScrollTestState3();
}

class _ScrollTestState3 extends State<ScrollTest3> {
//颜色列表
  var rainbow = [
    0xffff0000,
    0xffFF7F00,
    0xffFFFF00,
    0xff00FF00,
    0xff00FFFF,
    0xff0000FF,
    0xff8B00FF
  ];

  ScrollController _ctrl;
  double _rate = 0;

  @override
  void initState() {
    _ctrl = ScrollController(initialScrollOffset: 10 //初始偏移
        )
      ..addListener(() {
        var min = _ctrl.position.minScrollExtent; //可滑动的最大小值
        var max = _ctrl.position.maxScrollExtent; //可滑动的最大值
        var atEdge = _ctrl.position.atEdge; //是否滑到顶或底  可和下面的属性结合使用
        var direction =
            _ctrl.position.userScrollDirection; //向上ScrollDirection.forward

        if (direction == ScrollDirection.forward && atEdge) {
          //滑到头
          _ctrl.animateTo(max,
              duration: Duration(seconds: 2), curve: Curves.bounceOut);
        }
        if (direction == ScrollDirection.reverse && atEdge) {
          //滑到底
          _ctrl.animateTo(min,
              duration: Duration(seconds: 2), curve: Curves.bounceOut);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose(); //销毁控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = Column(
      //颜色条
      children: rainbow
          .map((color) => Container(
                height: 30,
                width: 200,
                color: Color(color),
              ))
          .toList(),
    );

    var scroll = SingleChildScrollView(
        controller: _ctrl,
        child: Transform.scale(
            scale: 1 - _rate * 0.5,
            child: Transform.rotate(angle: _rate * 2 * pi, child: items)));

    return Container(
      padding: EdgeInsets.all(8),
      width: 300,
      height: 150,
      color: Colors.grey.withAlpha(44),
      child: scroll,
    );
  }
}

//-------------------下拉形变旋转

class ScrollTest2 extends StatefulWidget {
  @override
  _ScrollTestState2 createState() => _ScrollTestState2();
}

class _ScrollTestState2 extends State<ScrollTest2> {
//颜色列表
  var rainbow = [
    0xffff0000,
    0xffFF7F00,
    0xffFFFF00,
    0xff00FF00,
    0xff00FFFF,
    0xff0000FF,
    0xff8B00FF
  ];

  ScrollController _ctrl;
  double _rate = 0;

  @override
  void initState() {
    _ctrl = ScrollController()
      ..addListener(() {
        var max = _ctrl.position.maxScrollExtent; //可滑动的最大值
        var pixels = _ctrl.position.pixels; //顶部距离父容器的高度(已滑动了多少)
        setState(() {
          _rate = pixels / max;
          print(_rate);
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose(); //销毁控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = Column(
      //颜色条
      children: rainbow
          .map((color) => Container(
                height: 30,
                width: 200,
                color: Color(color),
              ))
          .toList(),
    );

    var scroll = SingleChildScrollView(
        controller: _ctrl,
        child: Transform.scale(
            scale: 1 - _rate * 0.5,
            child: Transform.rotate(angle: _rate * 2 * pi, child: items)));

    return Container(
      padding: EdgeInsets.all(8),
      width: 300,
      height: 150,
      color: Colors.grey.withAlpha(44),
      child: scroll,
    );
  }
}

//-------------------滚动监听

class ScrollTest1 extends StatefulWidget {
  @override
  _ScrollTestState1 createState() => _ScrollTestState1();
}

class _ScrollTestState1 extends State<ScrollTest1> {
//颜色列表
  var rainbow = [
    0xffff0000,
    0xffFF7F00,
    0xffFFFF00,
    0xff00FF00,
    0xff00FFFF,
    0xff0000FF,
    0xff8B00FF
  ];

  ScrollController _ctrl; //略同...
  @override
  void initState() {
    _ctrl = ScrollController(initialScrollOffset: 10) //初始偏移
      ..addListener(() {
        var min = _ctrl.position.minScrollExtent; //可滑动的最大小值
        var max = _ctrl.position.maxScrollExtent; //可滑动的最大值
        print('---Extent:----$min-------$max----');

        var axis = _ctrl.position.axis; //滑动的轴向
        print('---axis:----$axis-----------');

//顶部距离父容器的高度(已滑动了多少)
        var pixels = _ctrl.position.pixels;
        print('---pixels:----$pixels-----------');

//是否滑到顶或底  可和下面的属性结合使用
        var atEdge = _ctrl.position.atEdge;
        var direction =
            _ctrl.position.userScrollDirection; //向上ScrollDirection.forward
        print('---atEdge:----$atEdge-----Direction:-----$direction-----');

        var dimension = _ctrl.position.viewportDimension; //滑动区域大小
        print('---dimension:----$dimension----------');
      });
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose(); //销毁控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = Column(
      //颜色条
      children: rainbow
          .map((color) => Container(
                height: 30,
                width: 200,
                color: Color(color),
              ))
          .toList(),
    );
    return Container(
      padding: EdgeInsets.all(8),
      width: 300,
      height: 150,
      color: Colors.grey.withAlpha(44),
      child: SingleChildScrollView(controller: _ctrl, child: items),
    );
  }
}

//-------------------基本使用

class ScrollTest extends StatefulWidget {
  @override
  _ScrollTestState createState() => _ScrollTestState();
}

class _ScrollTestState extends State<ScrollTest> {
//颜色列表
  var rainbow = [
    0xffff0000,
    0xffFF7F00,
    0xffFFFF00,
    0xff00FF00,
    0xff00FFFF,
    0xff0000FF,
    0xff8B00FF
  ];

  @override
  Widget build(BuildContext context) {
    var items = Column(
      //颜色条
      children: rainbow
          .map((color) => Container(
                height: 30,
                width: 200,
                color: Color(color),
              ))
          .toList(),
    );
    return Container(
      padding: EdgeInsets.all(8),
      width: 300,
      height: 150,
      color: Colors.grey.withAlpha(44),
      child: SingleChildScrollView(child: items),
    );
  }
}
