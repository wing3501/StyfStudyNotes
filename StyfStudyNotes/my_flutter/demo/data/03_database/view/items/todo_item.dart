import 'package:flutter/material.dart';
import '../../model/todo_bean.dart';
import 'corner_shape.dart';

class TodoItem extends StatelessWidget {
  TodoItem({Key key, this.todo}) : super(key: key);
  final TodoBean todo;

  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    var infoStyle = TextStyle(color: Colors.grey, fontSize: 12);

    var center = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          todo.title,
          style: titleStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        pH(5),
        Text(
          todo.content,
          style: infoStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        )
      ],
    );

    var right = Column(
      children: <Widget>[
        Text(
          "开始时间：" + todo.startDate,
          style: infoStyle,
        ),
        pH(12),
        Text(
          "结束时间：" + todo.endDate,
          style: infoStyle,
        ),
      ],
    );

    var item = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            todo.icon,
            color: todo.color,
          ),
        ),
        Expanded(
          child: center,
        ),
        pW(20),
        right,
        pW(10),
      ],
    );

    var stateMap = {
      TodoType.done: "完成",
      TodoType.doing: "进行中",
      TodoType.prepare: "准备",
      TodoType.death: "弃了",
    };

    var line = Container(
      //水平进度条
      height: 1,
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(todo.color),
        backgroundColor: Colors.grey,
        value: todo.progress,
      ),
    );

    var itemTodo = Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12.0),
          child: item,
        ),
        line,
      ],
    );
    return Stack(alignment: Alignment(-1.0, -0.9), children: <Widget>[
      itemTodo,
      Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: CornerShape(
          color: todo.color,
          text: stateMap[todo.type],
          height: 15,
        ),
      )
    ]);
  }

  Widget pW(double num) {
    return SizedBox(
      width: num,
    );
  }

  Widget pH(double num) {
    return SizedBox(
      height: num,
    );
  }
}

//class ProgressIcon extends StatelessWidget {
//  ProgressIcon({Key key,this.progress,this.iconData}) :super(key: key);
//  final double progress;
//  final IconData iconData;
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Stack(
//      alignment: Alignment.center,
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.all(8),
//          child: CircularProgressIndicator(
//            value: progress,
//            backgroundColor: Colors.white,
//            strokeWidth: 1.5,
//            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
//        ),
//        Icon(iconData,color: Colors.white,)
//      ],);
//  }
//
//}