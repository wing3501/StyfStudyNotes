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

class MyPage extends StatelessWidget {
  MyPage() {
    print("MyPage构造函数");
  }

  @override
  Widget build(BuildContext context) {
    print("MyPage-build");
    return Container();
  }
}

class HomePage extends StatefulWidget {
  HomePage() {
    print("1.HomePage 构造函数");
  }
  @override
  _HomePageState createState() {
    print("2.HomePage-createState");
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var _counter = 0;

  _HomePageState() {
    print("3._HomePageState 构造函数");
  }

  @override
  void initState() {
    print("4._HomePageState initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("5._HomePageState build");
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        ElevatedButton(
            onPressed: () {
              print("点击");
              setState(() {
                _counter++;
              });
            },
            child: Icon(Icons.add)),
        Text("数字:$_counter")
      ],
    );
  }

  @override
  void dispose() {
    print("6._HomePageState build");
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print("?._HomePageState didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    print("?._HomePageState didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }
}
