import 'package:flutter/material.dart';

/// 水波组件的基本使用
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
          child: InkWellTest(),
        ),
      ),
    );
  }
}

class InkWellTest extends StatefulWidget {
  @override
  _InkWellTestState createState() => _InkWellTestState();
}

class _InkWellTestState extends State<InkWellTest> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          width: 120,
          height: 120 * 0.681,
          child: Text("点我"),
        ),
        splashColor: Colors.grey, //水波纹色
        highlightColor: Colors.blue, //长按时会显示该色
        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)), //圆角半径
        onTapDown: (detail) => //点下事件
            print(
                '全局坐标:${detail.globalPosition}--相对坐标:${detail.localPosition}'),
        onTap: () => print("onTap in InkWell"), //单机事件
        onDoubleTap: () => print("onDoubleTap in InkWell"), //双击事件
        onLongPress: () => print("onLongPress in InkWell"), //长按事件
        onHighlightChanged: //高亮变化事件
            (bool value) => print("onHighlightChanged :$value"),
      ),
    );
  }
}
