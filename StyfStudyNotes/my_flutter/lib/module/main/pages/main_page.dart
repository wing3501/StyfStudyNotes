import 'package:flutter/material.dart';
import 'package:my_flutter/module/category/pages/category.dart';
import 'package:my_flutter/module/home/pages/home_page.dart';
import 'package:my_flutter/module/message/pages/message_page.dart';
import 'package:my_flutter/module/my/pages/my_page.dart';
import 'package:my_flutter/utils/fancy_icon_provider.dart';

class MainPage extends StatefulWidget {
  static const String routeName = "/";
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final a = FancyIcon("ic_bottombar_shouye_n");
    print(a);
    return Scaffold(
      body: IndexedStack(
        children: pages,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selectedLabelStyle: TextStyle(fontSize: 11, color: Color(0xFFd81e06)),
        // unselectedLabelStyle: TextStyle(fontSize: 11, color: Color(0xFF333333)),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedItemColor: Color(0xFFd81e06), //解决selectedLabelStyle设置文字颜色无效
        unselectedItemColor: Color(0xFF333333),
        type: BottomNavigationBarType.fixed, //item不显示问题
        items: items,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<Widget> pages = [HomePage(), CategoryPage(), MessagePage(), MyPage()];
  List<BottomNavigationBarItem> items = [
    YFBottomNavigationBarItem(
        "首页", "ic_bottombar_shouye_n", "ic_bottombar_shouye_p"),
    YFBottomNavigationBarItem(
        "分类", "ic_bottombar_fenlei_n", "ic_bottombar_fenlei_p"),
    YFBottomNavigationBarItem(
        "消息", "ic_bottombar_xiaoxi_n", "ic_bottombar_xiaoxi_p"),
    YFBottomNavigationBarItem("我的", "ic_bottombar_wo_n", "ic_bottombar_wo_p"),
  ];
}

class YFBottomNavigationBarItem extends BottomNavigationBarItem {
  YFBottomNavigationBarItem(String title, String icon, String activeIcon)
      : super(
            label: title,
            icon: Icon(FancyIcon(icon), color: Color(0xFF333333)),
            activeIcon: Icon(
              FancyIcon(activeIcon),
              color: Color(0xFFd81e06),
            ));
}
