import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String msg;

  LoadingPage({this.msg = 'loading...'});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        width: 100,
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.blue,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
            ),
            SizedBox(
              height: 10,
            ),
            Text(msg)
          ],
        ),
      ),
    );
  }
}
