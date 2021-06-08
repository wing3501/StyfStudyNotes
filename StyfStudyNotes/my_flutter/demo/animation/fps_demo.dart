import 'package:flutter/material.dart';

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
          child: FpsShow(),
        ),
      ),
    );
  }
}

class FpsShow extends StatefulWidget {
  @override
  _FpsShowState createState() => _FpsShowState();
}

class _FpsShowState extends State<FpsShow> with SingleTickerProviderStateMixin {
  String _fps = ''; //文字
  AnimationController controller; //动画控制器
  var _oldTime = DateTime.now().millisecondsSinceEpoch; //首次运行时时间

  @override
  void initState() {
    controller = //创建AnimationController对象
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    controller.addListener(_render); //添加监听,执行渲染
    controller.repeat(); //重复不断执行动画
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose(); // 资源释放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(-0.5, 0.5),
      child: Text("FPS:$_fps"),
    );
  }

  _render() {
    //渲染方法，更新状态
    setState(() {
      var now = DateTime.now().millisecondsSinceEpoch; //新时间
      var dt = now - _oldTime; //两次刷新间隔的毫秒值
      _fps = (1000 / dt).toStringAsFixed(1); //1000毫秒可以刷新多少次及FPS
      print(_fps);
      _oldTime = now; //重新赋值
    });
  }
}
