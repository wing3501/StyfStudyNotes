import 'package:flutter/material.dart';

import 'api.dart';
import 'github_panel.dart';
import 'github_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            subhead: TextStyle(textBaseline: TextBaseline.alphabetic)),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: GithubShower(),
        ),
      ),
    );
  }
}

class GithubShower extends StatefulWidget {
  @override
  _GithubShowerState createState() => _GithubShowerState();
}

class _GithubShowerState extends State<GithubShower> {
  GithubUser _user;
  @override
  void initState() {
    super.initState();
    _fetchData(); //初始时获取数据
  }

  @override
  Widget build(BuildContext context) {
    //加载中视图
    var loadingView = Container(
        height: 80,
        child: Center(
          child: CircularProgressIndicator(),
        ));
    //完成后视图
    var panel = GithubUserPanel(
      user: _user,
      color: Colors.black,
    );
    return Card(child: _user != null ? panel : loadingView); //根据状态控制显示
  }

  _fetchData() async {
    //获取数据
    _user = await GithubApi.getUser(login: "wing3501"); //调用api
    setState(() {}); //渲染布局
  }
}
