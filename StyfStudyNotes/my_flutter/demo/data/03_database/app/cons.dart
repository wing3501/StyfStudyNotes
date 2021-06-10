import 'package:flutter/material.dart';

import 'todo_icon.dart';

class Cons {
  static const MENU_INFO = <String>["关于", "帮助", "问题反馈"];

  static const CHOSE_COLORS = <Color>[
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.black,
    Colors.cyanAccent,
    Color(0xffd1d08f),
  ];

  static const icon_map = {
    0: TodoIcon.daima, //代码图标
    1: TodoIcon.bug, //bug图标
    2: TodoIcon.iconset0123, //笔记图标
    3: TodoIcon.chifan2600, //吃饭图标
    4: TodoIcon.yduigouwuchexuanzhong, //购物车图标
    5: TodoIcon.shengri, //生日图标
    6: TodoIcon.cycleqiche, //骑车图标
    7: TodoIcon.gongjiao, //公交图标
    8: TodoIcon.shuijue, //睡觉图标
    9: TodoIcon.yuehui, //约会图标
    10: TodoIcon.icon_, //用户图标
    11: TodoIcon.paobu, //跑步图标
    12: TodoIcon.xuexi, //学习图标
    13: TodoIcon.yiyuanguanli, //医院图标
    14: TodoIcon.game, //游戏图标
    15: TodoIcon.music, //音乐图标
  };
}
