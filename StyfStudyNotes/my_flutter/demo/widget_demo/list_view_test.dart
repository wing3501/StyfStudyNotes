/*
 * @Author: your name
 * @Date: 2021-06-08 11:22:58
 * @LastEditTime: 2021-06-08 11:51:04
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /my_flutter/demo/list_view_test.dart
 */
import 'dart:math';

import 'package:flutter/material.dart';

import 'chat_widget_demo.dart';
import 'poem_item_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: ChatPage(),
        ),
      ),
    );
  }
}

///----------- 上拉下拉

class ChatApi {
  var random = Random(); //随机数
  List<ChatItem> _chatItem = <ChatItem>[];
  List<ChatItem> get chatItem => _chatItem;

  ChatApi.monk(int count) {
    var strs = [
      "我是要成为编程之王的男人，"
              "你是要成为编程之王的女人；" *
          10,
      "Hello World",
      "凭君莫话封侯事，一将功成万骨枯。你觉得如何?",
      "识君，吾之幸也;失君，吾之憾也;守君，吾之愿也。",
      "简单必有简单的成本，复杂必有复杂的价值。"
    ];

    for (var i = 0; i < count; i++) {
      _chatItem.add(ChatItem(
          headIcon: AssetImage(i.isEven
              ? "assets/images/wy_200x300.jpg"
              : "assets/images/icon_head.png"),
          text: strs[random.nextInt(strs.length)],
          type: i.isEven ? ChartType.left : ChartType.right));
    }
  }

  Future<void> addTop() async {
    //模拟耗时
    await Future.delayed(Duration(seconds: 3));
    _chatItem.insert(
        0,
        ChatItem(
            headIcon: AssetImage("assets/images/wy_200x300.jpg"),
            type: ChartType.left,
            text: "我是下拉出来的"));
  }

  Future<void> addBottom() async {
    //模拟耗时
    await Future.delayed(Duration(seconds: 3));
    _chatItem.add(
      ChatItem(
          headIcon: AssetImage("assets/images/icon_head.png"),
          type: ChartType.right,
          text: "我是上拉出来的"),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatItem> _data; //数据
  final ChatApi api = ChatApi.monk(50);

  ScrollController _scrollController = ScrollController(); //定义变量及初始化

  @override
  void initState() {
    _data = api.chatItem; //初始化数据

    _scrollController.addListener(() {
      //添加监听
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); //释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var content = ListView.builder(
        controller: _scrollController,
        itemCount: _data.length + 1, //条目的个数
        itemBuilder: (BuildContext context, int index) => index == _data.length
            ? //数据填充条目
            LoadMoreWidget()
            : ChatWidget(
                chartItem: _data[index],
              ));

    return RefreshIndicator(
      child: content,
      onRefresh: _render,
    );
  }

  //异步请求+更新界面
  Future<void> _render() async {
    await api.addTop();
    setState(() {
      _data = api.chatItem;
    });
  }

  //加载逻辑
  _loadMore() async {
    await api.addBottom();
    setState(() {
      _data = api.chatItem;
    });
  }
}

class LoadMoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(28.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

///----------- 上拉下拉
///
/// 聊天记录demo
Widget buildDemo5() {
  var data = ChatApi.monk(50).chatItem; //获取数据
  var show = ListView.builder(
    itemCount: data.length, //条目的个数
    itemBuilder: (BuildContext context, int index) =>
        ChatWidget(chartItem: data[index]),
  );
  return show;
}

/// ListView.separated使用
Widget buidlDemo4() {
  var data = <PoemItem>[];
  for (var i = 0; i < 20; i++) {
    //模拟数据
    data.add(PoemItem(
        isCard: false,
        image: AssetImage("assets/images/wy_200x300.jpg"),
        title: "$i:以梦为马",
        author: "海子",
        summary: "我要做远方的忠诚的儿子"
            "和物质的短暂情人，和所有以梦为马的诗人一样，"
            "我不得不和烈士和小丑走在同一道路上"));
  }

  var show = ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: data.length, //条目的个数
      itemBuilder: (BuildContext context, int index) => PoemItemWidget(
            data: data[index],
          ),
      separatorBuilder: (BuildContext context, int index) => Padding(
          padding: EdgeInsets.only(left: 90),
          child: Divider(
            height: 1,
            color: Colors.orangeAccent,
          )));
  return show;
}

/// 数据填充条目界面
Widget buildDemo3() {
  var data = <PoemItem>[];
  for (var i = 0; i < 20; i++) {
    //模拟数据
    data.add(PoemItem(
        isCard: false,
        image: AssetImage("assets/images/wy_200x300.jpg"),
        title: "$i:以梦为马",
        author: "海子",
        summary: "我要做远方的忠诚的儿子"
            "和物质的短暂情人，和所有以梦为马的诗人一样，"
            "我不得不和烈士和小丑走在同一道路上"));
  }

//数据填充条目界面
  var show = ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: data.length, //条目的个数
      itemBuilder: (BuildContext context, int index) =>
          PoemItemWidget(data: data[index]));
  return show;
}

/// 使用builder方法进行构造
Widget buildDemo2() {
  var caverStyle = TextStyle(fontSize: 18, shadows: [
    //文字样式
    Shadow(color: Colors.white, offset: Offset(-0.5, 0.5), blurRadius: 0)
  ]);

  const colorMap = {
    //数据来源
    0xffff0000: "红色", 0xffFFFF00: "黄色", 0xff00FF00: "绿色", 0xff0000FF: "蓝色",
  };
  var show = ListView.builder(
      //使用builder方法进行构造
      padding: EdgeInsets.all(8.0),
      itemCount: colorMap.length, //条目的个数
      itemBuilder: (BuildContext context, int index) => //条目构造器
          Container(
            height: 50,
            color: Color(colorMap.keys.toList()[index]),
            child: Center(
                child: Text(
              '${colorMap.values.toList()[index]}',
              style: caverStyle,
            )),
          ));
  return show;
}

//-------基本使用
Widget buildDemo1() {
  var caverStyle = TextStyle(fontSize: 18, shadows: [
    //文字样式
    Shadow(color: Colors.white, offset: Offset(-0.5, 0.5), blurRadius: 0)
  ]);

  var show = ListView(
    //ListView的构造方法
    scrollDirection: Axis.vertical, //水平的ListView
    padding: EdgeInsets.all(8.0), //边距
    children: <Widget>[
      //孩子们
      Container(
        height: 50,
        color: Color(0xffff0000),
        child: Center(
            child: Text(
          '红色',
          style: caverStyle,
        )),
      ),
      Container(
        height: 50,
        color: Color(0xffFFFF00),
        child: Center(
            child: Text(
          '黄色',
          style: caverStyle,
        )),
      ),
      Container(
        height: 50,
        color: Color(0xff00FF00),
        child: Center(
            child: Text(
          '绿色',
          style: caverStyle,
        )),
      ),
      Container(
        height: 50,
        color: Color(0xff0000FF),
        child: Center(
            child: Text(
          '蓝色',
          style: caverStyle,
        )),
      ),
    ],
  );
  return show;
}
