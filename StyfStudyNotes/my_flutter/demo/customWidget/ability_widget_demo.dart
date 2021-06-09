import 'dart:math';

import 'package:flutter/material.dart';

/// 能力分析组件AbilityWidget  动画、绘制
void main() => runApp(App());

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var show = AbilityWidget(
        data: {
          "语文": 40.0,
          "数学": 30.0,
          "英语": 20.0,
          "政治": 40.0,
          "音乐": 80.0,
          "生物": 50.0,
          "化学": 60.0,
          "地理": 80.0,
        },
        config: AbilityConfig(
          duration: 1500,
          image: AssetImage("assets/images/sabar.jpg"),
          radius: 150,
          color: Colors.black,
        ));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('主页'),
          ),
          body: show,
        ));
  }
}

///
/// AbilityWidget(
//    data: {
//      "语文": 40.0,
//      "数学": 30.0,
//      "英语": 20.0,
//      "政治": 40.0,
//      "音乐": 80.0,
//      "生物": 50.0,
//      "化学": 60.0,
//      "地理": 80.0,
//    },
//    config: AbilityConfig(
//      duration: 1500,
//      image: AssetImage("images/canvas.jpg"),
//      radius: 150,
//      color: Colors.black,
//    ))

class AbilityConfig {
  final double radius; //圆的半径
  final int duration; //动画持续时长
  final ImageProvider image; //图片
  final Color color; //颜色
  final int div; //分段数

  const AbilityConfig(
      {this.radius = 100,
      this.duration = 2000,
      this.div = 10,
      this.image,
      this.color = Colors.black});
}

class AbilityWidget extends StatefulWidget {
  AbilityWidget(
      {Key key, @required this.data, this.config = const AbilityConfig()})
      : super(key: key);

  final AbilityConfig config; //配置
  final Map<String, double> data; //数据
  @override
  _AbilityWidgetState createState() => _AbilityWidgetState();
}

class _AbilityWidgetState extends State<AbilityWidget>
    with SingleTickerProviderStateMixin {
  var _angle = 0.0; //旋转角度
  AnimationController _controller; //动画控制器
  Animation<double> animation; //动画

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        ////创建 Animation对象
        duration: Duration(milliseconds: widget.config.duration), //时长
        vsync: this);

    var curveTween =
        CurveTween(curve: Cubic(0.96, 0.13, 0.1, 1.2)); //创建curveTween
    animation =
        Tween(begin: 0.0, end: 2 * pi).animate(curveTween.animate(_controller))
          ..addListener(() => setState(() {
                _angle = animation.value;
              })); //动画监听
    _controller.forward(); //立即执行
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outlinePainter = Transform.rotate(
      //外圈部分
      angle: _angle,
      child: CustomPaint(
        painter: OutlinePainter(widget.config.radius, widget.config.color),
      ),
    );

    var img = Transform.rotate(
      //图片部分
      angle: _angle,
      child: Opacity(
        opacity: _controller.value * 0.4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.config.radius),
          child: Image(
            image: widget.config.image,
            width: widget.config.radius * 2,
            height: widget.config.radius * 2,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    var center = Transform.rotate(
        //组件部分
        angle: -_angle,
        child: SizedBox(
          width: widget.config.radius * 2,
          height: widget.config.radius * 2,
          child: CustomPaint(
            painter: AbilityPainter(
                widget.config.radius, widget.config.div, widget.data),
          ),
        ));

    return Center(
      //拼合
      child: Transform.scale(
        scale: 0.5 + _controller.value / 2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[img, center, outlinePainter],
        ),
      ),
    );
  }
}

class OutlinePainter extends CustomPainter {
  double _radius; //外圆半径
  Color _color; //外圆颜色
  Paint _linePaint; //线画笔
  Paint _fillPaint; //填充画笔

