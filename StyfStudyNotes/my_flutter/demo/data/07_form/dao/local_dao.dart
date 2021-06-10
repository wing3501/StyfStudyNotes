import 'dart:convert';

import '../bean/user_bean.dart';
import 'package:localstorage/localstorage.dart';

class LocalDao {
  LocalDao._();
  static LocalDao dao = LocalDao._(); //单例
  static String user_key = "user_key"; //定义小对象键

  LocalStorage _storage; //本地json存储对象

  Future<void> initLocalStorage() async {
    if (_storage == null) {
      _storage = LocalStorage('todo_user'); //创建存储文件
      await _storage.ready;
    }
  }

  Future<void> insert(String key, UserBean userBean) async {
    if (key == user_key) {
      await _storage.setItem(key, userBean.json);
    }
    return null;
  }

  Future<UserBean> queryUser() async {
    var data = await _storage.getItem(LocalDao.user_key);
    return UserBean.formMap(json.decode(data));
  }
}
