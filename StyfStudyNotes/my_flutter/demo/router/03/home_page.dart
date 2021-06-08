import 'package:flutter/material.dart';

import '../goods_widget.dart';
import 'goods_detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goods = GoodsWidget(
        onTap: (goods) => _toDetailPagerCloseMe(context, goods), //跳转到详情界面
        width: 200,
        goods: GoodBean(
            price: 21.89,
            saleCount: 99,
            title: "得力笔记本文具商务复古25K/A5记事本PU软皮面日记本子定制可印logo简约工作笔记本会议记录本小清新大学生用",
            image: AssetImage("assets/images/note_cover.jpg")));
    return goods;
  }

  //通过名字打开详情页并关闭自己
  _toDetailPagerCloseMe(BuildContext context, GoodBean goods) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GoodsDetailPager(
                goods: goods,
              )),
    );
  }
}
