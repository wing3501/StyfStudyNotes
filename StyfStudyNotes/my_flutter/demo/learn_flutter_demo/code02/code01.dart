import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品列表"),
      ),
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomeProductItem("标题1", "描述1",
            "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/a6efce1b9d16fdfabf36882ab08f8c5495ee7b9f.jpg"),
        HomeProductItem("标题2", "描述2",
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3599690714,1456928921&fm=26&gp=0.jpg"),
        HomeProductItem("标题3", "描述3",
            "https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/0824ab18972bd40797d8db1179899e510fb3093a.jpg")
      ],
    );
  }
}

class HomeProductItem extends StatelessWidget {
  final String title;
  final String desc;
  final String imageURL;
  final style1 = TextStyle(fontSize: 25, color: Colors.orange);
  final style2 = TextStyle(fontSize: 20, color: Colors.green);

  HomeProductItem(this.title, this.desc, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration:
          BoxDecoration(border: Border.all(width: 5, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: style1,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            desc,
            style: style2,
          ),
          SizedBox(
            height: 8,
          ),
          Image.network(imageURL)
        ],
      ),
    );
  }
}
