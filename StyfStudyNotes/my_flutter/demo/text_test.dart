import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
///////----------------------4.1.1  Text的基本使用-1----------------------
//    var text=Text("toly-张风捷特烈-1994`");//文字组件
//    var show = Container(
//      color: Color(0x6623ffff),//颜色
//      width: 200,//宽
//      height: 200 * 0.618,//高
//      child: text,); //孩子
///////---------------------------------------------------------------

///////----------------------4.1.1  Text的基本使用-2----------------------
//    var style = TextStyle(color: Colors.red, //颜色
//      backgroundColor: Colors.white, //背景色
//      fontSize: 20, //字号
//      fontWeight: FontWeight.bold, //字粗
//      fontStyle: FontStyle.italic, //斜体
//      letterSpacing: 10,); //字间距
//    var text = Text( "toly-张风捷特烈-1994`", style: style,);//样式
//    var show = Container(
//      color: Color(0x6623ffff),//颜色
//      width: 200,//宽
//      height: 200 * 0.618,//高
//      child: text,); //孩子
///////---------------------------------------------------------------

///////----------------------4.1.1  自定义字体----------------------
//    var style = TextStyle(
//        color: Colors.red, //颜色
//        backgroundColor: Colors.white,//背景色
//        fontFamily:"阿里惠普体"//字体名
//    );
//    var text = Text("toly-张风捷特烈-1994`",style: style,);
//    var show = Container(
//      color: Color(0x6623ffff),//颜色
//      width: 200,//宽
//      height: 200 * 0.618,//高
//      child: text,); //孩子
///////---------------------------------------------------------------

///////----------------------4.1.2  Text的阴影单色----------------------
//    var shadow = Shadow(
//        color: Colors.black, //颜色
//        blurRadius: 1, //虚化
//        offset: Offset(2, 2)//偏移
//    );
//    var style = TextStyle(
//        color: Colors.grey, //颜色
//        fontSize: 80, //字号
//        shadows: [shadow]
//    );
//    var text = Text( "张风捷特烈", style: style,);
//    var show = Container(
//      color: Color(0x6623ffff),//颜色
//      width: 400,//宽
//      height: 200 * 0.618,//高
//      child: text,); //孩子
///////---------------------------------------------------------------

///////----------------------4.1.2  Text的阴影彩色----------------------
////    const rainbow = [0xffff0000, 0xffFF7F00, 0xffFFFF00, 0xff00FF00,//颜色列表
////      0xff00FFFF, 0xff0000FF, 0xff8B00FF];
////    int i=0;
////    var shadows=rainbow.map((e){//遍历rainbow列表，生成Shadow集合
////      var shadow=Shadow(  color: Color(e),
////          blurRadius: i * 2.5,
////          offset: Offset(-(i + 1) * 3.0, -(i + 1) * 3.0));
////      i++;
////      return shadow;}).toList();
////    var style = TextStyle( color: Colors.black, fontSize: 80, shadows:shadows);
////    var text = Text( "张风捷特烈", style: style,);
////    var show = Container(
////      color: Color(0x6623ffff),//颜色
////      width: 400,//宽
////      height: 200 * 0.618,//高
////      child: text,); //孩子
/////////---------------------------------------------------------------

///////----------------------4.1.2  Text的阴影装饰线----------------------
//    var style = TextStyle(
//      color: Colors.black, //颜色
//      fontSize: 20, //字号
//      decoration: TextDecoration.lineThrough,
//      decorationColor: Color(0xffff0000),//装饰线颜色
//      decorationStyle: TextDecorationStyle.wavy,//装饰线样式
//      decorationThickness: 0.8,);//装饰线粗
//     var text = Text(  "张风捷特烈", style: style,);
//    var show = Container(
//      color: Color(0x6623ffff),//颜色
//      width: 400,//宽
//      height: 200 * 0.618,//高
//      child: text,); //孩子
///////---------------------------------------------------------------

///////----------------------4.1.2 文字方向、对齐和溢出处理 ----------------------
    var style = TextStyle(
      color: Colors.black, //颜色
      fontSize: 20, //字号
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xffff0000), //装饰线颜色
      decorationStyle: TextDecorationStyle.wavy, //装饰线样式
      decorationThickness: 0.8,
    ); //装饰线粗
    var text = Text(
      "张风捷4454特烈" * 10,
      style: style,
      maxLines: 2,
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
      overflow: TextOverflow.ellipsis,
    );
    var show = Container(
      color: Color(0x6623ffff), //颜色
      width: 400, //宽
      height: 200 * 0.618, //高
      child: text,
    ); //孩子
///////---------------------------------------------------------------
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(child: show),
      ),
    );
  }
}
