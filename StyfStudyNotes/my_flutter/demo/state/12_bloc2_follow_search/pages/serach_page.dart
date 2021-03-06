import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/bloc/search/search_bloc.dart';
import '../app/bloc/search/search_state.dart';
import '../pages/items/empty_page.dart';
import '../pages/items/error_page.dart';
import '../pages/items/search_fill_page.dart';
import '../pages/items/loading_page.dart';
import '../widgets/app_search_bar.dart';

import '../../../iconfont.dart';
import 'items/not_search_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(TolyIcon.icon_sound),
          )
        ],
        title: AppSearchBar(),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
          builder: (_, state) => _buildBodyByState(state)),
    );
  }

  _buildBodyByState(SearchState state) {
    if (state is SearchStateNoSearch) return NotSearchPage();
    if (state is SearchStateLoading) return LoadingPage();
    if (state is SearchStateError) return ErrorPage();
    if (state is SearchStateSuccess) return SearchFillPage(state.result);
    if (state is SearchStateEmpty) return EmptyPage();
  }
}
