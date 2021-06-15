import 'package:flutter/material.dart';
import '../../../utils/fancy_icon_provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'), elevation: 0.0),
      body: Container(
          child: Row(
        children: [
          Text("data"),
          Icon(
            Icons.add,
            color: Color(0xFF333333),
            size: 30,
          )
        ],
      )),
    );
  }
}
