import 'package:flutter/material.dart';

import '../home/home_drawer.dart';
import 'initialize_items.dart';

class YFMainSceen extends StatefulWidget {
  static const String routeName = "/";
  @override
  _YFMainSceenState createState() => _YFMainSceenState();
}

class _YFMainSceenState extends State<YFMainSceen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: YFHomeDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        items: items,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
