class GithubUser {

	String reposUrl;//仓库信息页
	String followingUrl;//关注人数的url
	String bio;//介绍
	String createdAt;//创建日期
	String login;//用户名
	String blog;//博客
	String subscriptionsUrl;
	String updatedAt;//最后更新日期
	String company;//公司
	String email;//邮箱
	String followersUrl;//被关注人数的url
	String receivedEventsUrl;
	int followers;//被关注人数
	String avatarUrl;//头像地址
	String htmlUrl;//github首页
	int following;//关注人数
	String name;//昵称
	String location;//地点


	GithubUser({this.reposUrl, this.followingUrl, this.bio,
		this.createdAt, this.login,  this.blog,
		this.subscriptionsUrl, this.updatedAt,
		this.company, this.email,  this.followersUrl,
		this.receivedEventsUrl, this.followers, this.avatarUrl,
		this.htmlUrl, this.following, this.name, this.location});

	GithubUser.fromJson(Map<String, dynamic> json) {
		var placeholder="秘密";
		reposUrl = json['repos_url'];
		followingUrl = json['following_url'];
		bio = json['bio']??placeholder;
		createdAt = json['created_at'];
		login = json['login'];
		blog = json['blog']??placeholder;
		subscriptionsUrl = json['subscriptions_url'];
		updatedAt = json['updated_at'];
		company = json['company']??placeholder;
		email = json['email']??placeholder;
		followersUrl = json['followers_url'];
		receivedEventsUrl = json['received_events_url'];
		followers = json['followers'];
		avatarUrl = json['avatar_url'];
		htmlUrl = json['html_url'];
		following = json['following'];
		name = json['name'];
		location = json['location']??placeholder;
	}
}
