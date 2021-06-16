import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_flutter/module/home/model/int_size.dart';

import 'pubu_item.dart';

class PuBuAll extends StatefulWidget {
  @override
  _PuBuAllState createState() => _PuBuAllState();
}

class _PuBuAllState extends State<PuBuAll> {
  List<IntSize> _data;

  @override
  void initState() {
    super.initState();
    final rd = Random();
    _data = List.generate(
        200, (index) => IntSize(rd.nextInt(100) + 200, rd.nextInt(150) + 200));
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) => PuBuItem(
        index: index,
        size: _data[index],
      ),
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
    );
  }
}
