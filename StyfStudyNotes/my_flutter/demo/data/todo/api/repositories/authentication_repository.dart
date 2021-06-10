import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  String _token;
  String get token => _token;

  //删除token
  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 1)); //模拟延迟，可删
    var sp = await SharedPreferences.getInstance();
    sp.remove('is_login');
    // 真实场景可在此删除的token ...
    return;
  }

  //固化token
  Future<void> persistToken(String token) async {
    var sp = await SharedPreferences.getInstance();
    sp.setBool('is_login', true);
    // 真实场景可在此固化的token ...
    return;
  }

  //检查是否有token
  Future<bool> hasToken() async {
    var sp = await SharedPreferences.getInstance();
    var isLogin = sp.getBool('is_login') ?? false;
    // 真实场景可在此读取固化的token ...
    // _token = ...
    return isLogin;
  }
}
