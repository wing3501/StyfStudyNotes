import 'dart:convert';
import 'package:http/http.dart' as client;

import 'follower.dart';

main() async {
  var followers = await GithubApi.getUserFollowers(login: "toly1994328");
  print(followers.length);
}

class GithubApi {
  static Future<Follower> getUser({String login = 'toly1994328'}) async {
    var api = 'https://api.github.com/users/$login'; //url
    var url = Uri.parse(api);
    var rep = await client.get(url); //发送get请求,获取响应
    return Follower.fromJson(json.decode(rep.body));
  }

  static Future<List<Follower>> getUserFollowers(
      {String login = 'toly1994328'}) async {
    var api = 'https://api.github.com/users/$login/followers'; //url
    var url = Uri.parse(api);
    var rep = await client.get(url); //发送get请求,获取响应
    print(rep.body);
    var list = json.decode(rep.body) as List;
    return list.map((e) => Follower.fromJson(e)).toList();
  }
}
