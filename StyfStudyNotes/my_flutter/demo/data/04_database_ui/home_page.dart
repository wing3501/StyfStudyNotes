import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'view/items/todo_card_item.dart';
import 'view/items/todo_item.dart';
import 'api/todo_api.dart';
import 'view/items/todo_chip_item.dart';
import 'dao/todo_dao.dart';

import 'model/todo_bean.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TestDatabase(),
    );
  }
}

class TestDatabase extends StatefulWidget {
  @override
  _TestDatabaseState createState() => _TestDatabaseState();
}

class _TestDatabaseState extends State<TestDatabase> {
  int _counter = 0;
  int _insertFlag;
  List<Map> _queryMap;
  List<TodoBean> todos;

  @override
  Widget build(BuildContext context) {
    var buttons = Wrap(
      spacing: 20,
      direction: Axis.vertical,
      children: <Widget>[
        RaisedButton(
          onPressed: _getVersion,
          child: Text(
            '数据库版本:${_counter}',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        RaisedButton(
          onPressed: _insertTestData,
          child: Text(
            '插入操作结果:$_insertFlag',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        RaisedButton(
          onPressed: _queryAllData,
          child: Text(
            '查询操作',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ],
    );

    var items = Container(
      height: 400,
      width: 300,
      child: ListView.builder(
          itemCount: todos?.length,
          itemBuilder: (_, index) => Card(
                  child: TodoCardItem(
                todo: todos[index],
//            onTap: _updateData,
//            onDelete: _deleteData,
              ))),
    );
    return Column(
      children: <Widget>[buttons, if (todos != null) items],
    );
  }

  _getVersion() async {
    var db = await TodoDao.db.database;
    _counter = await db.getVersion();
    setState(() {});
  }

  _insertTestData() async {
    var now = DateTime.now().millisecondsSinceEpoch;
    var aDay = 24 * 60 * 60 * 1000;
    TodoBean bean = TodoBean(
        todoTitle: "修复音乐播放器bug",
        todoContent: "播放顺序错乱，周五之前搞定。",
        todoColor: "0xffd14d52",
        todoCreateTime: now,
        todoStartTime: now + aDay,
        todoEndTime: now + 3 * aDay,
        todoIcon: 1);
    await TodoDao.db.insertTestData();

    todos = await TodoApi.query();
    setState(() {});
  }

  _queryAllData() async {
    _queryMap = await TodoDao.db.queryAll();
    todos = await TodoApi.query();
    setState(() {});
    var snackBar = SnackBar(
        backgroundColor: Color(0xffFB6431), //颜色
        content: Text(_queryMap.toString()), //内容
        duration: Duration(seconds: 10), //持续时间
        action: SnackBarAction(onPressed: () {}, label: ""));
    Scaffold.of(context).showSnackBar(snackBar); //弹出snackBar
  }

  _updateData(TodoBean todo) async {
    todo.todoDone = todo.todoDone == 1 ? 0 : 1;
    await TodoApi.update(todo);
    todos = await TodoApi.query();
    setState(() {});
  }

  _deleteData(TodoBean todo) async {
    todo.todoDone = 1;
    await TodoApi.delete(todo.todoId);
    todos = await TodoApi.query();
    setState(() {});
  }
}
