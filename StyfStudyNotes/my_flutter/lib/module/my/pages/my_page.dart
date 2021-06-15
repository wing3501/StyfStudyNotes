import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/module/my/widget/my_presistent_header_delegate.dart';

enum MyDragState { DragStateIdle, DragStateBegin, DragStateEnd }

class MyPage extends StatefulWidget {
  static const String routeName = "/my";
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final List<Color> data = List.generate(24, (i) => Color(0xFFFF00FF - 24 * i));
  double startOffsetY;
  double defaultHeight = 250;
  double maxHeight = 350;
  double offsetY = 0;
  double distance;
  MyDragState dragState = MyDragState.DragStateIdle;
  ScrollController controller;

  @override
  void initState() {
    super.initState();

    distance = maxHeight - defaultHeight;
    controller = ScrollController(initialScrollOffset: distance);
    controller.addListener(() {
      offsetY = controller.offset;

      if (offsetY <= 0) {
        controller.jumpTo(0);
        _resetWithAnimation(true);
      }
    });
  }

  _resetWithAnimation(bool delay) {
    Function block = () {
      print(controller.offset);
      if (controller.offset < distance && dragState == MyDragState.DragStateEnd)
        dragState = MyDragState.DragStateIdle;
      controller.animateTo(distance,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    };

    if (!delay) {
      block();
      return;
    }
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      block();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMyPageContent(context),
    );
  }

  Widget _buildMyPageContent(BuildContext context) {
    return Listener(
        onPointerDown: (e) {
          dragState = MyDragState.DragStateBegin;
        },
        onPointerUp: (e) {
          dragState = MyDragState.DragStateEnd;
          _resetWithAnimation(false);
        },
        child: CustomScrollView(
          controller: controller,
          slivers: [_buildBigImageHeader(context), _buildSliverList()],
        ));
  }

  Widget _buildBigImageHeader(BuildContext context) {
    // return SliverPersistentHeader(
    //     delegate: MyPersistentHeaderDelegate(
    //         min: defaultHeight,
    //         max: maxHeight,
    //         child: _buildImageWidget()));

    return SliverPersistentHeader(
      delegate: MyPersistentHeaderDelegate(
          max: maxHeight,
          min: defaultHeight,
          builder: (ctx, offset) =>
              SizedBox.expand(child: _buildImageWidget())),
    );
  }

  Widget _buildImageWidget() {
    return Container(
      color: Colors.greenAccent,
      child: Image.network(
        'https://pic4.zhimg.com/80/v2-b02e601349241df0e3f25fd1ec622155_1440w.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPresistentHeader() {
    return SliverPersistentHeader(
      delegate: MyPersistentHeaderDelegate(
        builder: (ctx, offset) => Container(
            alignment: Alignment.center,
            color: Colors.orangeAccent,
            child: Text(
              "shrinkOffset:${offset.toStringAsFixed(1)}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
      ),
      pinned: true,
      floating: false,
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((ctx, index) {
        return _buildColorItem(data[index]);
      }, childCount: data.length),
    );
  }

  Widget _buildColorItem(Color color) {
    return Card(
        child: Container(
      alignment: Alignment.center,
      // width: 200,
      height: 60,
      color: color,
      child: Text(
        colorString(color),
        style: const TextStyle(color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ]),
      ),
    ));
  }

  // 颜色转换为文字
  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
