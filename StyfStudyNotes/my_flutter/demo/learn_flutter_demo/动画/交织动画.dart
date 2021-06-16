import 'dart:math';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

final eventbus = EventBus();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            primaryColor: Colors.green,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  Animation _sizeAnim;
  Animation _colorAnim;
  Animation _opacityAnim;
  Animation _radiansAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 0.0,
        upperBound: 1.0);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _sizeAnim = Tween(begin: 10.0, end: 200.0).animate(_controller);
    _colorAnim = ColorTween(begin: Colors.orange, end: Colors.purple)
        .animate(_controller);
    _opacityAnim = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _radiansAnim = Tween(begin: 0.0, end: 2 * pi).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: _opacityAnim.value,
              child: Transform(
                transform: Matrix4.rotationZ(_radiansAnim.value),
                alignment: Alignment.center,
                child: Container(
                  width: _sizeAnim.value,
                  height: _sizeAnim.value,
                  color: _colorAnim.value,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.play_arrow,
        ),
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            if (_controller.status == AnimationStatus.forward) {
              _controller.forward();
            } else if (_controller.status == AnimationStatus.reverse) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
