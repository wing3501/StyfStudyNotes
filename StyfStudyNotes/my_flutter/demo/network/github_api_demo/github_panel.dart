import 'package:flutter/material.dart';
import 'github_user.dart';

class GithubUserPanel extends StatelessWidget {
  final GithubUser user; //用户
  final Color color; //主色调
  GithubUserPanel({this.user, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    var titleTextStyle = TextStyle(
        //标题文字样式
        color: this.color,
        fontSize: 17,
        shadows: [Shadow(color: Colors.black, offset: Offset(.3, .3))]);
    var infoStyle = TextStyle(
        //信息文字样式
        color: Colors.black.withAlpha(150),
        fontSize: 12,
        shadows: [Shadow(color: Colors.white, offset: Offset(.3, .3))]);

    var image = FadeInImage.assetNetwork(
        //图片
        placeholder: "assets/images/default_image.png",
        image: user.avatarUrl);

    var tile = ListTile(
      //布局主体
      leading: Container(
        child: ClipOval(child: image), //左边
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle, //圆形装饰线
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: this.color.withAlpha(55),
              offset: Offset(0.0, 0.0),
              blurRadius: 3.0,
              spreadRadius: 0.0,
            )
          ],
        ),
      ),
      title: Text(user.name ?? user.login, style: titleTextStyle), //中间上部
      subtitle: Wrap(
        //中间下部
        direction: Axis.vertical,
        spacing: 2,
        children: <Widget>[
          Text("${user.location} | ${user.company}", style: infoStyle),
          Text(
            user.bio,
            style: infoStyle,
          ),
        ],
      ),
      trailing: Icon(Icons.close), //尾部
    );

    return Container(
      height: 80,
      alignment: Alignment.center,
      color: color.withAlpha(11),
      child: tile,
    );
  }
}
