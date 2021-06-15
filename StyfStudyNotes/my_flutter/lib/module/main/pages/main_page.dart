import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static const String routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text('Main页面'),
        ),
        body: Container(),
      ),
    );
  }
}
