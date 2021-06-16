import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  static const String routeName = "/my";
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  double extraPicHeight = 0; //初始化要加载到图片上的高度

  double prev_dy; //前一次手指所在处的y值
  //加在这里
  AnimationController animationController;
  Animation<double> anim;
  @override
  void initState() {
    super.initState();

    prev_dy = 0;

    //加在这里
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Listener(
      onPointerMove: (result) {
        //手指的移动时
        updatePicHeight(result.position.dy); //自定义方法，图片的放大由它完成。
      },
      onPointerUp: (_) {
        //当手指抬起离开屏幕时
        runAnimate(); //动画执行
        animationController.forward(from: 0); //重置动画
      },
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              //标题左侧的控件（一般是返回上一个页面的箭头）
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            floating: false,
            pinned: true,
            snap: false,
            //pinned代表是否会在顶部保留AppBar
            //floating代表是否会发生下拉立即出现SliverAppBar
            //snap必须与floating:true联合使用，表示显示SliverAppBar之后，如果没有完全拉伸，是否会完全神展开
            expandedHeight:
                236 + extraPicHeight, //顶部控件所占的高度,跟随因手指滑动所产生的位置变化而变化。
            flexibleSpace: FlexibleSpaceBar(
                title: null, //标题
                background: //背景图片所在的位置
                    SliverTopBar(
                  extraPicHeight: extraPicHeight,
                  fitType: BoxFit.cover,
                ) //自定义Widget
                ),
          ),
          SliverList(//列表
              delegate: SliverChildBuilderDelegate(
            (context, i) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "This is item $i",
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.white70,
              );
            },
          ))
        ],
      ),
    ));
  }

  runAnimate() {
    //设置动画让extraPicHeight的值从当前的值渐渐回到 0
    setState(() {
      anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
        ..addListener(() {
          setState(() {
            extraPicHeight = anim.value;
          });
        });
      prev_dy = 0; //同样归零
    });
  }

  updatePicHeight(changed) {
    if (prev_dy == 0) {
      //如果是手指第一次点下时，我们不希望图片大小就直接发生变化，所以进行一个判定。
      prev_dy = changed;
    }
    // if (extraPicHeight >= 45) {
    //   //当我们加载到图片上的高度大于某个值的时候，改变图片的填充方式，让它由以宽度填充变为以高度填充，从而实现了图片视角上的放大。
    //   fitType = BoxFit.fitHeight;
    // } else {
    //   fitType = BoxFit.fitWidth;
    // }
    extraPicHeight += changed - prev_dy; //新的一个y值减去前一次的y值然后累加，作为加载到图片上的高度。
    setState(() {
      //更新数据
      prev_dy = changed;
      extraPicHeight = extraPicHeight;
      // fitType = fitType;
    });
  }
}

class SliverTopBar extends StatelessWidget {
  const SliverTopBar(
      {Key key, @required this.extraPicHeight, @required this.fitType})
      : super(key: key);
  final double extraPicHeight; //传入的加载到图片上的高度
  final BoxFit fitType; //传入的填充方式

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              //缩放的图片
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                  "https://pic4.zhimg.com/80/v2-b02e601349241df0e3f25fd1ec622155_1440w.jpg",
                  height: 180 + extraPicHeight,
                  fit: fitType),
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 10),
                    child: Text("QQ：54063222"),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 8),
                    child: Text("男：四川 成都"),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: 30,
          top: 130 + extraPicHeight,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.green,
          ),
        )
      ],
    );
  }
}
