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

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[YFButton(), YFText()],
            ),
          ),
        ));
  }
}

class YFButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          eventbus.fire("这是一个事件");
        },
        child: Text("按钮"));
  }
}

class YFText extends StatefulWidget {
  YFText({Key key}) : super(key: key);

  @override
  _YFTextState createState() => _YFTextState();
}

class _YFTextState extends State<YFText> {
  String _message = "Hello";

  @override
  void initState() {
    super.initState();
    eventbus.on<String>().listen((event) {
      setState(() {
        print("监听到事件-->$event");
        _message = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_message),
    );
  }
}
