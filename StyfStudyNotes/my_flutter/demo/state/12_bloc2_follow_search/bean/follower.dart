class Follower {
  final String login; //用户名
  final String avatarUrl; //头像地址
  final String htmlUrl; //主页
  final String url; //用户信息api
  const Follower(this.login, this.avatarUrl, this.htmlUrl, this.url); //github首页
  factory Follower.fromJson(Map<String, dynamic> json) =>
      Follower(json['login'], json['avatar_url'], json['html_url'], json['url']);
}
