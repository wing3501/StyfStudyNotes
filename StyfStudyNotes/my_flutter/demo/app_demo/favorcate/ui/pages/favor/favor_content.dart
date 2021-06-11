import 'package:favorcate/core/viewmodel/favor_view_model.dart';
import 'package:favorcate/ui/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YFFavorContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<YFFavorViewModel>(
      builder: (context, favorVM, child) {
        if (favorVM.meals.length == 0) {
          return Center(
            child: Text("未收藏美食"),
          );
        }
        return ListView.builder(
          itemCount: favorVM.meals.length,
          itemBuilder: (ctx, index) {
            return YFMealItem(favorVM.meals[index]);
          },
        );
      },
    );
  }
}
