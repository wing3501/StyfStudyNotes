import 'dart:io';

main(List<String> args) {
  print("main start");
  var res = getNetworkData().then((value) => print("结果:$value"));
  print(res);
  print("main end");
}

//swait必须在async函数中
//async返回的结果必须是个Future
Future getNetworkData() async {
  await sleep(Duration(seconds: 3));
  return "hello";
}
