import 'package:flutter/material.dart';

import 'animated_widget_demo.dart';

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
            "代码，改变生活",
            config: AnimConfig(
                mode: FlutterMode.left_right,
                duration: 1000,
                offset: 8,
                curve: Curves.linear),
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}

class FlutterText extends StatelessWidget {
  final String str;
  final TextStyle style;
  final AnimConfig config;
  FlutterText(this.str, {Key key, this.style, this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
      children: str
          .split("")
          .map((e) => FlutterContainer(
                config: config,
                child: Text(e, style: style),
              ))
          .toList());
}
