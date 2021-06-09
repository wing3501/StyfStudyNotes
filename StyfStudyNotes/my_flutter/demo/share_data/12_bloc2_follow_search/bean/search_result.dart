enum SearchType { noTerm, empty, populated }


class SearchResult {
  final int totalCount;//总数
  final List<SearchResultItem> items;//条目
  final SearchType type;
  SearchResult(this.totalCount,this.type, this.items);


  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final items = (json["items"] as List).map((item) =>
        SearchResultItem.fromJson(item)).toList();

    var type=items.isEmpty ? SearchType.empty : SearchType.populated;

    return SearchResult( json["total_count"] , type,items);
  }
}

class SearchResultItem {
  final String fullName;//项目名
  final String url;//项目地址
  final String avatarUrl;//用户头像
  final String login;//用户名
  SearchResultItem(this.fullName,
      this.url, this.avatarUrl,this.login);

  factory SearchResultItem.fromJson
      (Map<String, dynamic> json) {
    return SearchResultItem(
      json['full_name'],
      json["html_url"],
      json["owner"]["avatar_url"],
      json["owner"]["login"],
    );
  }
}

