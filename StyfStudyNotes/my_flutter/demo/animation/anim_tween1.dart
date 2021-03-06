import 'package:flutter/material.dart';
import 'package:my_flutter/utils/path_provider.dart';

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
          child: Container(
            child: StarAnimWidget(),
          ),
        ),
      ),
    );
  }
}

class Star {
  double R; //外接圆半径
  double r; //内接圆半径
  int num; //角个数
  Color color;

  Star(this.num, this.R, this.r, {this.color = Colors.deepOrange});
}

class StarAnimWidget extends StatefulWidget {
  final Size size;

  StarAnimWidget({Key key, this.size = const Size(200, 200)}) : super(key: key);

  @override
  _StarAnimWidgetState createState() => _StarAnimWidgetState();
}

class _StarAnimWidgetState extends State<StarAnimWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller; //控制器
  Animation<double> animation; //动画
  Star _star; //状态量
  @override
  void initState() {
    _star = Star(5, widget.size.height / 2, widget.size.height / 4);
    super.initState();
    controller = AnimationController(
        //创建 Animation对象
        duration: const Duration(milliseconds: 2000),
        vsync: this);
    var tween = Tween(begin: 100.0, end: 20.0); //创建从100到20变化的Animatable对象
    animation = tween.animate(controller); //执行animate方法，生成
    animation.addListener(() => render(_star, animation.value));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  } // 资源释放

  @override
  Widget build(BuildContext context) {
    var show = SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: CustomPaint(
        painter: StarPainter(_star),
      ),
    );
    return InkWell(
      child: show,
      onTap: () => controller.forward(), //点击时执行动画
      onDoubleTap: () => controller.stop(),
    ); //双击击时暂停动画
  }

  void render(Star star, num value) {
    setState(() {
      star.R = value;
    });
  } //核心渲染方法
}

//绘制板:绘制n角星
class StarPainter extends CustomPainter {
  Star _star;
  Paint _paint;

  StarPainter(this._star) {
    _paint = Paint()..color = Colors.deepOrange;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect); //裁剪区域
    canvas.translate(rect.height / 2, rect.width / 2);
    _drawStar(canvas, _star);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawStar(Canvas canvas, Star star) {
    canvas.drawPath(
        PathCreator.nStarPath(
          star.num,
          star.R,
          star.r,
        ),
        _paint..color = _star.color);
  }
}
