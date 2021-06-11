import 'package:flutter/material.dart';

import '../../../core/model/meal_model.dart';
import 'detail_content.dart';
import 'detail_floating_button.dart';

class YFDetailScreen extends StatelessWidget {
  static const String routeName = "/detail";

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as YFMealModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: YFDetailContent(meal),
      floatingActionButton: YFDetalFloatingButton(meal),
    );
  }
}
