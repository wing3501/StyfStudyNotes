import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  static const String routeName = "/message";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
      ),
      body: Container(),
    );
  }
}
