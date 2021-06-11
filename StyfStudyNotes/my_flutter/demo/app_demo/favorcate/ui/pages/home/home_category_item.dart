import 'package:flutter/material.dart';

import '../../../core/model/category_model.dart';
import '../meal/meal.dart';
import '../../../core/extension/int_extension.dart';

class YFHomeCategoryItem extends StatelessWidget {
  final YFCategoryModel _categoryModel;
  YFHomeCategoryItem(this._categoryModel);
  @override
  Widget build(BuildContext context) {
    final bgColor = _categoryModel.cColor;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(YFMealScreen.routeName, arguments: _categoryModel);
      },
      child: Container(
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12.px),
              gradient:
                  LinearGradient(colors: [bgColor.withOpacity(.5), bgColor])),
          alignment: Alignment.center,
          child: Text(
            _categoryModel.title,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(fontWeight: FontWeight.bold),
          )),
    );
  }
}
