import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CanvasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var winSize = MediaQuery.of(context).size; //获取屏幕尺寸
    return Scaffold(
      body: CustomPaint(//使用CustomPaint盛放画布
        painter: CanvasPainter(winSize),
      ),
    )
    ;
  }
}

class CanvasPainter extends CustomPainter {
  Paint _paint; //画笔对象
  Path _path=Path(); //路径对象
  Path _linePath=Path(); //路径对象
  Size _size; // 网格区域

  Paint _pointPaint=Paint();
  Paint _circlePaint=Paint();

  CanvasPainter(this._size) {
    _paint = Paint() //创建画笔对象,使用级联符号初始化画笔
      ..style=PaintingStyle.stroke //画线条
      ..color = Color(0xffBBC3C5)//画笔颜色
      ..isAntiAlias = true; //抗锯齿

    _pointPaint..strokeWidth=1
    ..strokeCap=StrokeCap.square;

    _circlePaint..strokeWidth=2
    ..color=Colors.blue..style=PaintingStyle.stroke
    ;

  }

  @override // 实现绘制方法
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(gridPath(50, _size), _paint); //使用path绘制

    canvas.drawPoints(PointMode.polygon,
        [Offset(50, 100),Offset(100, 50),Offset(150, 100),Offset(200, 50)],
        _pointPaint..color=Colors.red);



    canvas.drawRect(Rect.fromLTRB(0, 0, 50, 50), _circlePaint..color=Colors.cyanAccent..style=PaintingStyle.fill);
    canvas.drawRRect(RRect.fromLTRBR(200, 0, 250, 50, Radius.circular(10)),
        _circlePaint..color=Colors.amber..style=PaintingStyle.stroke);

    canvas.drawCircle(Offset(100,100), 50, _circlePaint..color=Colors.blue);
    canvas.drawCircle(Offset(100,100), 50/sqrt(2), _circlePaint..style=PaintingStyle.fill);
    canvas.drawOval(Rect.fromLTRB(0, 90, 50, 110), _circlePaint);
    canvas.drawArc(Rect.fromLTRB(0, 0, 200, 200),  pi/4, pi/2, false, _circlePaint..style=PaintingStyle.stroke..color=Colors.red);

    _linePath.moveTo(200, 100);//移至200，100坐标
    _linePath.lineTo(200, 200);//画直线到300，150
    _linePath.relativeLineTo(-5, -10);//以200，200为参考点，画线横向-5, 纵向-10
    _linePath.moveTo(200, 200);//移至300, 150坐标
    _linePath.relativeLineTo(5, -10);//以200，200为参考点，画线横向5, 纵向-10
    _linePath.arcTo(Rect.fromLTRB(200, 150, 300, 250), 0, pi, true);//添加圆弧
    _linePath.addOval(Rect.fromLTRB(250, 150, 350, 200));//添加椭圆
    canvas.drawPath(_linePath, _circlePaint);
  }

  @override // 是否应该重新绘制
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  Path gridPath(double step, Size area) {
    //绘制网格路径   step 小格边长  area 绘制区域
    for (int i = 0; i < area.height / step + 1; i++) {//画横线
      _path.moveTo(0, step * i); //移动画笔
      _path.lineTo(area.width, step * i); //画直线
    }
    for (int i = 0; i < area.width / step + 1; i++) {//画纵线
      _path.moveTo(step * i, 0);
      _path.lineTo(step * i, area.height);
    }
    return _path;
  }
}
