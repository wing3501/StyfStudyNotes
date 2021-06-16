import 'package:flutter/material.dart';

class MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double max;
  final double min;
  final Widget Function(BuildContext context, double offset) builder;

  MyPersistentHeaderDelegate(
      {this.max = 120, this.min = 80, @required this.builder})
      : assert(max >= min && builder != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset);
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant MyPersistentHeaderDelegate oldDelegate) {
    bool flag = max != oldDelegate.max ||
        min != oldDelegate.min ||
        builder != oldDelegate.builder;
    print("-------$flag");
    return flag;
  }
}
