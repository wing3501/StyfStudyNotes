import 'package:flutter/material.dart';

/// 手势的基本使用---点击和拖拽
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
          child: GestureDetectorTest1(),
        ),
      ),
    );
  }
}

/// 拖拽-----------
class GestureDetectorTest1 extends StatefulWidget {
  @override
  _GestureDetectorTestState1 createState() => _GestureDetectorTestState1();
}

class _GestureDetectorTestState1 extends State<GestureDetectorTest1> {
  @override
  Widget build(BuildContext context) {
    var show = GestureDetector(
      child: Container(
        color: Colors.cyanAccent,
        width: 300,
        height: 100,
      ),
      onPanDown: (detail) => print(
          "拖拽按下:全局${detail.globalPosition})" "--相对:${detail.localPosition})"),
      onPanStart: (detail) => print(
          "开始拖拽:全局${detail.globalPosition})" "--相对:${detail.localPosition})"),
      onPanUpdate: (detail) => print(
          "拖拽更新:全局${detail.globalPosition})" "--相对:${detail.localPosition})"),
      onPanEnd: (detail) => print("拖拽结束速度:${detail.velocity})"),
      onPanCancel: () => print("onPanCancel in my box"),
    );
    return Center(child: show);
  }
}

///  点击----------
class GestureDetectorTest extends StatefulWidget {
  @override
  _GestureDetectorTestState createState() => _GestureDetectorTestState();
}

class _GestureDetectorTestState extends State<GestureDetectorTest> {
  @override
  Widget build(BuildContext context) {
    var show = GestureDetector(
        child: Container(
          color: Colors.cyanAccent,
          width: 100,
          height: 100,
        ),
        onTap: () {
          //点击回调
          print("onTap in my box");
        },
        onTapDown: (detail) => //按下回调
            print(
                'onTapDown: 全局坐标:${detail.globalPosition}--相对坐标:${detail.localPosition}'),
        onTapUp: (detail) => //抬起回调
            print(
                'onTapUp: 全局坐标:${detail.globalPosition}--相对坐标:${detail.localPosition}'),
        onTapCancel: () => print("onTapCancel in my box"), //取消回调
        onDoubleTap: () => print("onDoubleTap in my box"), //双击回调
        onLongPress: () => print("onLongPress in my box"), //长按回调
        onLongPressUp: () => print("onLongPressUp in my box") //长按抬起回调
        );
    return Center(child: show);
  }
}
