import 'package:flutter/material.dart';
import 'package:my_flutter/module/home/widget/pubu_all.dart';
import 'package:my_flutter/utils/log_utils.dart';

class PuBuQu extends StatefulWidget {
  @override
  _PuBuQuState createState() => _PuBuQuState();
}

class _PuBuQuState extends State<PuBuQu> {
  int _index = 0;
  final _pageController = PageController(initialPage: 0);
  final List<Widget> pubuPages = [
    PuBuAll(),
    PuBuAll(),
    PuBuAll(),
    PuBuAll(),
    PuBuAll()
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      hyLog(
          "_pageController index:${_pageController.page}", StackTrace.current);
      _index = _pageController.page.toInt();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 667,
      child: PageView(
        controller: _pageController,
        children: pubuPages,
      ),
    );
  }
}
