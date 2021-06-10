import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'app/provider/i18n/i18n.dart';
import 'app/provider/theme_state.dart';
import 'side_page.dart';

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
          title: Text(I18N.of(context).title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<ThemeState>(
                  builder: (_, state, __) => Text(
                        I18N.of(context).countInfo,
                        style:
                            TextStyle(color: state.primaryColor, fontSize: 18),
                      )),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: Consumer<ThemeState>(
          builder: (_, state, __) => FloatingActionButton(
            onPressed: _incrementCounter,
            backgroundColor: state.primaryColor,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ));
  }
}
