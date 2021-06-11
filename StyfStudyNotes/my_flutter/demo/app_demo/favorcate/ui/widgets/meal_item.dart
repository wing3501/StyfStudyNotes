import 'package:flutter/material.dart';
import '../../core/extension/int_extension.dart';
import 'package:provider/provider.dart';

import '../../core/model/meal_model.dart';
import '../../core/viewmodel/favor_view_model.dart';
import '../pages/detail/detail.dart';
import 'operation_item.dart';

class YFMealItem extends StatelessWidget {
  final YFMealModel _meal;
  final cardRadius = 12.px;
  YFMealItem(this._meal);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(YFDetailScreen.routeName, arguments: _meal);
      },
      child: Card(
        margin: EdgeInsets.all(10), //外边距
        elevation: 5, //阴影
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardRadius)), //圆角
        child: Column(
          children: [buildBasicInfo(context), buildOprationInfo()],
        ),
      ),
    );
  }

  Widget buildBasicInfo(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(cardRadius),
              topRight: Radius.circular(cardRadius)),
          child: Image.network(
            _meal.imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 10.px,
          bottom: 10.px,
          child: Container(
              width: 300.px,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(6.px)),
              child: Text(
                _meal.title,
                style: Theme.of(context).textTheme.headline2,
              )),
        )
      ],
    );
  }

  Widget buildOprationInfo() {
    return Padding(
      padding: EdgeInsets.all(16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          YFOperationItem(Icon(Icons.schedule), "${_meal.duration}分钟"),
          YFOperationItem(Icon(Icons.restaurant), "${_meal.complexStr}"),
          buildFavorItem()
        ],
      ),
    );
  }

  Widget buildFavorItem() {
    return Consumer<YFFavorViewModel>(
      builder: (context, favorVM, child) {
        final iconData =
            favorVM.isFavor(_meal) ? Icons.favorite : Icons.favorite_border;
        final iconColor = favorVM.isFavor(_meal) ? Colors.red : Colors.black;
        final title = favorVM.isFavor(_meal) ? "收藏" : "未收藏";
        return GestureDetector(
          child: YFOperationItem(
              Icon(
                iconData,
                color: iconColor,
              ),
              title),
          onTap: () {
            favorVM.handleMeal(_meal);
          },
        );
      },
    );
  }
}
