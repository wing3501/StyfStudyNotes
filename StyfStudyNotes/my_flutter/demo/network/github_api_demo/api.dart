import 'dart:convert';

import 'package:http/http.dart' as client;

import 'github_user.dart';

class GithubApi {
  static Future<GithubUser> getUser({String login = 'toly1994328'}) async {
    var api = 'https://api.github.com/users/$login'; //url
    final uri = Uri.parse(api);
    var rep = await client.get(uri); //发送get请求,获取响应
    return GithubUser.fromJson(json.decode(rep.body));
  }
}
