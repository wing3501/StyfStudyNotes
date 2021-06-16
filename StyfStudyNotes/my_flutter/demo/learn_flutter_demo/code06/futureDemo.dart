import 'dart:io';

main(List<String> args) {
  print("main start");
  // Future future = getNetwordData();
  // future.then((value) => print("结果：$value")).catchError((err) {
  //   print("捕获:$err");
  // });

  Future(() {
    sleep(Duration(seconds: 3));
    return "第一次结果";
  }).then((value) {
    print("打印第一次结果：$value");
    //发送第二次
    sleep(Duration(seconds: 2));
    return "第二次结果";
  }).then((value) {
    print("打印第二次结果：$value");
    sleep(Duration(seconds: 2));
    return "第三次结果";
  }).then((value) {
    print("打印第三次结果：$value");
  }).whenComplete(() => print("全部结束了"));

  Future.value("哈哈").then((value) => print(value));
  Future.error("error").catchError((err) {});
  Future.delayed(Duration(seconds: 3)).then((value) {
    return "哈哈";
  }).then((value) => print(value));
  Future.delayed(Duration(seconds: 3), () {
    return "aaa";
  });

  print("main end");
}

Future<String> getNetwordData() {
  return Future<String>(() {
    sleep(Duration(seconds: 2));
    throw Exception("我是错误");
  });
}
