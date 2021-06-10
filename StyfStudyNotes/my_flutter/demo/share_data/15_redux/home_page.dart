import 'package:flutter/material.dart';

import 'side_page.dart';
import 'package:flutter_redux/flutter_redux.dart';


import 'app/redux/app_redux.dart';

//class CountViewModel{
//  final int count=0;
//  final
//}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SlidePage(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StoreBuilder<AppState>(builder: (context, store) => Text(
              'You have pushed the button this many times:',
               style: TextStyle(color: store.state.themeState.primaryColor,fontSize: 18),
            )),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton:StoreBuilder<AppState>(builder: (context, store) => FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: store.state.themeState.primaryColor,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    ));
  }
}
