import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class ReadFilePage extends StatefulWidget {
  @override
  _ReadFilePageState createState() => _ReadFilePageState();
}

class _ReadFilePageState extends State<ReadFilePage> {
  var result = "path_provider提供的路径：\n";

  @override
  void initState() {
    _getPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("读写文件"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                result,
                style: TextStyle(fontSize: 18),
              ),
            ),
            RaisedButton(
              onPressed: _write2SD,
              child: Text("写入文件"),
            ),
            RaisedButton(
              onPressed: _checkPermission,
              child: Text("检查权限"),
            )
          ],
        ));
  }

  _getPath() async {
    var td = await getTemporaryDirectory(); //应用包路径cache文件
    var asd = await getApplicationSupportDirectory(); //应用包路径file文件
    var add = await getApplicationDocumentsDirectory(); //应用包路径app_flutter文件
//    var esd=await getExternalStorageDirectory();//外部储存的应用包路径/file文件，仅Android，

    result += "getTemporaryDirectory:\n${td.path}\n\n";
    result += "getApplicationSupportDirectory:\n${asd.path}\n\n";
    result += "getApplicationDocumentsDirectory:\n${add.path}\n\n";
//    result+="getExternalStorageDirectory:\n${esd.path}\n\n";
    setState(() {});
  }

  _write2File() async {
    var dir = await getApplicationSupportDirectory();
    var file = File(path.join(dir.path, "hello_flutter.txt"));
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString("Hello,Flutter"); //写入文件
    var content = await file.readAsString(); //读取文件
    print(content);
    result += content;
    setState(() {});
  }

  _write2SD() async {
    var file = File("/sdcard/Pictures/hello_flutter.txt");
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString("Hello,Flutter"); //写入文件
    var content = await file.readAsString(); //读取文件
    print(content);
    result += content;
    setState(() {});
  }

  _checkPermission() async {
    // PermissionStatus status = await PermissionHandler()
    //     .checkPermissionStatus(PermissionGroup.storage);
    // switch (status) {
    //   case PermissionStatus.granted:
    //     result += "权限已获取";
    //     break;
    //   case PermissionStatus.unknown:
    //     result += "权限未知";
    //     break;
    //   case PermissionStatus.denied:
    //     await _applyPermission();
    //     result += "权限被拒绝";
    //     break;
    //   case PermissionStatus.restricted:result += "权限-restricted";break;
    //   case PermissionStatus.disabled:
    //     result += "权限-disabled";
    //     break;
    // }
    // setState(() {});
  }

  var _apply = 0;
  _applyPermission() async {
    // Map<PermissionGroup, PermissionStatus> permissions =
    // await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    // permissions.forEach((key,value) async{
    //     switch(value){
    //       case PermissionStatus.granted:
    //         result += "权限已获取";
    //         break;
    //       case PermissionStatus.denied:
    //         _apply++;
    //         if(_apply<=3){
    //           await _applyPermission();
    //         }
    //         result += "权限被拒绝";
    //         break;
    //     }
    // });
    // setState(() {});
  }
}
