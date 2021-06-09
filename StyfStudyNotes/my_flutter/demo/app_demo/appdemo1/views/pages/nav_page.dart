import 'package:flutter/material.dart';
import '../../app/cons.dart';
import 'act_page.dart';
import 'home_page.dart';
import 'love_page.dart';
import 'me_page.dart';
import 'note_page.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  var _position = 0; //当前激活页
  final _ctrl = PageController(); //页面控制器

  @override
  void dispose() {
    _ctrl.dispose(); //释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        //使用PageView实现五个页面的切换
        controller: _ctrl,
        children: _buildContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //底部栏
        items: _buildBottomItems(), //背景色
        currentIndex: _position, //激活位置
        onTap: _onTapBottomItem,
      ),
    );
  }

  //主体内容页面列表
  List<Widget> _buildContent() => <Widget>[
        HomePage(),
        ActPage(),
        LovePage(),
        NotePage(),
        MePage(),
      ];

  //通过控制器切换PageView页面 并更新索引
  void _onTapBottomItem(position) {
    _ctrl.jumpToPage(position);
    setState(() {
      _position = position;
    });
  }

  // 生成底部导航栏item
  List<BottomNavigationBarItem> _buildBottomItems() =>
      Cons.bottomNavMap.keys
      .map((e) => 
          BottomNavigationBarItem(
          title: Text(e),
          icon: Icon(Cons.bottomNavMap[e]),
          backgroundColor: Colors.blue))
      .toList();
}
