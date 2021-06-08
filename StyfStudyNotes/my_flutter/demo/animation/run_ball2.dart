import 'package:flutter/material.dart';
import 'package:my_flutter/utils/color_utils.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(child: RunBallWidget(size: Size(200, 150))),
      ),
    );
  }
}

class Ball {
  //小球信息描述类
  double aX; //加速度
  double aY; //加速度Y
  double vX; //速度X
  double vY; //速度Y
  double x; //点位X
  double y; //点位Y
  Color color; //颜色
  double r; //小球半径
  Ball(
      {this.x = 0,
      this.y = 0,
      this.color,
      this.r = 10,
      this.aX = 0,
      this.aY = 0,
      this.vX = 0,
      this.vY = 0});
}

class RunBallWidget extends StatefulWidget {
  final Size size;
  RunBallWidget({Key key, this.size = const Size(200, 100)}) : super(key: key);
  @override
  _RunBallWidgetState createState() => _RunBallWidgetState();
}

class _RunBallWidgetState extends State<RunBallWidget>
    with SingleTickerProviderStateMixin {
  var _ball = Ball(
      color: Colors.blueAccent, r: 10, aY: 0.1, vX: 2, vY: -2, x: 0.0, y: 0.0);
  AnimationController controller;
  @override
  void initState() {
    controller = //创建AnimationController对象
        AnimationController(duration: Duration(seconds: 3), vsync: this)
          ..addListener(_render); //添加监听,执行渲染
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  } // 资源释放

  @override
  Widget build(BuildContext context) {
    var paint = CustomPaint(
      painter: RunBallPainter(_ball),
    );
    return InkWell(
      onTap: () => controller.repeat(), //点击时执行动画
      onDoubleTap: () => controller.stop(), //双击时暂停动画
      child: SizedBox.fromSize(child: paint, size: widget.size),
    );
  }

  //渲染方法，更新小球信息
  void _render() {
    //渲染方法，更新小球信息
    setState(() {
      //刷新屏幕
      _ball.x += _ball.vX; //运动学公式
      _ball.y += _ball.vY;
      _ball.vX += _ball.aX;
      _ball.vY += _ball.aY;
      var height = widget.size.height;
      var width = widget.size.width;
      //限定下边界
      if (_ball.y > height - 2 * _ball.r) {
        _ball.y = height - 2 * _ball.r;
        _ball.vY = -_ball.vY; //Y速度反向
        _ball.color = ColorUtils.randomColor(); //碰撞后随机色
      }
      if (_ball.y < 0) {
        //限定上边界
        _ball.y = 0;
        _ball.vY = -_ball.vY; //Y速度反向
        _ball.color = ColorUtils.randomColor(); //碰撞后随机色
      }
      //限定左边界
      if (_ball.x < 0) {
        _ball.x = 0;
        _ball.vX = -_ball.vX; //X速度反向
        _ball.color = ColorUtils.randomColor(); //碰撞后随机色
      }
      //限定右边界
      if (_ball.x > width - 2 * _ball.r) {
        _ball.x = width - 2 * _ball.r;
        _ball.vX = -_ball.vX; //X速度反向
        _ball.color = ColorUtils.randomColor(); //碰撞后随机色
      }
    });
  }
}

///画板Painter:绘制小球
class RunBallPainter extends CustomPainter {
  Ball _ball; //小球
  Paint mPaint; //主画笔
  Paint bgPaint; //背景画笔
  RunBallPainter(this._ball) {
    mPaint = Paint();
    bgPaint = Paint()..color = Color.fromARGB(148, 198, 246, 248);
  }
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect); //裁剪区域
    canvas.drawPaint(bgPaint);
    _drawBall(canvas, _ball);
  }

  void _drawBall(Canvas canvas, Ball ball) {
    ///使用[canvas] 绘制[ball]
    canvas.drawCircle(Offset(ball.x + ball.r, ball.y + ball.r), ball.r,
        mPaint..color = ball.color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
