import 'dart:io';

main(List<String> args) {
  print("main start");
  getdata();
  print("main end");
}

void getdata() async {
  var res1 = await getNetworkData("arg1");
  print(res1);
  var res2 = await getNetworkData(res1);
  print(res2);
  var res3 = await getNetworkData(res2);
  print(res3);
}

Future getNetworkData(String arg) {
  return Future(() {
    sleep(Duration(seconds: 3));
    return "Hello " + arg;
  });
}
