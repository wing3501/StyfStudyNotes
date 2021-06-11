import 'package:flutter/material.dart';

class UnknowPage extends StatelessWidget {
  static const String routeName = "/unknow";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('未知路由'),
      ),
      body: Container(),
    );
  }
}
