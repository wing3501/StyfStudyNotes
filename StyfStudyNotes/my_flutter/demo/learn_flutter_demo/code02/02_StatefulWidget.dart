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

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  var _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getButtons(),
          Text(
            "当前计数：$_counter",
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }

  Widget _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Text(
            "+",
            style: TextStyle(fontSize: 30),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink)),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter--;
            });
          },
          child: Text(
            "-",
            style: TextStyle(fontSize: 30),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
        )
      ],
    );
  }
}
