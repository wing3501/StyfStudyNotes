import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_navigator.dart';
import 'package:flutter_boost/flutter_boost.dart';

class CallNativePage extends StatefulWidget {
  static const String routeName = "/callnative";
  final String uniqueId;
  const CallNativePage(this.uniqueId);

  @override
  _CallNativePageState createState() => _CallNativePageState();
}

class _CallNativePageState extends State<CallNativePage>
    with PageVisibilityObserver {
  static const String _kTag = 'CallNativePage';
  @override
  void didChangeDependencies() {
    PageVisibilityBinding.instance.addObserver(this, ModalRoute.of(context));
    print('$_kTag#didChangeDependencies, ${widget.uniqueId}, $this');
    super.didChangeDependencies();
  }

  @override
  void initState() {
    print('$_kTag#initState, ${widget.uniqueId}, $this');
    super.initState();
  }

  @override
  void dispose() {
    PageVisibilityBinding.instance.removeObserver(this);
    print('$_kTag#dispose, ${widget.uniqueId}, $this');
    super.dispose();
  }

  @override
  void onPageCreate() {
    print('$_kTag#onPageCreate, ${widget.uniqueId}, $this');
  }

  @override
  void onPageDestroy() {
    print('$_kTag#onPageDestroy, ${widget.uniqueId}, $this');
  }

  @override
  void onPageShow() {
    print('$_kTag#onPageShow, ${widget.uniqueId}, $this');
  }

  @override
  void onPageHide() {
    print('$_kTag#onPageHide, ${widget.uniqueId}, $this');
  }

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
