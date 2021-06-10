import 'package:flutter/material.dart';
import '../../model/todo_bean.dart';

class TodoChipItem extends StatelessWidget {
  final TodoBean todo; //用户
  final Color color; //主色调
  final Function(TodoBean) onTap;
  final Function(TodoBean) onDelete;
  TodoChipItem(this.todo,
      {this.color = Colors.blue, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    var color = todo.todoDone == 0 ? this.color : Colors.green;

    var titleTextStyle = TextStyle(
        //标题文字样式
        color: color,
        fontSize: 17,
        shadows: [Shadow(color: Colors.white, offset: Offset(.3, .3))]);
    var infoStyle = TextStyle(
        //信息文字样式
        color: Colors.black.withAlpha(150),
        fontSize: 12,
        shadows: [Shadow(color: Colors.white, offset: Offset(.3, .3))]);

    var tile = ListTile(
      //布局主体
      leading: Container(
        child:
            ClipOval(child: Text("${todo.todoId}", style: titleTextStyle)), //左边
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle, //圆形装饰线
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(55),
              offset: Offset(0.0, 0.0),
              blurRadius: 3.0,
              spreadRadius: 0.0,
            )
          ],
        ),
      ),
      title: Text(todo.todoTitle, style: titleTextStyle), //中间上部
      subtitle: Text(todo.todoContent, style: infoStyle),
      trailing: InkWell(
        child: Icon(Icons.close),
        onTap: () {
          onDelete(todo);
        },
      ), //尾部
    );

    return InkWell(
      onTap: () {
        onTap(todo);
      },
      child: Container(
        height: 80,
        alignment: Alignment.center,
        color: color.withAlpha(11),
        child: tile,
      ),
    );
  }
}
