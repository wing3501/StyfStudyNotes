import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/bloc/home/home_bloc.dart';
import '../app/bloc/search/search_bloc.dart';
import '../app/bloc/search/search_event.dart';
import '../pages/items/home_fill_page.dart';
import '../pages/items/empty_page.dart';
import '../pages/items/loading_page.dart';
import '../pages/items/error_page.dart';
import '../pages/items/search_fill_page.dart';
import '../app/bloc/home/home_state.dart';
import '../app/router.dart' as router;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter 联盟"),
        actions: <Widget>[_buildSearchButton(context)],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
          builder: (_, state) => _buildByState(state)),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(router.Router.search);
          BlocProvider.of<SearchBloc>(context).add(EventTextChanged(""));
        },
        child: Hero(tag: "top_search", child: Icon(Icons.search)),
      ),
    );
  }

  //根据状态显示界面
  Widget _buildByState(HomeState state) {
    if (state is HomeStateLoading) return LoadingPage();
    if (state is HomeStateEmpty) return EmptyPage();
    if (state is HomeStateError) return ErrorPage();
    if (state is HomeStateSuccess) return HomeFillPage(state.result);
  }
}
