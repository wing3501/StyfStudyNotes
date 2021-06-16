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
    return Text(
      "\ue91d",
      style: TextStyle(fontFamily: "MaterialIcons", fontSize: 100),
    );

    // return Icon(
    //   IconData(0xe91d, fontFamily: 'MaterialIcons'),
    //   size: 300,
    //   color: Colors.red,
    // );

    // return Icon(
    //   Icons.pets,
    //   size: 300,
    //   color: Colors.orange,
    // );
  }
}
