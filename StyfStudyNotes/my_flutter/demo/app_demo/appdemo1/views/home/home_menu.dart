import 'package:flutter/material.dart';
import '../../app/cons.dart';
import '../dialogs/dialog_about.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(//创建按钮菜单
      itemBuilder: _buildMenuItem,
      onSelected: (index) => _onSelected(context,index),
    );
  }

  //根据字符串列表映射按钮菜单子项列表
  List<PopupMenuEntry<int>> _buildMenuItem(context) =>
      Cons.menuInfo.map((e) =>
          PopupMenuItem(value: Cons.menuInfo.indexOf(e), child: Text(e)))
      .toList();

  //选中时回调
  void _onSelected(BuildContext context,int index) {
    print(index);
    switch (index) {
      case 0:
        showDialog(context: context, builder: (context) => DialogAbout());
        break;
    }
  }
}
