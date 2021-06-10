import 'dart:convert';

import '../../model/user_bean.dart';
import 'package:localstorage/localstorage.dart';

class LocalDao {
  LocalDao._();
  static LocalDao dao = LocalDao._(); //单例
  static String userKey = "user_key"; //定义小对象键

  LocalStorage _storage; //本地json存储对象

  Future<void> initLocalStorage() async {
    if (_storage == null) {
      _storage = LocalStorage('todo_user'); //创建存储文件
      await _storage.ready;
    }
  }

  Future<void> insert(UserBean userBean) async {
    await _storage.setItem(userKey, userBean.json);
  }

  Future<void> remove() async {
    await _storage.deleteItem(userKey);
  }

  Future<UserBean> queryUser() async {
    var data = await _storage.getItem(userKey);
    return UserBean.formMap(json.decode(data));
  }
}
