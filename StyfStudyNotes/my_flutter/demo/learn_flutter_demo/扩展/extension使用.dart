import 'dart:ui';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_demo/favorcate/ui/shared/size_fit.dart';

void main() {
  runApp(MyApp());
}

extension StrSplit on String {
  List<String> mysplit(String split) {
    return this.split(split);
  }
}

extension DoubleFit on double {
  // double px() {
  //   return HYSizeFit.setPx(this);
  // }

  double get px {
    return HYSizeFit.setPx(this);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        darkTheme: ThemeData(),
        home: YFHomePage());
  }
}

class YFHomePage extends StatefulWidget {
  @override
  _YFHomePageState createState() => _YFHomePageState();
}

class _YFHomePageState extends State<YFHomePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      // data: ThemeData(primaryColor: Colors.orange),
      data: Theme.of(context).copyWith(primaryColor: Colors.orange), //拷贝原来的
      child: Scaffold(
        appBar: AppBar(
          title: Text('标题'),
        ),
        body: Center(child: Container()),
      ),
    );
  }
}
