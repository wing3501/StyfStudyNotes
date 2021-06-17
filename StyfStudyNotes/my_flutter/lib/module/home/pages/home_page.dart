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
  TabController _tabController;
  int _currentIndex = 0;
  bool _showTabbar = false;

  @override
  void initState() {
    super.initState();

    _tabs = ["全部", "直播", "名家", "优店", "捡漏"]
        .map((e) => Tab(
              text: e,
              icon: Icon(Icons.email),
            ))
        .toList();
    _tabController = TabController(
        length: _tabs.length, vsync: this, initialIndex: _currentIndex);

    _scrollController.addListener(() {
      double offsetY = _scrollController.offset;

      // hyLog("---------$offsetY", StackTrace.current);

      setState(() {
        _showTabbar = offsetY >= 300;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'), elevation: 0.0),
      body: _buildHomeContent(context),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    var nestedScrollView = NestedScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [JinGangQu(), BaoZhangQu()],
                ),
              ),
            ),
            // SliverPersistentHeader(
            //   delegate: MyPersistentHeaderDelegate(
            //       builder: (BuildContext context, double offset) {
            //         return Container(
            //           color: Colors.white,
            //           child: _showTabbar
            //               ? TabBar(
            //                   tabs: _tabs,
            //                   controller: _tabController,
            //                 )
            //               : Container(),
            //         );
            //       },
            //       max: _showTabbar ? 60 : 0,
            //       min: _showTabbar ? 60 : 0),
            //   pinned: true,
            // )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [PuBuAll(), PuBuAll(), PuBuAll(), PuBuAll(), PuBuAll()],
        ));

    var tabbar = _showTabbar
        ? Container(
            color: Colors.white,
            child: TabBar(
              tabs: _tabs,
              controller: _tabController,
            ),
          )
        : Container();

    return Stack(
      children: [nestedScrollView, tabbar],
    );
  }
}
