import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
  int _counter = 101;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: CounterWidget(
        counter: _counter,
        child: Column(
          children: <Widget>[ShowData01(), ShowData02(), ShowData03()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
      ),
    );
  }
}

class ShowData01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int counter = CounterWidget.of(context).counter;
    return Card(
      color: Colors.red,
      child: Text("当前计数：$counter"),
    );
  }
}

class ShowData02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int counter = CounterWidget.of(context).counter;
    return Container(
      color: Colors.blue,
      child: Text("当前计数：$counter"),
    );
  }
}

class ShowData03 extends StatefulWidget {
  @override
  _ShowData03State createState() => _ShowData03State();
}

class _ShowData03State extends State<ShowData03> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_ShowData03State didChangeDependencies调用了");
  }

  @override
  Widget build(BuildContext context) {
    int counter = CounterWidget.of(context).counter;
    return Container(
      color: Colors.yellow,
      child: Text("当前计数：$counter"),
    );
  }
}

class CounterWidget extends InheritedWidget {
  final int counter;

  CounterWidget({Key key, this.child, this.counter})
      : super(key: key, child: child);

  final Widget child;

  static CounterWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterWidget>();
  }

  @override
  bool updateShouldNotify(CounterWidget oldWidget) {
    return oldWidget.counter != counter;
  }
}
