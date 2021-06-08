import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
            child: FlutterText(
          str: "捷",
          style: TextStyle(fontSize: 30),
        )),
      ),
    );
  }
}

class FlutterText extends StatefulWidget {
  final String str;
  final TextStyle style;

  FlutterText({this.str, this.style});

  _FlutterTextState createState() => _FlutterTextState();
}

class _FlutterTextState extends State<FlutterText>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    animation = TweenSequence<double>([
      //使用TweenSequence进行多组补间动画
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 15), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 13, end: -13), weight: 2),
      TweenSequenceItem<double>(tween: Tween(begin: -11, end: 11), weight: 3),
      TweenSequenceItem<double>(tween: Tween(begin: 9, end: -9), weight: 4),
      TweenSequenceItem<double>(tween: Tween(begin: -7, end: 7), weight: 5),
      TweenSequenceItem<double>(tween: Tween(begin: 5, end: -5), weight: 6),
      TweenSequenceItem<double>(tween: Tween(begin: 3, end: -0), weight: 7),
    ]).animate(controller);

    animation =
        Tween(begin: 0.0, end: pi / 180).animate(animation); //加buff,将参数转化为弧度

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimRotate(
      animation: animation,
      child: Text(
        widget.str,
        style: widget.style,
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimRotate extends AnimatedWidget {
  AnimRotate({Key key, Animation<double> animation, this.child})
      : super(key: key, listenable: animation);
  final Widget child; //孩子组件
  @override
  Widget build(BuildContext context) {
    final Animation animation = listenable; //获取动画器
    return Transform(
      //根据动画器数值对孩子进行旋转
      child: child,
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(animation.value),
    );
  }
}