  OutlinePainter(this._radius, this._color) {
    _linePaint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke //线画笔
      ..strokeWidth = 0.008 * _radius
      ..isAntiAlias = true;

    _fillPaint = Paint()
      ..strokeWidth = 0.05 * _radius //填充画笔
      ..color = _color
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) => drawOutCircle(canvas);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  //绘制外圈
  void drawOutCircle(Canvas canvas) {
    canvas.drawCircle(Offset(0, 0), _radius, _linePaint); //圆形的绘制
    double r2 = _radius - 0.08 * _radius; //下圆半径
    canvas.drawCircle(Offset(0, 0), r2, _linePaint);
    for (var i = 0.0; i < 22; i++) {
      //循环画出小黑条
      canvas.save(); //保存状态
      canvas.rotate(360 / 22 * i / 180 * pi); //旋转:注意传入的是弧度（与Android不同）
      canvas.drawLine(Offset(0, -_radius), Offset(0, -r2), _fillPaint); //线的绘制
      canvas.restore(); //恢复状态
    }
  }
}

class AbilityPainter extends CustomPainter {
  Map<String, double> _data; //数据
  double _r; //外圆半径
  int _div; //分割数
  Paint _linePaint = Paint(); //线画笔
  Paint _abilityPaint = Paint(); //区域画笔
  Paint _fillPaint = Paint(); //填充画笔

  Path _linePath = Path(); //短直线路径
  Path _abilityPath = Path(); //范围路径

  AbilityPainter(this._r, this._div, this._data) {
    _linePaint
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.008 * _r
      ..isAntiAlias = true;
    _fillPaint
      ..strokeWidth = 0.05 * _r
      ..color = Colors.black
      ..isAntiAlias = true;
    _abilityPaint
      ..color = Color(0x8897C5FE)
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    canvas.translate(_r, _r); //移动坐标系
    drawInnerCircle(canvas);
    drawInfoText(canvas);
    drawAbility(canvas, _data.values.toList());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  //绘制内圈圆
  drawInnerCircle(Canvas canvas) {
    double innerRadius = 0.618 * _r; //内圆半径
    canvas.drawCircle(Offset(0, 0), innerRadius, _linePaint);
    for (var i = 0; i < _data.length; i++) {
      //遍历线条
      var rotateDeg = 2 * pi / _data.length * i.toDouble(); //每次旋转角度
      canvas.save();
      canvas.rotate(rotateDeg);
      _linePath.moveTo(0, -innerRadius);
      _linePath.relativeLineTo(0, innerRadius); //线的路径

      for (int j = 1; j < _div; j++) {
        //加[_div]条小线分割线
        _linePath.moveTo(-_r * 0.015, -innerRadius / _div * j);
        _linePath.relativeLineTo(_r * 0.015 * 2, 0);
      }
      canvas.drawPath(_linePath, _linePaint); //绘制线
      canvas.restore();
    }
  }

  //绘制文字
  void drawInfoText(Canvas canvas) {
    double r2 = _r - 0.08 * _r; //下圆半径
    for (int i = 0; i < _data.length; i++) {
      canvas.save();
      canvas.rotate(360 / _data.length * i / 180 * pi + pi);
      var text = _data.keys.toList()[i];
      var fontSize = _r * 0.1;
      TextPainter(
          text: TextSpan(
              text: text, //使用TextPainter绘制文字
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  color: Colors.black)),
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: 100) //必须进行layout
        ..paint(canvas, Offset(-fontSize, r2 - 0.22 * _r));
      canvas.restore();
    }
  }

  //绘制区域
  drawAbility(Canvas canvas, List<double> value) {
    _abilityPath.moveTo(0, -_r * 0.618 * value[0] / 100); //起点
    for (int i = 1; i < _data.length; i++) {
      double mark = _r * 0.618 * value[i] / 100; //一共多少长
      var deg = 2 * pi / _data.length * i - pi / 2;
      _abilityPath.lineTo(mark * cos(deg), mark * sin(deg));
    }
    _abilityPath.close();
    canvas.drawPath(_abilityPath, _abilityPaint);
  }
}
