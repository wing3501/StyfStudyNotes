import 'dart:convert';
import 'package:http/http.dart' as client;

class SearchResult {
  final int totalCount; //总数
  final List<SearchResultItem> items; //条目
  SearchResult(this.totalCount, this.items);

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final items = (json["items"] as List)
        .map((item) => SearchResultItem.fromJson(item))
        .toList();
    return SearchResult(
      json["total_count"],
      items,
    );
  }
}

class SearchResultItem {
  final String fullName; //项目名
  final String url; //项目地址
  final String avatarUrl; //用户头像
  final String login; //用户名
  SearchResultItem(this.fullName, this.url, this.avatarUrl, this.login);

  factory SearchResultItem.fromJson(Map<String, dynamic> json) {
    return SearchResultItem(
      json['full_name'],
      json["html_url"],
      json["owner"]["avatar_url"],
      json["owner"]["login"],
    );
  }
}

main() async {
  var search = await GithubApi.search("DS");
  print(search.totalCount);
  print(search.items[0].fullName);
}

class GithubApi {
  static Future<SearchResult> search(String term) async {
    var api = "https://api.github.com/search/repositories?q=$term";
    final uri = Uri.parse(api);
    var rep = await client.get(uri); //发送get请求,获取响应
    final results = json.decode(rep.body);
    return SearchResult.fromJson(results);
  }
}
