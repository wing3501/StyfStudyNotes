import 'dart:convert' as prefix0;

import 'package:flutter/material.dart';

class UserBean {
  @required
  String name; //名称
  @required
  String password; //密码

  UserBean({this.name = "toly", this.password = "root"});

  String get json {
    return prefix0.json.encode(this);
  }

  factory UserBean.formMap(Map<String, dynamic> map) => UserBean(
        name: map["name"],
        password: map["password"],
      );

  Map toJson() {
    Map map = new Map();
    map["name"] = this.name;
    map["password"] = this.password;
    return map;
  }
}
