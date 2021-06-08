import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/cons.dart';
import '../views/dialogs/cupertino_dialog_about.dart';

class IOSPage extends StatefulWidget {
  @override
  _IOSPageState createState() => _IOSPageState();
}

class _IOSPageState extends State<IOSPage> {
  var _position = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: _buildTopBar(context),
        child: CupertinoTabScaffold(
            tabBar: _buildBottomNav(), tabBuilder: _buildContent));
  }

  //底部导航栏
  CupertinoTabBar _buildBottomNav() => CupertinoTabBar(
        onTap: _onTapBottomItem,
        currentIndex: _position,
        //激活位置
        items: buildBottomItem(),
        activeColor: Colors.blue,
        inactiveColor: Color(0xff333333),
        backgroundColor: Color(0xfff1f1f1),
        iconSize: 25.0,
      );

  //底部导航栏
  List<BottomNavigationBarItem> buildBottomItem() => Cons.bottomNavMap.keys
      .map((e) => BottomNavigationBarItem(
            icon: Icon(
              Cons.bottomNavMap[e],
            ),
            title: Text(e),
          ))
      .toList();

  //底部栏点击回调
  void _onTapBottomItem(index) {
    setState(() => _position = index);
  }

  //顶部导航栏
  CupertinoNavigationBar _buildTopBar(BuildContext context) =>
      CupertinoNavigationBar(
        leading: Image.asset('assets/images/icon_head.png', width: 30), //左
        middle: Text('Flutter Unit'), //中
        trailing: GestureDetector(
            onTap: () => _showDialogAbout(context),
            child: Icon(CupertinoIcons.info, size: 25)),
        backgroundColor: Color(0xfff1f1f1),
      );

  _showDialogAbout(BuildContext context) {
    showDialog(context: context, builder: (context) => CupertinoDialogAbout());
  }

  //弹出底部弹框
  void _showSheetAction(BuildContext context) {
    var title = 'Please chose a language';
    var msg = 'the language you use in this application.';
    showCupertinoModalPopup<int>(
        context: context,
        builder: (cxt) => CupertinoActionSheet(
              title: Text(title),
              message: Text(msg),
              cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(cxt), child: Text('Cancel')),
              actions: <Widget>[
                CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(cxt), child: Text('Dart')),
                CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(cxt), child: Text('Java')),
                CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(cxt), child: Text('Kotlin')),
              ],
            ));
  }

  void _pop(BuildContext context) {
    Navigator.pop(context);
  }

  //构建主体内容页
  Widget _buildContent(BuildContext context, int index) => CupertinoTabView(
        builder: (context) {
          //根据索引构建页面
          switch (index) {
            case 0:
              return _buildSelectBtn(context);
            default:
              return _buildText(index);
          }
        },
      );

  Widget _buildText(int index) {
    var infos = Cons.bottomNavMap.keys.toList();
    return Material(
      child: Align(alignment: Alignment(0, -0.8), child: Text(infos[index])),
    );
  }

  Widget _buildSelectBtn(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.8),
      child: CupertinoButton(
          child: Text('Chose the language'),
          onPressed: () => _showSheetAction(context)),
    );
  }
}
