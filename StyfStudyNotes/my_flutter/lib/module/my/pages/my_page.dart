import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  static const String routeName = "/my";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Container(),
    );
  }
}
