import 'package:flutter/material.dart';
import '../bean/search_result.dart';


class SearchResultItemWidget extends StatelessWidget {
  final SearchResultItem prop;//用户
  final Color color;//主色调
  SearchResultItemWidget({this.prop,this.color=Colors.blue});

  @override
  Widget build(BuildContext context) {

    var titleTextStyle = TextStyle(//标题文字样式
        color: this.color, fontSize: 17,
        shadows: [Shadow(color: Colors.black, offset: Offset(.3, .3))]);

    var image= FadeInImage.assetNetwork(//图片
        placeholder: "assets/images/default_image.png",
        image: prop.avatarUrl);

    var tile=ListTile(//布局主体
        leading: Container(child:ClipOval(child: image),//左边
          padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle, //圆形装饰线
                color: Colors.white,
                boxShadow: [BoxShadow(color: this.color.withAlpha(55),
                  offset: Offset(0.0, 0.0), blurRadius: 3.0, spreadRadius: 0.0,)],
              ),
        ),
      title: Text("${prop.fullName}",style: titleTextStyle),//中间上部
      subtitle: Text("作者:${prop.login}",style: TextStyle(fontSize: 16),),
      trailing: InkWell(child: Icon(Icons.close)),//尾部
    );

    return Container(
        height: 70,
         alignment: Alignment.center,
        color: color.withAlpha(11),
        child: tile,
    );
  }
}

