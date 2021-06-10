import 'package:flutter/material.dart';

import 'dao/todo_dao.dart';
import 'model/todo_bean.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '数据库版本:${_counter}',
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  _getVersion() async {
    var db = await TodoDao.db.database;
    _counter = await db.getVersion();
    setState(() {});
  }
}
