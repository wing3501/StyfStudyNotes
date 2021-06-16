import 'package:flutter/material.dart';

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

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTapDown: (details) {
                  print("outter click");
                },
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.yellow,
                  alignment: Alignment.center,
                ),
              ),
              GestureDetector(
                onTapDown: (details) {
                  print("inner click");
                },
                child: Container(width: 100, height: 100, color: Colors.red),
              )
            ],
          ),
        ));
  }

  GestureDetector buildGestureDetector() {
    return GestureDetector(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.orange,
      ),
      onTapDown: (details) {
        print("手指按下");
        print(details.globalPosition);
        print(details.localPosition);
      },
      onTapUp: (details) {
        print("手指抬起");
      },
      onTapCancel: () {
        print("手势取消");
      },
      onTap: () {
        print("手势点击");
      },
      onLongPress: () {
        print("手势长按");
      },
    );
  }

  Listener buildListener() {
    return Listener(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
      onPointerDown: (event) {
        // print("指针按下:$event");
        // print(event.position);
        print(event.localPosition);
      },
      onPointerMove: (event) {
        print("指针移动:$event");
      },
      onPointerUp: (event) {
        print("指针抬起:$event");
      },
    );
  }
}
