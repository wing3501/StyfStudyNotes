import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/utils/color_utils.dart';

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
        body: Center(child: CacheImageDemo()),
      ),
    );
  }
}

class ImageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = Image.asset(
      "images/icon_head.png",
      width: 50,
      height: 50,
    );

    var imgPath = "/data/data/com.toly1994.flutter_journey/cache/caver.jpeg";
    var fileImage = Image.file(
      File(imgPath),
      width: 200,
    );

    var imgUrl =
        "https://user-gold-cdn.xitu.io/2019/7/24/16c225e78234ec26?imageView2/1/w/1304/h/734/q/85/format/webp/interlace/1";
    var netImage = Image.network(
      imgUrl,
      width: 200,
    );

    var bytes = File(imgPath).readAsBytesSync();
    var memoryImage = Image.memory(
      bytes,
      width: 200,
    );

    return Wrap(
      direction: Axis.vertical,
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[assetsImage, fileImage, netImage, memoryImage],
    );
  }
}

class FitDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var imgLi = BoxFit.values
        .toList()
        .map((mode) => //批量生成组件
            Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  width: 150,
                  height: 60,
                  color: ColorUtils.randomColor(),
                  child: Image(
                    image: AssetImage("images/wy_30x20.jpg"),
//                    image: AssetImage("images/wy_300x200.jpg"),
                    fit: mode,
                  )),
              Text(mode.toString().split(".")[1])
            ]))
        .toList(); //文字介绍

    return Wrap(
      children: imgLi,
    );
  }
}

class ColorBlendModeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var imgLi = BlendMode.values
        .toList()
        .map((mode) => //批量生成组件
            Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  width: 60,
                  height: 60,
                  child: Image(
                    image: AssetImage("images/icon_head.png"),
                    color: Colors.blue,
                    colorBlendMode: mode,
                  )),
              Text(mode.toString().split(".")[1])
            ]))
        .toList(); //文字介绍

    return Wrap(
      children: imgLi,
    );
  }
}

class AlignmentDemo extends StatefulWidget {
  @override
  _AlignmentDemoState createState() => _AlignmentDemoState();
}

class _AlignmentDemoState extends State<AlignmentDemo> {
  bool _little = true;

  @override
  Widget build(BuildContext context) {
    var alignment = [
      Alignment.center,
      Alignment.centerLeft,
      Alignment.centerRight,
      Alignment.topCenter,
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomCenter,
      Alignment.bottomLeft,
      Alignment.bottomRight,
      Alignment(0.01, 0.01),
      Alignment(0.5, 0.5)
    ]; //测试数组

    var imgLi = alignment
        .map((alignment) => //生成子Widget列表
            Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  width: 150,
                  height: 60,
                  color: ColorUtils.randomColor(),
                  child: Image(
                    image: AssetImage(_little
                        ? "images/wy_30x20.jpg"
                        : "images/wy_300x200.jpg"),
                    alignment: alignment,
                  )),
              Text(alignment.toString())
            ]))
        .toList();

    return Wrap(
      children: [
        ...imgLi,
        Switch(
            value: _little,
            onChanged: (b) {
              setState(() {
                _little = b;
              });
            })
      ],
    );
  }
}

class ImageRepeatDemo extends StatefulWidget {
  @override
  _ImageRepeatDemoState createState() => _ImageRepeatDemoState();
}

class _ImageRepeatDemoState extends State<ImageRepeatDemo> {
  @override
  Widget build(BuildContext context) {
    var imgLi = ImageRepeat.values
        .map((repeat) => Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  width: 150,
                  height: 60,
                  color: ColorUtils.randomColor(),
                  child: Image(
                    image: AssetImage("images/wy_30x20.jpg"),
                    repeat: repeat,
                  )),
              Text(repeat.toString())
            ]))
        .toList();

    return Wrap(children: imgLi);
  }
}

class CenterSliceDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var img = Image.asset(
      "images/right_chat.png",
      centerSlice: Rect.fromLTRB(9, 27, 60, 27 + 1.0),
      fit: BoxFit.fill,
    ); //可缩放区域
    var show = Container(
      width: 300,
      height: 100,
      child: img,
    );

    return show;
  }
}

class CacheImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var imgUrl =
        "https://user-gold-cdn.xitu.io/2019/7/24/16c225e78234ec26?imageView2/1/w/1304/h/734/q/85/format/webp/interlace/1";
    var provider = CachedNetworkImage(
      imageUrl: imgUrl,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );

    return provider;
  }
}
