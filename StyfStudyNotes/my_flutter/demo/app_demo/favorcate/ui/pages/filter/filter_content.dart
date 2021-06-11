import 'package:favorcate/core/viewmodel/filter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:favorcate/core/extension/int_extension.dart';
import 'package:provider/provider.dart';

class YFFilterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[buildChoiceTitle(context), buildChoiceSelect()],
    );
  }

  Widget buildChoiceTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.px),
      alignment: Alignment.center,
      child: Text(
        "展示你的选择",
        style: Theme.of(context)
            .textTheme
            .headline2
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildChoiceSelect() {
    return Expanded(
      child: Consumer<YFFilterViewModel>(
        builder: (ctx, filterVM, child) {
          return ListView(
            children: [
              buildListTile("五谷蛋白", "五谷蛋白", filterVM.isGlutenFree, (value) {
                filterVM.isGlutenFree = value;
              }),
              buildListTile("不含乳糖", "不含乳糖", filterVM.isLactoseFree, (value) {
                filterVM.isLactoseFree = value;
              }),
              buildListTile("素食主义", "素食主义", filterVM.isVegetarian, (value) {
                filterVM.isVegetarian = value;
              }),
              buildListTile("严格素食主义", "严格素食主义", filterVM.isVegan, (value) {
                filterVM.isVegan = value;
              }),
            ],
          );
        },
      ),
    );
  }

  Widget buildListTile(
      String title, String subtitle, bool value, Function onchange) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onchange,
      ),
    );
  }
}
