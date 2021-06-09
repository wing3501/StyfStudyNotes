import 'dart:math';

import 'package:flutter/material.dart';

class StarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("n角星"),
      ),
      body: CustomPaint(
        //使用CustomPaint盛放画布
        painter: StartPainter(),
      ),
    );
  }
}

class StartPainter extends CustomPainter {
  Paint _paint; //画笔对象
  Path _path = Path(); //路径对象

  StartPainter() {
    _paint = Paint() //创建画笔对象,使用级联符号初始化画笔
      ..color = Colors.red //画笔颜色
      ..isAntiAlias = true; //抗锯齿
  }

  @override // 实现绘制方法
  void paint(Canvas canvas, Size size) {
    canvas.translate(50, 50); //移动到坐标系原点
    canvas.drawPath(nStarPath(5, 50, 25), _paint); //使用path绘制5角星
    canvas.translate(100, 0); //移动到坐标系原点
    canvas.drawPath(nStarPath(8, 50, 25), _paint); //使用path绘制8角星
    canvas.translate(100, 0); //移动到坐标系原点
    canvas.drawPath(nStarPath(12, 50, 25,rotate: pi), _paint); //使用path绘制12角星
  }

  @override // 是否应该重新绘制
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Path nStarPath(int num, double R, double r, {dx = 0, dy = 0,rotate=0}) {
    _path.reset();//重置路径
    double perRad = 2 * pi / num;//每份的角度
    double radA = perRad / 2 / 2+rotate;//a角
    double radB = 2 * pi / (num - 1) / 2 - radA / 2 + radA+rotate;//起始b角
    _path.moveTo(cos(radA) * R + dx, -sin(radA) * R + dy);//移动到起点
    for (int i = 0; i < num; i++) {//循环生成点，路径连至
      _path.lineTo(cos(radA + perRad * i) * R + dx, -sin(radA + perRad * i) * R + dy);
      _path.lineTo(cos(radB + perRad * i) * r + dx, -sin(radB + perRad * i) * r + dy);
    }
    _path.close();
    return _path;
  }
}
