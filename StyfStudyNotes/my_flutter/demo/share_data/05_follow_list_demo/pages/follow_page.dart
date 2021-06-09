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
  List<Follower> _followers; //数据
  StateType _state = StateType.loading; //当前状态量

  @override
  void initState() {
    super.initState();
    _fetchData(); //初始时获取数据
  }

  @override
  Widget build(BuildContext context) {
    _state = _checkState(); //检查状态
    return Scaffold(
        appBar: AppBar(
          title: Text("关注者"),
        ),
        body: Center(child: _buildByState(_state)) //根据状态控制显示
        );
  }

  //获取数据
  _fetchData() async {
    try {
      _followers =
          await GithubApi.getUserFollowers(login: "toly1994328"); //调用api
    } catch (e) {
      print(e);
      _state = StateType.error;
    }
    setState(() {}); //渲染布局
  }

  //检查状态
  StateType _checkState() {
    if (_state == StateType.error) return _state; //如果当前已是错误，返回
    if (_followers == null) {
      //当前数据对象为空
      return StateType.loading;
    } else if (_followers.isEmpty) {
      //当前列表无数据
      return StateType.empty;
    } else {
      return StateType.fill;
    }
  }

  //根据状态显示界面
  Widget _buildByState(StateType state) {
    switch (state) {
      case StateType.loading:
        return LoadingPage();
        break;
      case StateType.empty:
        return EmptyPage();
        break;
      case StateType.error:
        return ErrorPage();
        break;
      case StateType.fill:
        return FillPage(_followers);
        break;
    }
  }
}
