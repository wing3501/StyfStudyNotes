import 'package:flutter/material.dart';

import 'package:my_flutter/module/my/widget/my_presistent_header_delegate.dart';
import 'package:my_flutter/utils/event_bus_utils.dart';
import 'package:my_flutter/utils/log_utils.dart';
import '../../../utils/fancy_icon_provider.dart';
import '../widget/pubu_all.dart';
import '../widget/jingang_qu.dart';
import '../widget/baozhang_qu.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  List<Tab> _tabs = [];
  TabController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabs = ["全部", "直播", "名家", "优店", "捡漏"]
        .map((e) => Tab(
              text: e,
              icon: Icon(Icons.email),
            ))
        .toList();
    _controller = TabController(
        length: _tabs.length, vsync: this, initialIndex: currentIndex);

    _scrollController.addListener(() {
      double offsetY = _scrollController.offset;
      if (offsetY >= 450) {
      } else {}

      // hyLog("offsetY:$offsetY", StackTrace.current);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'), elevation: 0.0),
      body: _buildHomeContent(context),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return NestedScrollView(
        // physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: JinGangQu(),
            ),
            SliverToBoxAdapter(
              child: BaoZhangQu(),
            ),
            SliverPersistentHeader(
              delegate: MyPersistentHeaderDelegate(
                  builder: (BuildContext context, double offset) {
                    return Container(
                      color: Colors.white,
                      child: TabBar(
                        tabs: _tabs,
                        controller: _controller,
                      ),
                    );
                  },
                  max: 60,
                  min: 60),
              pinned: true,
            )
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: [PuBuAll(), PuBuAll(), PuBuAll(), PuBuAll(), PuBuAll()],
        ));
  }
}
