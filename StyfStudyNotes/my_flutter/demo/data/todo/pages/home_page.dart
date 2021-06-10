import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentic/bloc.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  final String user;

  HomePage({this.user = ""});

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<AuthenticBloc>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("主页"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthenticBloc>(context).add(LoggedOut());
            },
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
          )
        ],
      ),
      drawer: Drawer(),
      body: Align(
        alignment: Alignment(0, -.9),
        child: Text("hello ${user.name}",
            style: Theme.of(context).textTheme.display1),
      ),
    );
  }
}
