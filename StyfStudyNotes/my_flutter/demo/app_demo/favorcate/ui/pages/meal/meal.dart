import 'package:favorcate/core/model/category_model.dart';
import 'package:favorcate/ui/pages/meal/meal_content.dart';
import 'package:flutter/material.dart';

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
