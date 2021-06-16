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
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.pool),
        onPressed: () {
          //modal页面
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) {
          //       return YFModalPage();
          //     },
          //     fullscreenDialog: true));

          Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: YFModalPage(),
              );

              // return YFModalPage();
            },
          ));
        },
      ),
    );
  }
}
