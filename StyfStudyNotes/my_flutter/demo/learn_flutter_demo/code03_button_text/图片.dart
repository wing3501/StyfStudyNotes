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
    //1.创建文件夹存储图片
    //2.pubspec.yaml配置 flutter packages get
    //3.使用图片

    return Image(image: AssetImage("assets/images/3.0x/1.jpeg"));

    // return Image.network(
    // "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1332800745,3820435792&fm=26&gp=0.jpg");
  }

//占位图问题
  FadeInImage buildFadeInImage() {
    return FadeInImage(
      placeholder: AssetImage("assets/images/3.0x/1.jpeg"),
      image: NetworkImage(
          "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1332800745,3820435792&fm=26&gp=0.jpg"),
      fadeOutDuration: Duration(seconds: 2),
      fadeInDuration: Duration(seconds: 2),
    );
  }

  Image buildImage() {
    return Image(
      image: NetworkImage(
          "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1332800745,3820435792&fm=26&gp=0.jpg"),
      width: 200,
      height: 200,
      fit: BoxFit.contain,
      // alignment: Alignment.topCenter,
      alignment: Alignment(0, 0),
      color: Colors.green,
      colorBlendMode: BlendMode.colorDodge, //混入模式
      repeat: ImageRepeat.repeatY,
    );
  }
}
