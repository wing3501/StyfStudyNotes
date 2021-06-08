import 'package:flutter/material.dart';
import 'package:my_flutter/utils/color_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: GridViewCustom(),
        ),
      ),
    );
  }
}

//----------GridView.custom生成

class GridViewCustom extends StatefulWidget {
  @override
  _GridViewGridViewExtentState3 createState() =>
      _GridViewGridViewExtentState3();
}

class _GridViewGridViewExtentState3 extends State<GridViewCustom> {
  List<int> data;

  @override
  void initState() {
    data = List.generate(50, (i) => i); //生成50个数字
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //网格代理
        crossAxisCount: 2, //条目个数
        mainAxisSpacing: 10, //主轴间距
        crossAxisSpacing: 10, //交叉轴间距
        childAspectRatio: 1 / 0.618,
      ), //交叉轴方向item尺寸/主轴方向item尺寸
      childrenDelegate: SliverChildBuilderDelegate(
          (_, position) => Container(
                alignment: Alignment.center,
                color: ColorUtils.randomColor(),
                child: Text("$position"),
              ),
          childCount: data.length),
    );
  }
}

//----------GridView.builder生成

class GridViewBuilder extends StatefulWidget {
  @override
  _GridViewGridViewExtentState2 createState() =>
      _GridViewGridViewExtentState2();
}

class _GridViewGridViewExtentState2 extends State<GridViewBuilder> {
  List<int> data;

  @override
  void initState() {
    data = List.generate(50, (i) => i); //生成50个数字
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var builder = GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //网格代理：定交叉轴数目
        crossAxisCount: 2, //条目个数
        mainAxisSpacing: 10, //主轴间距
        crossAxisSpacing: 10, //交叉轴间距
        childAspectRatio: 1 / 0.618, //交叉轴方向item尺寸/主轴方向item尺寸
      ),
      itemBuilder: (_, int position) => Container(
          alignment: Alignment.center,
          color: ColorUtils.randomColor(limitA: 255),
          child: Text("$position")),
      padding: EdgeInsets.all(10),
      scrollDirection: Axis.vertical, //滑动方向
    );
    return builder;
  }
}

//----------按个数分布

class GridViewCount extends StatefulWidget {
  @override
  _GridViewGridViewExtentState1 createState() =>
      _GridViewGridViewExtentState1();
}

class _GridViewGridViewExtentState1 extends State<GridViewCount> {
  List<int> data;

  @override
  void initState() {
    data = List.generate(50, (i) => i); //生成50个数字
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var count = GridView.count(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical, //滑动方向
        mainAxisSpacing: 10, //主轴间距
        crossAxisSpacing: 10, //交叉轴间距
        crossAxisCount: 8, //条目个数 <----  指定交叉轴一行个数
        childAspectRatio: 1 / 0.618, //交叉轴方向item尺寸/主轴方向item尺寸
        children: data
            .map((e) => Container(
                  alignment: Alignment.center,
                  color: ColorUtils.randomColor(),
                  child: Text("$e"),
                ))
            .toList());
    return count;
  }
}

//----------按宽度分布

class GridViewExtent extends StatefulWidget {
  @override
  _GridViewGridViewExtentState createState() => _GridViewGridViewExtentState();
}

class _GridViewGridViewExtentState extends State<GridViewExtent> {
  List<int> data;

  @override
  void initState() {
    data = List.generate(50, (i) => i); //生成50个数字
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var extend = GridView.extent(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical, //滑动方向
        mainAxisSpacing: 10, //主轴间距
        crossAxisSpacing: 10, //交叉轴间距
        maxCrossAxisExtent: 150.0, //<----最大延伸值
        childAspectRatio: 1 / 0.618, //交叉轴方向item尺寸/主轴方向item尺寸
        children: data
            .map((e) => Container(
                  alignment: Alignment.center,
                  color: ColorUtils.randomColor(),
                  child: Text("$e"),
                ))
            .toList());
    return extend;
  }
}
