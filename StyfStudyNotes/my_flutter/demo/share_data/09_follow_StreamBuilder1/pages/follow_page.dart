import 'dart:async';

import 'package:flutter/material.dart';

import '../api.dart';
import '../follower.dart';
import '../follow_model.dart';
import 'follow/empty_page.dart';
import 'follow/error_page.dart';
import 'follow/fill_page.dart';
import 'follow/loading_page.dart';

class FollowerPage extends StatefulWidget {
  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  FollowModel _model = FollowModel(); //关联数据模型

  @override
  void initState() {
    super.initState();
    _model.getListData();
  }

  @override
  void dispose() {
    _model.dispose(); //关闭控制器
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
        stream: _model.state,
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
            onRefresh: _model.getListData, child: FillPage(_model.data));
    }
  }
}
