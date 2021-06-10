import 'package:flutter/material.dart';
import 'bean/github_user.dart';



class GithubUserPanel extends StatelessWidget {
  final GithubUser user;
  final Color color;

  GithubUserPanel({this.user,this.color=Colors.blue});
  @override
  Widget build(BuildContext context) {
    var titleTextStyle = TextStyle(//标题文字样式
        color: this.color,
        fontSize: 17,
        shadows: [Shadow(color: Colors.black, offset: Offset(.3, .3))]);

    var infoStyle = TextStyle(//标题文字样式
        color: Colors.black.withAlpha(150),
        fontSize: 12,
        shadows: [Shadow(color: Colors.white, offset: Offset(.3, .3))]);

    var image= FadeInImage.assetNetwork(
        placeholder: "assets/images/default_image.png",
        image: user.avatarUrl);

    var tile=ListTile(
        leading: Container(
          padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle, //圆形装饰线
                color: Colors.white,
                boxShadow: [
                  BoxShadow(//阴影
                    color: this.color.withAlpha(55),
                    offset: Offset(0.0, 0.0), blurRadius: 3.0, spreadRadius: 0.0,
                  ),
                ],
              ),
            child:ClipOval(child: image),
        ),
      title: Text(user.name,style: titleTextStyle),
      subtitle: Wrap(
        direction: Axis.vertical,
        spacing: 2,
        children: <Widget>[
          Text("${user.location} | ${user.company}",style: infoStyle),
          Text(user.bio,style: infoStyle,),
        ],
      ),
      trailing: Icon(Icons.close),
    );

    return Container(
        height: 80,
         alignment: Alignment.center,
        color: color.withAlpha(11),
        child: tile,
    );
  }

}

