import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;

/// 图片放大组件BiggerView  图片流、绘图
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
    var show = BiggerView(
      image: AssetImage("assets/images/sabar.jpg"), //图片
      config: BiggerConfig(
          rate: 3, //放大比例
          isClip: false //是否圆形
          ),
    );

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

class BiggerConfig {
  final double rate; //放大比

  final double radius; //半径
  final Color outlineColor; //圆形区域外框色
  final bool isClip; //是否圆形区域

  const BiggerConfig(
      {this.rate = 3,
      this.isClip = true,
      this.radius = 30,
      this.outlineColor = Colors.white});
}

class BiggerView extends StatefulWidget {
  BiggerView(
      {Key key, this.config = const BiggerConfig(), @required this.image})
      : super(key: key);
  final BiggerConfig config;
  final ImageProvider image; //图片提供器
  @override
  _BiggerViewState createState() => _BiggerViewState();
}

class _BiggerViewState extends State<BiggerView> {
  var posX = 0.0; //触点点位X
  var posY = 0.0; //触点点位Y
  bool canDraw = false; //是否绘制放大图
  var width = 0.0; //容器宽
  var height = 0.0; //容器高
  ui.Image _image; //图片

  @override
  void initState() {
    //加载ui.Image 完成后刷新界面
    loadImage(widget.image).then((img) => setState(() => _image = img));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onPanDown: (detail) {
          //点击回调，更新点位，可以画大图
          posX = detail.localPosition.dx;
          posY = detail.localPosition.dy;
          setState(() => canDraw = true);
        },
        onPanUpdate: (detail) {
          //手指移动，更新点位，并判断区域是否在图中，不再则不更新
          posX = detail.localPosition.dx;
          posY = detail.localPosition.dy;
          if (judgeRectArea(posX, posY, width + 2, height + 2)) {
            setState(() {});
          }
        },
        onPanEnd: (detail) => setState(() => canDraw = false), //抬起，不绘制放大图
        child: _image != null
            ? _buildImage(_image)
            : Center(
                child: CircularProgressIndicator(),
              ),
      );

  //判断落点是否在矩形区域
  bool judgeRectArea(double dstX, double dstY, double w, double h) =>
      (dstX - w / 2).abs() < w / 2 && (dstY - h / 2).abs() < h / 2;

  Widget _buildImage(ui.Image image) {
    width = image.width / widget.config.rate;
    height = image.height / widget.config.rate;
    return Container(
        width: width,
        height: height,
        child: CustomPaint(
            //使用CustomPaint承载BiggerPainter
            painter: BiggerPainter(image, posX, posY, canDraw, widget.config)));
  }

  Future<ui.Image> loadImage(ImageProvider provider) {
    Completer<ui.Image> completer = Completer<ui.Image>();
    ImageStreamListener listener;
    ImageStream stream = provider.resolve(ImageConfiguration());
    listener = ImageStreamListener((info, syno) {
      final ui.Image image = info.image; //监听图片流，获取图片
      completer.complete(image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    return completer.future;
  }
}

class BiggerPainter extends CustomPainter {
  final ui.Image _img; //图片
  Paint _paint = Paint(); //主画笔
  Path circlePath = Path(); //圆路径
  double _x; //触点x
  double _y; //触点y
  double _radius; //圆形放大区域
  BiggerConfig _config; //放大倍率
  bool _canDraw; //是否绘制放大图
  BiggerPainter(this._img, this._x, this._y, this._canDraw, this._config) {
    _paint
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    _radius = _config.radius;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect); //裁剪区域
    if (_img != null) {
      Rect src =
          Rect.fromLTRB(0, 0, _img.width.toDouble(), _img.height.toDouble());
      canvas.drawImageRect(_img, src, rect, _paint); //绘制原图像
      if (_canDraw) {
        var offSetY =
            _y > 3 * _radius ? -2 * _radius : 2 * _radius; //当圆形区域出顶部进行校正
        circlePath.addOval(
            Rect.fromCircle(center: Offset(_x, _y + offSetY), radius: _radius));
        if (_config.isClip) {
          //根据是否需要圆形裁剪进行绘制
          canvas.clipPath(circlePath);
          canvas.drawImage(
              _img,
              Offset(
                  -_x * (_config.rate - 1), -_y * (_config.rate - 1) + offSetY),
              _paint);
          canvas.drawPath(circlePath, _paint);
        } else {
          canvas.drawImage(
              _img,
              Offset(-_x * (_config.rate - 1), -_y * (_config.rate - 1)),
              _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
