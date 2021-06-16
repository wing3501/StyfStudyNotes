import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

main(List<String> args) {
  runApp(HomePage());
}

// StatelessWidget 内容是确定的，没有状态(data)的改变
// StatefulWidget 在运行过程中有一些状态(data)需要改变

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContentBodyState();
  }
}

class ContentBodyState extends State<HomePage> {
  var flag = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("这是标题"),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("hello"),
          Text("world"),
          Checkbox(
              value: flag,
              onChanged: (value) {
                setState(() {
                  flag = value;
                  print(flag);
                });
              })
        ],
      )),
    ));
  }
}

// main(List<String> args) {
//   runApp(MaterialApp(
//     home: Center(
//       child: Text(
//         "hello world",
//         style: TextStyle(fontSize: 30, color: Colors.orange),
//       ),
//     ),
//   ));
// }
