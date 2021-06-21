import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_flutter/module/home/model/int_size.dart';
import 'package:my_flutter/module/home/model/pubuliu_offset_view_model.dart';
import 'package:my_flutter/module/home/widget/pubu_item.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PuBuLiuOffsetViewModel>(
            create: (context) => PuBuLiuOffsetViewModel(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(title: Text('首页'), elevation: 0.0),
          body: _buildHomeContent(context),
        ));
  }

  Widget _buildHomeContent(BuildContext context) {
    var tabbar = Consumer<PuBuLiuOffsetViewModel>(
      builder: (ctx, vm, child) {
        double offsetY = vm.offsetY;
        // hyLog("----------$offsetY", StackTrace.current);
        return vm.offsetY >= 300
            ? Container(
                color: Colors.white,
                child: TabBar(
                  tabs: _tabs,
                  controller: _tabController,
                ),
              )
            : Container();
      },
    );

    var pubuTabView = TabBarView(
      controller: _tabController,
      children: [PuBuLiu(), PuBuLiu(), PuBuLiu(), PuBuLiu(), PuBuLiu()],
    );

    var header = Column(
      children: [JinGangQu(), BaoZhangQu()],
    );

    return Stack(
      children: [pubuTabView, tabbar],
    );
  }
}

class PuBuLiu extends StatefulWidget {
  @override
  _PuBuLiuState createState() => _PuBuLiuState();
}

class _PuBuLiuState extends State<PuBuLiu> {
  List<IntSize> _data;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(initialScrollOffset: 0)
      ..addListener(() {
        double offsetY = _scrollController.offset;
        // hyLog("----------$offsetY", StackTrace.current);
      });

    final rd = Random();
    _data = List.generate(
        200, (index) => IntSize(rd.nextInt(100) + 200, rd.nextInt(150) + 200));
  }

  @override
  Widget build(BuildContext context) {
    // Consumer<CounterViewModel>(
    //   builder: (ctx, counterVM, child) {
    //     return FloatingActionButton(
    //       child: child,
    //       onPressed: () {
    //         counterVM.counter++;
    //       },
    //     );
    //   },
    //   child: Icon(Icons.add),
    // )
    return Consumer<PuBuLiuOffsetViewModel>(
      builder: (ctx, vm, child) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            ScrollMetrics metrics = notification.metrics;
            // hyLog("----------${metrics.pixels}", StackTrace.current);

            // vm.offsetY = metrics.pixels;
            vm.updateOffsetY(metrics.pixels);
            return false;
          },
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 300),
            physics: BouncingScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) => PuBuItem(
              index: index,
              size: _data[index],
            ),
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
            itemCount: _data.length,
          ),
        );
      },
    );
  }
}
