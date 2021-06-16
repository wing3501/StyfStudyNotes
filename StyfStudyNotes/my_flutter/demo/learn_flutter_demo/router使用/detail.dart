import 'package:flutter/material.dart';

class YFDetailPage extends StatelessWidget {
  final String _message;
  YFDetailPage(this._message);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text('详情页'),
            //第一种解决
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_ios),
            //   onPressed: () {
            //     _backToHome(context);
            //   },
            // ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _message,
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                      _backToHome(context);
                    },
                    child: Text("回到首页"))
              ],
            ),
          )),
      onWillPop: () {
        _backToHome(context);
        return Future.value(false); //false时，自行写返回代码
      },
    );
  }

  void _backToHome(BuildContext context) {
    // Navigator.of(context).pop();
    Navigator.of(context).pop("详情返回的数据");
  }
}
