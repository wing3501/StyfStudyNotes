import 'package:flutter/material.dart';

class YFModalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Modal page'),
        ),
        body: Container(
          color: Colors.blue,
          child: Center(
            child: Text("Modal Page"),
          ),
        ));
  }
}
