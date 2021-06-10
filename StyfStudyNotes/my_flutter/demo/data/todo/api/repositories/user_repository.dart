import 'package:flutter/material.dart';
import '../../model/login_result.dart';
import '../../model/user_bean.dart';
import '../dao/local_dao.dart';

/// create by 张风捷特烈 on 2020/6/1
/// contact me by email 1981462002@qq.com
/// 说明:

class UserRepository {
  Future<UserBean> getLocalUser() async {
    return await LocalDao.dao.queryUser();
  }

  Future<void> setLocalUser(UserBean userBean) async {
    await LocalDao.dao.insert(userBean);
  }

  Future<LoginResult> authenticate({
    @required String username,
    @required String password,
  }) async {
    //  var result = await Api.login(username,password);
    //  通过result获取token和用户信息
    await Future.delayed(Duration(seconds: 1)); //模拟登陆请求耗时
    if (username == 'toly' && password == '111111') {
      return LoginResult(
        status: true,
        msg: '你获得的token值',
        user: UserBean(name: 'toly'),
      );
    } else {
      return LoginResult(
        status: false,
        msg: '用户名密码错误',
        user: null,
      );
    }
  }

  Future<bool> doRegister(UserBean user) async {
    await Future.delayed(Duration(seconds: 1)); //延时--模拟注册--
    //请求注册接口...
    return true;
  }

  Future<void> deleteLocalUser() async {
    return await LocalDao.dao.remove();
  }
}
