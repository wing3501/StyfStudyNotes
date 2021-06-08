import 'package:flutter/material.dart';

import 'circle_image_demo.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(child: buiildDemo2()),
      ),
    );
  }
}

Widget buiildDemo2() {
  var p1 = PoemItemWidget(
    data: PoemItem(
        image: AssetImage("assets/images/wy_200x300.jpg"),
        title: "以梦为马",
        author: "海子",
        summary: "我要做远方的忠诚的儿子，和物质的短暂情人，和所有以梦为马的诗人一样，我不得不和烈士和小丑走在同一道路上"),
  );

  var p2 = PoemItemWidget(
    data: PoemItem(
        isCard: false,
        image: AssetImage("assets/images/icon_head.png"),
        title: "山海诗",
        author: "张风捷特烈",
        summary:
            "在那片沧海，还未变成桑田的时候，就有了古老的歌，环响在丛林山涧。其声嘹响脱俗，其声缥缈虚无，那是谁的高声颤颤，那是谁的笑语连连。"),
  );
  var show = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[p1, p2],
  );
  return show;
}

/// 信息描述类
class PoemItem {
  ImageProvider image; //图片
  var title; //标题
  var author; //作者
  var summary; //摘要
  bool isCard; //是否卡片化
  PoemItem(
      {this.image, this.title, this.author, this.summary, this.isCard = true});
}

class PoemItemWidget extends StatelessWidget {
  PoemItemWidget({Key key, this.data}) : super(key: key);

  final PoemItem data;

  @override
  Widget build(BuildContext context) {
    var headIcon = Padding(
      padding: EdgeInsets.all(5),
      child: CircleImage(
        image: data.image,
      ),
    ); //头像
    var center = Column(
      //介绍
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(data.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "作者:${data.author}",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
    var summary = Text(
      //尾部摘要
      data.summary,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );
    var item = Row(
      //条目拼合
      children: <Widget>[
        SizedBox(width: 10),
        headIcon,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: center,
        ),
        Expanded(
          child: summary,
        ),
        SizedBox(width: 10),
      ],
    );
    var card = Card(
      elevation: 5,
      child: Padding(padding: EdgeInsets.all(5), child: item),
    );
    return data.isCard ? card : item;
  }
}

Widget buildDemo1() {
///////---------------------------------------------------------------
  var headIcon = Container(
      //左边头部
      decoration: BoxDecoration(
          //圆形装饰线
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            //阴影
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0.0, 0.0),
                blurRadius: 3.0,
                spreadRadius: 0.0)
          ]),
      width: 70,
      height: 70,
      child: Padding(
        padding: EdgeInsets.all(3),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/wy_200x300.jpg"),
        ),
      ));

  var center = Wrap(
    //中间
    direction: Axis.vertical, //竖直排列
    crossAxisAlignment: WrapCrossAlignment.start, //孩子水平左对齐
    spacing: 4, //主轴(竖)间距
    children: <Widget>[
      Text("以梦为马", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text(
        "作者:海子",
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    ],
  );

  var summary = Text(
    //尾部摘要
    "我要做远方的忠诚的儿子，和物质的短暂情人，和所有以梦为马的诗人一样，我不得不和烈士和小丑走在同一道路上",
    maxLines: 3, //最大三行
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: Colors.grey, fontSize: 12),
  );

  var item = Row(
    //条目拼合
    children: <Widget>[
      SizedBox(width: 10),
      headIcon,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: center,
      ),
      Expanded(
        child: summary,
      ),
      SizedBox(width: 10),
    ],
  );
  var show = Card(
    elevation: 5,
    child: Padding(padding: EdgeInsets.all(5), child: item), //阴影深
  );
  return show;
///////---------------------------------------------------------------
}
