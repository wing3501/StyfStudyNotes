import 'package:flutter/material.dart';

import 'pages/follow_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            subhead: TextStyle(textBaseline: TextBaseline.alphabetic)),
        primarySwatch: Colors.blue,
      ),
      home: FollowerPage(),
    );
  }
}
