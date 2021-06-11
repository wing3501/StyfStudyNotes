import 'package:flutter/material.dart';

import '../../../core/model/meal_model.dart';
import '../../../core/extension/int_extension.dart';

class YFDetailContent extends StatelessWidget {
  final YFMealModel _meal;
  YFDetailContent(this._meal);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBannerImage(),
          buildMakeTitle(context, "制作材料"),
          buildMakeMaterial(context),
          buildMakeTitle(context, "步骤"),
          buildMakeSteps(context)
        ],
      ),
    );
  }

  Widget buildBannerImage() {
    return Container(
        width: double.infinity, child: Image.network(_meal.imageUrl));
  }

  Widget buildMakeMaterial(BuildContext context) {
    return buildMakeContent(
        context,
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _meal.ingredients.length,
          itemBuilder: (context, index) {
            return Card(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(_meal.ingredients[index]),
              ),
            );
          },
        ));
  }

  Widget buildMakeSteps(BuildContext context) {
    return buildMakeContent(
        context,
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text("#${index + 1}"),
                ),
                title: Text(_meal.steps[index]),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: _meal.steps.length));
  }

  Widget buildMakeTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.px),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline2
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildMakeContent(BuildContext context, Widget child) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.px)),
      width: MediaQuery.of(context).size.width - 30.px,
      child: child,
    );
  }
}
