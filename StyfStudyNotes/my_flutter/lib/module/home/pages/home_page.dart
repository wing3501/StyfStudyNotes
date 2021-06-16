import 'package:flutter/material.dart';
import '../../../utils/fancy_icon_provider.dart';
import '../widget/pubu_all.dart';
import '../widget/jingang_qu.dart';
import '../widget/baozhang_qu.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'), elevation: 0.0),
      body: Stack(
        children: [PuBuAll()],
      ),
    );
  }
}
