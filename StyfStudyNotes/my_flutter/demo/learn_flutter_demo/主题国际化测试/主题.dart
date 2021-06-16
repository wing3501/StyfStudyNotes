import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
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
            //亮度 基本不用
            // brightness: Brightness.dark,
            //主色调 包括导航栏\switch\floatingActionButton
            primarySwatch: Colors.purple,
            // 单独导航和tabbar的颜色，会覆盖上一个
            // primaryColor: Colors.green,
            // 单独设置switch\floatingActionButton
            // accentColor: Colors.purple,

            // buttonTheme: ButtonThemeData(
            //     minWidth: 10, height: 25, buttonColor: Colors.red),

            //卡片主题
            cardTheme: CardTheme(color: Colors.greenAccent, elevation: 5),
            //文字主题  Theme.of(context).textTheme
            textTheme: TextTheme(bodyText2: TextStyle(fontSize: 20)),
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
    return Theme(
      // data: ThemeData(primaryColor: Colors.orange),
      data: Theme.of(context).copyWith(primaryColor: Colors.orange), //拷贝原来的
      child: Scaffold(
        appBar: AppBar(
          title: Text('标题'),
        ),
        body: Center(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hello World"),
              Switch(
                value: true,
                onChanged: (value) {},
              ),
              CupertinoSwitch(
                value: true,
                activeColor: Colors.red,
                onChanged: (value) {},
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("a"),
              ),
              Card(
                child: Text(
                  "卡片卡片卡片?",
                  style: TextStyle(fontSize: 30),
                ),
              )
            ],
          ),
        )),
        floatingActionButton: Theme(
          //这里比较特殊
          data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(secondary: Colors.pink)),
          child: FloatingActionButton(
            child: Icon(Icons.pool),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
