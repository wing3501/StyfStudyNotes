import 'package:flutter/material.dart';

import 'home_appbar.dart';
import 'home_content.dart';

class YFHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YFHomeAppBar(context),
      body: YFHomeContent(),
    );
  }
}
