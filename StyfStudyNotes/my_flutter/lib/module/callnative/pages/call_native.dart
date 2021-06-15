import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_navigator.dart';

class CallNativePage extends StatelessWidget {
  static const String routeName = "/callnative";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("原生互跳"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // 关闭页面
          // BoostNavigator.instance.pop('I am result for popping.');
          // 打开一个原生页面
          // String result = await BoostNavigator.instance.push("flutterPage", withContainer: true);
          // BoostNavigator.instance.push("_TtC14StyfStudyNotes9SwiftDemo", withContainer: true);
          //打开一个flutter页面
          BoostNavigator.instance.push("/home", withContainer: true);
        },
      ),
    );
  }
}
