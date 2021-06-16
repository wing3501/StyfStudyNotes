import 'package:flutter/material.dart';

class YFAboutPage extends StatelessWidget {
  static const String routeName = "/about";

  const YFAboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          title: Text('关于'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(message),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("返回首页"))
            ],
          ),
        ));
  }
}
