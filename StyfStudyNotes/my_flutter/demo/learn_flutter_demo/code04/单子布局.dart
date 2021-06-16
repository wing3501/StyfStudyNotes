import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("基础Widget"),
      ),
      body: AlignDemo(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => print("FloatingActionButton Click"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class HYHomeContent extends StatefulWidget {
  @override
  _HYHomeContentState createState() => _HYHomeContentState();
}

class _HYHomeContentState extends State<HYHomeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.red,
      width: 200,
      height: 200,
      alignment: Alignment(0, 0),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Text("Hello World"),
//      transform: Matrix4.rotationZ(50),
      decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(width: 5, color: Colors.purple),
//        borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Colors.orange,
                offset: Offset(10, 10),
                spreadRadius: 5,
                blurRadius: 10),
            BoxShadow(
                color: Colors.blue,
                offset: Offset(-10, 10),
                spreadRadius: 5,
                blurRadius: 10),
          ]),
    );
  }
}

class PaddingDemo extends StatelessWidget {
  const PaddingDemo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        "你好啊,李银河",
        style: TextStyle(fontSize: 30, backgroundColor: Colors.red),
      ),
    );
  }
}

class AlignDemo extends StatelessWidget {
  const AlignDemo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(1, 1),
        widthFactor: 5,
        heightFactor: 5,
        child: Icon(Icons.pets, size: 50));
  }
}
