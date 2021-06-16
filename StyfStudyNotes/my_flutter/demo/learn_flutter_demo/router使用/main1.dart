import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'detail.dart';

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

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: Center(
          child: Container(
              child: ElevatedButton(
                  onPressed: () {
                    _jumpToDetail(context);
                  },
                  child: Text("跳转到详情"))),
        ));
  }

  void _jumpToDetail(BuildContext context) {
    Future result = Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return YFDetailPage("首页传过去的数据");
      },
    ));

    result.then((value) => print("pop返回:$value"));
    //普通跳转方式
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //     return YFDetailPage("首页传过去的数据");
    //   },
    // ));
    // Navigator.push(context, route)
  }
}
