import 'dart:async';

import 'package:flutter/material.dart';

import '../api.dart';
import '../follower.dart';
import 'follow/empty_page.dart';
import 'follow/error_page.dart';
import 'follow/fill_page.dart';
import 'follow/loading_page.dart';

enum StateType { loading, empty, error, fill }

class FollowerPage extends StatefulWidget {
  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  List<Follower> _data; //数据
  final StreamController<StateType> _controller = StreamController();

  @override
  void initState() {
    super.initState();
    _getListData();
  }

  @override
  void dispose() {
    _controller.close(); //关闭控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StreamBuilder"),
      ),
      body: Center(
          child: StreamBuilder<StateType>(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
            _buildByState(snapshot), //根据snapshot生成界面
      )),
    );
  }

  //根据状态显示界面
  Widget _buildByState(AsyncSnapshot<StateType> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return LoadingPage();
    }
    switch (snapshot.data) {
      case StateType.loading:
        return LoadingPage();
      case StateType.empty:
        return EmptyPage();
      case StateType.error:
        return ErrorPage();
      case StateType.fill:
        return RefreshIndicator(
            onRefresh: _getListData, child: FillPage(_data));
    }
  }

  //获取数据，并使用控制器为流添加元素
  Future<void> _getListData() async {
    _controller.add(StateType.loading);
    _data = await GithubApi.getUserFollowers(login: "toly1994328")
        .catchError((e) => _controller.add(StateType.error));
    _controller.add(_data.isEmpty ? StateType.empty : StateType.fill);
  }
}
