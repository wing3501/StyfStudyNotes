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
      routes: {
        YFAboutPage.routeName: (ctx) => YFAboutPage(),
        "/": (ctx) => MainPage()
      },
      // home: MainPage()
      initialRoute: "/",
      onGenerateRoute: (settings) {
        if (settings.name == "/detail") {
          return MaterialPageRoute(
            builder: (context) {
              return YFDetailPage(settings.arguments);
            },
          );
        }
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return YFUnKnowPage();
          },
        );
      },
    );
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _jumpToDetail(context);
                  },
                  child: Text("跳转到详情")),
              ElevatedButton(
                  onPressed: () {
                    _jumpToAbout(context);
                  },
                  child: Text("跳转到关于")),
              ElevatedButton(
                  onPressed: () {
                    _jumpToDetail2(context);
                  },
                  child: Text("跳转到详情2")),
              ElevatedButton(
                  onPressed: () {
                    _jumpToSetting(context);
                  },
                  child: Text("跳转到设置")),
            ],
          ),
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

  void _jumpToAbout(BuildContext context) {
    Navigator.of(context)
        .pushNamed(YFAboutPage.routeName, arguments: "来自首页的信息");
  }

  void _jumpToDetail2(BuildContext context) {
    Navigator.of(context).pushNamed("/detail", arguments: "来自首页的信息11");
  }

  void _jumpToSetting(BuildContext context) {
    Navigator.of(context).pushNamed("/setting", arguments: "来自首页的信息11");
  }
}
