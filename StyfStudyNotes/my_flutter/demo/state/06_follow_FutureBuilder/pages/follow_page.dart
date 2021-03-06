import 'package:flutter/material.dart';

import '../api.dart';
import '../follower.dart';
import 'follow/empty_page.dart';
import 'follow/error_page.dart';
import 'follow/fill_page.dart';
import 'follow/loading_page.dart';

class FollowerPage extends StatefulWidget {
  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关注者"),
      ),
      body: Center(
          child: FutureBuilder<List<Follower>>(
        future: GithubApi.getUserFollowers(login: "toly1994328"),
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
            _buildByState(snapshot), //根据snapshot生成界面
      )),
    );
  }

  //根据状态显示界面
  Widget _buildByState(AsyncSnapshot<List<Follower>> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none: //开始异步之前
      case ConnectionState.active:
      case ConnectionState.waiting: //等待异步结果
        return LoadingPage();
      case ConnectionState.done: //完成
        if (snapshot.hasError) return ErrorPage();
        if (snapshot.data.isEmpty) return ErrorPage();
        return FillPage(snapshot.data);
    }
  }
}
