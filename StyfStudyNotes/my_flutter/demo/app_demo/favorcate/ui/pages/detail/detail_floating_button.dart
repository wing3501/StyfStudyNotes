import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/model/meal_model.dart';
import '../../../core/viewmodel/favor_view_model.dart';

class YFDetalFloatingButton extends StatelessWidget {
  final YFMealModel _meal;

  YFDetalFloatingButton(this._meal);

  @override
  Widget build(BuildContext context) {
    return Consumer<YFFavorViewModel>(
      builder: (context, favorVM, child) {
        final iconData =
            favorVM.isFavor(_meal) ? Icons.favorite : Icons.favorite_border;
        final iconColor = favorVM.isFavor(_meal) ? Colors.red : Colors.black;
        return FloatingActionButton(
          child: Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: () {
            favorVM.handleMeal(_meal);
          },
        );
      },
    );
  }
}
