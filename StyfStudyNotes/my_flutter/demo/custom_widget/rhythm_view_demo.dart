import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// 波纹线RhythmView  绘图、渐变、动画

void main() => runApp(App());

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _maxA = 59.0;

  @override
  Widget build(BuildContext context) {
    var show = RhythmView(
        config: RhythmConfig(maxA: _maxA),
        onChange: () =>
            setState(() => _maxA = 60 * Random().nextDouble() + 30));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('主页'),
          ),
          body: Center(child: show),
        ));
  }
}

class RhythmConfig {
  final double width; //宽
  final double height; //高
  final int duration; //动画时长
  final double lineWidth; //线粗
  final double maxA; //最大振幅

  const RhythmConfig(
      {this.width = 400,
      this.height = 200,
      this.duration = 1000,
      this.lineWidth = 3,
      this.maxA = 200});
}

class RhythmView extends StatefulWidget {
  RhythmView({Key key, this.onChange, this.config = const RhythmConfig()})
      : super(key: key);
  final RhythmConfig config;
  final VoidCallback onChange;

  @override
  _RhythmViewState createState() => _RhythmViewState();
}

class _RhythmViewState extends State<RhythmView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller; //动画控制器
  Animation<double> animation; //动画
  double fie = 0; //初相
  double A = 0; //振幅
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        //创建 Animation对象
        duration: Duration(milliseconds: widget.config.duration),
        vsync: this);
    animation = Tween(begin: 0.0, end: rad(360)).animate(_controller)
      ..addListener(() => setState(() {
            fie = animation.value;
            A = widget.config.maxA * (1 - animation.value / (2 * pi));
          }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: widget.config.width,
          height: widget.config.height,
          child: CustomPaint(
            painter: RhythmPainter(fie, A, widget.config),
          )),
      onTap: () {
        _controller.reset();
        _controller.forward();
        widget ?? widget.onChange();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RhythmPainter extends CustomPainter {
  double min; //最小x
  double max; //最大x
  double fie; //初相
  double A; //振幅
  double omg; //角频率
  Paint mPaint; //主画笔
  Path mPath; //主路径
  Path mReflexPath; //镜像路径
  RhythmConfig config; //镜像路径
  RhythmPainter(this.fie, this.A, this.config) {
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    var shader = ui.Gradient.linear(
        //渐变着色器
        Offset(-config.width / 2, 0),
        Offset(config.width / 2, 0),
        colors,
        pos,
        TileMode.repeated);
    //初始化主画笔
    mPaint = Paint()
      ..isAntiAlias = true
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.lineWidth;
    mPaint.shader = shader; //设置填色器
    mPath = Path(); //初始化主路径
    mReflexPath = Path();
    max = config.width / 2;
    min = -config.width / 2;
    formPath(); //形成路径
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect); //裁剪区域
    canvas.translate(rect.width / 2, rect.height / 2);
    canvas.drawPath(mPath, mPaint);
    canvas.drawPath(mReflexPath, mPaint);
  }

  //根据渐息函数进行路径的生成
  void formPath() {
    mPath.moveTo(min, f(min));
    mReflexPath.moveTo(min, f(min));
    for (double x = min; x <= max; x += config.lineWidth * 2) {
      double y = f(x);
      mPath.lineTo(x, y);
      mReflexPath.lineTo(x, -y); //x轴对称路径
    }
  }

  double f(double x) {
    //渐息函数
    double len = max - min;
    double a = 4 / (4 + pow(rad(x / pi * 800 / len), 4));
    double buff = pow(a, 2.5); //衰减函数
    omg = 2 * pi / (rad(len) / 2);
    double y = buff * A * sin(omg * rad(x) - fie); //振动方程+衰减函数
    return y;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

double rad(double deg) => deg / 180 * pi;
