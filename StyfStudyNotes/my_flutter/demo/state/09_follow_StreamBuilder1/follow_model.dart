import 'dart:async';

import 'follower.dart';

import 'api.dart';

enum StateType { loading, empty, error, fill }

class FollowModel {
  List<Follower> _data;
  final StreamController<StateType> _controller = StreamController();

  Stream<StateType> get state => _controller.stream; //获取状态流
  List<Follower> get data => _data; //获取数据

  //获取数据，并使用控制器为流添加元素
  Future<void> getListData() async {
    _controller.add(StateType.loading);
    _data = await GithubApi.getUserFollowers(login: "toly1994328")
        .catchError((e) => _controller.add(StateType.error));
    _controller.add(_data.isEmpty ? StateType.empty : StateType.fill);
  }

  void dispose() {
    _controller.close();
  }
}
