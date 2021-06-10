import 'package:flutter/material.dart';
import '../../model/todo_bean.dart';
import 'corner_shape.dart';

class TodoCardItem extends StatelessWidget {
  TodoCardItem({Key key, this.todo}) : super(key: key);
  final TodoBean todo;

  @override
  Widget build(BuildContext context) {
    var tagHero = DateTime.now().microsecondsSinceEpoch;
    var icon = ProgressIcon(
      progress: todo.progress,
      iconData: todo.icon,
    );
    var titleStyle = TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    var titleText = Text(
      todo.title,
      style: titleStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
    var title = Row(
      children: <Widget>[
        icon,
        Expanded(
          child: titleText,
        ),
        InkWell(
            onTap: () {},
            child: Icon(
              Icons.mode_edit,
              size: 25,
              color: Colors.white,
            )),
        SizedBox(width: 10)
      ],
    );

    var stateMap = {
      TodoType.done: "完成",
      TodoType.doing: "进行中",
      TodoType.prepare: "准备",
      TodoType.death: "弃了",
    };

    var tag = CornerShape(
      color: todo.color,
      text: stateMap[todo.type],
      height: 25,
    );

    var content = Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 100,
//      color: Colors.white,"："

        child: Text(
          todo.content,
          style: TextStyle(color: Colors.black, fontSize: 16, shadows: [
            Shadow(color: Colors.white, blurRadius: 1, offset: Offset(0.5, 0.5))
          ]),
        ));

    var card = Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.45,
        color: todo.color,
        child: Column(
          children: <Widget>[
            title,
            Text(
              "起始时间 :${todo.startDate} ${todo.startTime}",
              style: TextStyle(color: Colors.white),
            ),
            Divider(),
            Expanded(child: content),
            Divider(),
            Text(
              "终止时间 :${todo.endDate} ${todo.endTime}",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
    return Stack(
        alignment: Alignment(-1.03, -0.4), children: <Widget>[card, tag]);
  }
}

class ProgressIcon extends StatelessWidget {
  ProgressIcon({Key key, this.progress, this.iconData}) : super(key: key);
  final double progress;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
        Icon(
          iconData,
          color: Colors.white,
        )
      ],
    );
  }
}
