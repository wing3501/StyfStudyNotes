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
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        print("FloatingActionButton click");
      },
      child: Icon(Icons.add),
    );
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
    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          Text("喜欢作者")
        ],
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
    );
  }

//按钮补充
  TextButton buildTextButton1() {
    return TextButton(
      onPressed: () {
        print("TextButton click");
      },
      child: Text("TextButton"),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, //距顶的小高度
          padding: MaterialStateProperty.all(EdgeInsets.zero), //紧缩包裹
          minimumSize: MaterialStateProperty.all(Size(10, 10))),
    );
  }

//自定义按钮

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        print("FloatingActionButton click");
      },
      child: Icon(Icons.add),
    );
  }

  OutlinedButton buildOutlinedButton() {
    return OutlinedButton(
        onPressed: () {
          print("OutlinedButton click");
        },
        child: Text("OutlinedButton"));
  }

  TextButton buildTextButton() {
    return TextButton(
        onPressed: () {
          print("TextButton click");
        },
        child: Text("TextButton"));
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          print("ElevatedButton click");
        },
        child: Text("ElevatedButton"));
  }
}
