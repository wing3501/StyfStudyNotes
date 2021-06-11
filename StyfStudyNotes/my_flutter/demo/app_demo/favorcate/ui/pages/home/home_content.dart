import 'package:flutter/material.dart';
import '../../../core/extension/int_extension.dart';
import '../../../core/model/category_model.dart';
import '../../../core/services/json_parse.dart';
import 'home_category_item.dart';

class YFHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<YFCategoryModel>>(
      future: JsonParse.getCategoryData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        if (snapshot.error != null) {
          return Center(
            child: Text("请求失败"),
          );
        }
        final categories = snapshot.data;

        return GridView.builder(
          padding: EdgeInsets.all(20.px),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.px,
              mainAxisSpacing: 20.px,
              childAspectRatio: 1.5),
          itemBuilder: (context, index) {
            return YFHomeCategoryItem(categories[index]);
          },
        );
      },
    );
  }
}
