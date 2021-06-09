import 'dart:convert';

main() {
//  simple();


  mapList();
}

void simple() {
  String jsonStr = """
{ "name":"Flutter之旅",
  "author":"张风捷特烈"}
""";

  var book =
  Book.fromMap(json.decode(jsonStr));
  print(book.name);//Flutter之旅
  print(book.author);//张风捷特烈
}

class Book {
  String name;
  String author;

//根据Map创建实例
  Book.fromMap(Map<String, dynamic> json) {
    name = json["name"];
    author = json["author"];
  }
}


mapList() {
  var jsonStr="""
{
  "count": 3,
  "code": 200,
  "msg": "请求正常",
  "users": [
    {"name": "toly","skill":"Java"},
    {"name": "ls","skill":"Dart"},
    {"name": "wy","skill":"Kotlin"}
  ]
}
""";

  var li =Result.formMap(json.decode(jsonStr));
  print(li.code);
}

class Result{
  final int count;//数量
  final int code;//响应码
  final String msg;//信息
  final List<User> users;//用户

  Result(this.count, this.code, this.msg, this.users);
  factory Result.formMap(Map<String, dynamic> map){

    var users = (map["users"] as List).map((item)=>
        User.formMap(item)).toList();
    return Result(map["count"],map["code"],map["msg"],users);
  }
}

class User{
  final String name;
  final String skill;
  const User(this.name, this.skill);
  factory User.formMap(Map<String, Object> map)=>
      User(map["name"],map["skill"] );
}