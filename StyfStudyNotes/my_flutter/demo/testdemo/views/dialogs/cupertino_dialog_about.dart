import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDialogAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: _buildContent(),
      title: _buildTitle(),
      actions: <Widget>[
        CupertinoButton(
          child: Text("确定"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  final imgPath = 'assets/images/icon_head.png';
  //构建弹框标题
  Widget _buildTitle() => Row(children: <Widget>[
        Image.asset(imgPath, width: 30, height: 30),
        SizedBox(width: 10),
        Text("关于")
      ]);

  //构建弹框内容
  Widget _buildContent() => Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FlutterLogo(size: 50),
        SizedBox(height: 20),
        Text("Flutter Unit V0.0.1"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Power By GF·J·Toly",
          ),
        )
      ]);
}

