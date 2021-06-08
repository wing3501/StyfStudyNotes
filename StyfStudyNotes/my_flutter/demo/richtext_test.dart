import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
///////----------------------4.1.4  RichText的使用----------------------
//    var span=TextSpan(
//      text: 'Hello',
//      style: TextStyle(color: Colors.black),
//      children: <TextSpan>[//可以盛放多个TextSpan
//        TextSpan(text: ' beautiful ',
//            style: TextStyle(fontStyle: FontStyle.italic)),
//        TextSpan(text: 'world',
//            style: TextStyle(fontWeight: FontWeight.bold)), ],);
//    var show =RichText(text: span);
///////---------------------------------------------------------------

///////----------------------4.1.4  彩虹字----------------------
//    const rainbowMap = {
//      0xffff0000:"红色", 0xffFF7F00:"橙色",
//      0xffFFFF00:"黄色", 0xff00FF00:"绿色",
//      0xff00FFFF:"青色", 0xff0000FF:"蓝色",
//      0xff8B00FF:"紫色",};
//    var span= rainbowMap.keys.map((e)=>//遍历，生成TextSpan列表
//    TextSpan(  text: "${rainbowMap[e]}     ",
//        style: TextStyle(fontSize: 20.0, color: Color(e)))).toList();
//    var show = RichText(
//      text: TextSpan( text: '七彩字：\n', children: span,
//          style: TextStyle(fontSize: 16.0, color: Colors.black),));
///////---------------------------------------------------------------

///////----------------------4.1.4  彩虹字加强----------------------
//    colorfulText(String str,{double fontSize=14}) => //返回对象时可简写
//    RichText(text:TextSpan(
//        children: str.split("").map((str)=>//对文字数组化，并通过map遍历生成TextSpan数组
//        TextSpan(text: str, style:
//        TextStyle(fontSize: fontSize, color: ColorUtils.randomColor())
//        )).toList()));
//    var cc="燕子去了，有再来的时候；杨柳枯了，有再青的时候；桃花谢了，有再开的时候。"
//        "但是，聪明的，你告诉我，我们的日子为什么一去不复返呢？——是有人偷了他 们罢...";
//    var show = colorfulText(cc);
///////---------------------------------------------------------------

///////----------------------4.1.2  RichText/Text.rich----------------------
    var span = TextSpan(
      text: 'hello ',
      style: TextStyle(color: Colors.black, fontSize: 18),
      children: <InlineSpan>[
        WidgetSpan(
            //使用WidgetSpan添加一个组件
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.ideographic,
            child: Icon(
              Icons.face,
              color: Colors.amber,
            )),
        TextSpan(
          text: ' , welcome to ',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
        WidgetSpan(
            child: FlutterLogo(),
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.ideographic),
        TextSpan(
          text: ' .',
        ),
      ],
    );
    var show = RichText(text: span);
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
