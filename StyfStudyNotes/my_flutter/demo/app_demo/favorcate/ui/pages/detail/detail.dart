import 'package:favorcate/core/model/meal_model.dart';
import 'package:favorcate/ui/pages/detail/detail_content.dart';
import 'package:flutter/material.dart';

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
