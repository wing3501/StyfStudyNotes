import 'package:flutter/material.dart';

typedef CheckCallback = void Function(Color color); //定义回调

class ColorChooser extends StatefulWidget {
  ColorChooser(
      {Key key,
      this.radius = 20,
      this.initialIndex = 0,
      this.runSpacing = 10,
      this.spacing = 10,
      this.direction = Axis.horizontal,
      this.shadowColor = Colors.blue ,
      @required this.colors,
      @required this.onChecked})
      : super(key: key);

  //小圆设置
  final double radius; //半径
  final List<Color> colors; //颜色
  final CheckCallback onChecked; //点击回调
  final int initialIndex; //初始索引
  final Color shadowColor; //颜色
  //Wrap 设置
  final double spacing;
  final double runSpacing;
  final Axis direction;

  @override
  _ColorChooserState createState() => _ColorChooserState();
}

///动画构造器，缩放+透明度动画
Widget _transitionsBuilder(
    BuildContext context, Animation<double> animation, Widget child) {
  var tween = TweenSequence<double>([
    TweenSequenceItem<double>(tween: Tween(begin: 1.0, end: 0.7), weight: 1),
    TweenSequenceItem<double>(tween: Tween(begin: 0.7, end: 1.0), weight: 2),
  ]);

  return FadeTransition(
    opacity: tween.animate(CurvedAnimation(
      parent: animation,
      curve: Curves.linear,
    )),
    child: ScaleTransition(
      scale: tween
          .animate(CurvedAnimation(parent: animation, curve: Curves.linear)),
      child: child,
    ),
  );
}

class _ColorChooserState extends State<ColorChooser>
    with SingleTickerProviderStateMixin {
  int _perPosition = 0; //点击的位置
  AnimationController _controller; //控制器

  @override
  void initState() {
    _perPosition = widget.initialIndex; //初始位
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    super.dispose();
  }

  //通过Wrap实现包裹效果，direction，spacing，runSpacing直接使用Wrap特性
  @override
  Widget build(BuildContext context) => Wrap(
      direction: widget.direction,
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: widget.colors //使用颜色数组映射出需要的组件列表
          .map((color) => GestureDetector(
                onTap: () => _onTapItem(color),
                child: widget.colors.indexOf(color) == _perPosition //是否是当前索引位
                    ? buildActiveWidget(context, color)//是当前索引位，构建激活条目
                    : ShapeColor(color: color, radius: widget.radius,
                    checked: false, shadowColor: widget.shadowColor),
              ))
          .toList());

  //构建激活条目
  Widget buildActiveWidget(BuildContext context, Color color) =>
      _transitionsBuilder(
          context,
          _controller,
          ShapeColor(
              shadowColor: widget.shadowColor,
              color: color,
              radius: widget.radius,
              checked: true));

//点击时的处理方法
  void _onTapItem(Color color) {
    _controller.reset();
    _controller.forward();
    if (widget.onChecked != null) widget.onChecked(color); //回调
    setState(() {
      //刷新
      _perPosition = widget.colors.indexOf(color); //更新点位
    });
  }
}

class ShapeColor extends StatelessWidget {
  ShapeColor(
      {Key key,
      this.radius = 20,
      this.checked = true,
      this.color = Colors.red,
      this.shadowColor = Colors.red})
      : super(key: key);
  final double radius; //半径
  final bool checked; //标记是否被选中
  final Color color; //颜色
  final Color shadowColor; //颜色
  @override
  Widget build(BuildContext context) => Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        //圆形装饰线
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          if (checked)
            BoxShadow(
                color: shadowColor,
                offset: Offset(0.0, 0.0),
                spreadRadius: radius / 10)
        ],
      ));
}
