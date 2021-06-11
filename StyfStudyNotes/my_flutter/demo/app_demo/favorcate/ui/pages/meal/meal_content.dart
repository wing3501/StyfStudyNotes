import 'package:favorcate/core/model/category_model.dart';
import 'package:favorcate/core/model/meal_model.dart';
import 'package:favorcate/core/viewmodel/meal_view_model.dart';
import 'package:favorcate/ui/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class YFMealContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context).settings.arguments as YFCategoryModel;
    return Selector<YFMealViewModel, List<YFMealModel>>(
      selector: (ctx, mealVM) => mealVM.meals
          .where((element) => element.categories.contains(category.id))
          .toList(), //用于转换
      shouldRebuild: (prev, next) {
        return !ListEquality().equals(prev, next); //当发生数据变化时，是否重新build
      },
      builder: (context, meals, child) {
        return ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return YFMealItem(meals[index]);
          },
        );
      },
    );
  }
}

// class YFMealContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final category =
//         ModalRoute.of(context).settings.arguments as YFCategoryModel;
//     return Consumer<YFMealViewModel>(
//       builder: (context, mealVM, child) {
//         final meals = mealVM.meals
//             .where((element) => element.categories.contains(category.id))
//             .toList();
//         return Text("${mealVM.meals.length}");
//       },
//     );
//   }
// }
