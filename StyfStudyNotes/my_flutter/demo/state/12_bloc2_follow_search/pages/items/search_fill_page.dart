import 'package:flutter/material.dart';
import '../../bean/search_result.dart';
import '../../widgets/search_result_item_widget.dart';


class SearchFillPage extends StatelessWidget {
  final SearchResult result;
  SearchFillPage(this.result);

  @override
  Widget build(BuildContext context) {
    var data= result?.items;
    return  ListView.builder(
        itemCount: data?.length,
        itemBuilder: (_, index) => Card(
            child:
            SearchResultItemWidget(prop: data[index], color: Colors.blue)));
  }
}
