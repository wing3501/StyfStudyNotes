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
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('基础widget'),
      ),
      body: HomeContent(),
    ));
  }
}

class HomeContent extends StatefulWidget {
  HomeContent({Key key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return RichTextDemo();
  }
}

class RichTextDemo extends StatelessWidget {
  const RichTextDemo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: "Hello world", style: TextStyle(color: Colors.red)),
      TextSpan(text: "Hello world", style: TextStyle(color: Colors.green)),
      WidgetSpan(
          child: Icon(
        Icons.favorite,
        color: Colors.red,
      )),
      TextSpan(text: "Hello world", style: TextStyle(color: Colors.blue))
    ]));
  }
}

class TextDemo extends StatelessWidget {
  const TextDemo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "近日\n，钟南山、张伯礼呼吁尽快接种新冠疫苗，为预防新冠尽一份力量。目前，我国接种疫苗比例比较低，应尽量争取达到70%-80%的接种率。",
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.2,
      style: TextStyle(
          fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }
}
