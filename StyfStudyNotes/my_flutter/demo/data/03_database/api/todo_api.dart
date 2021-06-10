import '../dao/todo_dao.dart';
import '../model/todo_bean.dart';

class TodoApi {// 操作Todo的api ,利用 TodoDao 对操作进行再加工
  static Future<List<TodoBean>> query() async {//查询获取Todo列表
    var list = await TodoDao.db.queryAll();
    return list.map((e) => TodoBean.formMap(e)).toList();
  }

  //更新操作
  static Future<int> update(TodoBean todo) async {
    return await TodoDao.db.update(todo);
  }

  //删除操作
  static Future<int> delete(int id) async {
    return await TodoDao.db.delete(id);
  }
}