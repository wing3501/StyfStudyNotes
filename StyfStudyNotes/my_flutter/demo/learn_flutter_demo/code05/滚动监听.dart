import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        // home:SafeArea()
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller = ScrollController(initialScrollOffset: 300);
  bool _isShow = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      print("监听到滚动----${_controller.offset}");
      setState(() {
        _isShow = _controller.offset > 1000;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            print("开始滚动");
          } else if (notification is ScrollEndNotification) {
            print("结束滚动");
          } else if (notification is ScrollUpdateNotification) {
            print(
                "正在滚动===总${notification.metrics.maxScrollExtent} 当前${notification.metrics.pixels}");
          } else {}

          return true; //停止冒泡
        },
        child: ListView.builder(
            /**
     * 两种方式可以监听:
     *  controller:
     *    1.可以设置默认值offset
     *    2.监听滚动, 也可以监听滚动的位置
     *  NotificationListener
     *    1.开始滚动和结束滚动
     */
            controller: _controller,
            itemCount: 100,
            itemBuilder: (BuildContext btx, int index) {
              return ListTile(
                leading: Icon(Icons.people),
                title: Text("联系人$index"),
              );
            }),
      ),
      floatingActionButton: _isShow
          ? FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
            )
          : null,
    );
  }
}
