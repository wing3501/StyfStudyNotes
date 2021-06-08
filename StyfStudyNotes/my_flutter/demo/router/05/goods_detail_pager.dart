import 'package:flutter/material.dart';

import '../goods_widget.dart';

class GoodsDetailPager extends StatelessWidget {
  GoodsDetailPager({Key key, @required this.goods}) : super(key: key);
  final GoodBean goods;

  @override
  Widget build(BuildContext context) {
    var btn=  RaisedButton(
      onPressed: ()=>_toHome(context),
      child:  Text('返回主页'),
    );
   return  Scaffold(
      appBar:  AppBar(  title: Text(goods.title),
        backgroundColor: Colors.deepOrangeAccent, ),
      body:Wrap(children: <Widget>[Image(image: goods.image,),Text(goods.title),btn],) ,
    );;
  }

//跳转到主页
  void _toHome(BuildContext context) {
    Navigator.of(context).pop("朕已阅");
  }

}


