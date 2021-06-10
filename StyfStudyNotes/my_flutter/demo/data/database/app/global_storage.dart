import '../dao/todo_dao.dart';

///全局存储类
class GlobalStorage {

  ///初始化操作
  static Future<void> init() async {
    await TodoDao.db.initDB(); //初始化数据库

  }

}