import 'package:flutter/material.dart';

import '../../../core/model/category_model.dart';
import 'meal_content.dart';

class YFMealScreen extends StatelessWidget {
  static const String routeName = "/meal";

  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context).settings.arguments as YFCategoryModel;

    return Scaffold(
        appBar: AppBar(
          title: Text(category.title),
        ),
        body: YFMealContent());
  }
}
