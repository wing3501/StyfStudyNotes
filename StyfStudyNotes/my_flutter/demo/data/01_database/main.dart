import 'package:flutter/material.dart';

import 'dao/todo_dao.dart';
import 'home_page.dart';

void main() {
  runApp(FutureBuilder(
    future: TodoDao.db.initDB(),
    builder: (_, snap) {
      if (snap.connectionState == ConnectionState.done) {
        return MyApp();
      } else {
        return Material(
            child: Center(
                child: FlutterLogo(
          size: 80,
        )));
      }
    },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
