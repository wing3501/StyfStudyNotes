import 'package:flutter/material.dart';

import 'favor_content.dart';

class YFFavorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
      ),
      body: YFFavorContent(),
    );
  }
}
