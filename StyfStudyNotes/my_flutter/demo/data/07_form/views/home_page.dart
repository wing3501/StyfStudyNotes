import 'package:flutter/material.dart';

import 'login_page.dart';

class HomePage extends StatelessWidget {
  final String user;

  HomePage({this.user=""});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("主页"),),
      drawer: Drawer(),
      body: Align(
        alignment: Alignment(0,-.9),
        child: Text("hello $user",style: Theme.of(context).textTheme.display1),
      ),
    );
  }
}

