import 'dart:convert' as prefix0;

import 'package:flutter/material.dart';

class UserBean {
  @required
  String name; //名称
  String imagePath; //头像路径
  @required
  String password; //密码

  UserBean({this.name = "toly", this.password = "root", this.imagePath = ""});

  String get json {
    return prefix0.json.encode(this);
  }

  factory UserBean.formMap(Map<String, dynamic> map) => UserBean(
        name: map["name"],
        password: map["password"],
        imagePath: map["imagePath"],
      );

  Map toJson() {
    Map map = new Map();
    map["name"] = this.name;
    map["password"] = this.password;
    map["imagePath"] = this.imagePath;
    return map;
  }
}
