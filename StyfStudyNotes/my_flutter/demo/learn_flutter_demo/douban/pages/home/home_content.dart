import 'package:flutter/material.dart';

import 'home_movie_item.dart';

class YFHomeContent extends StatefulWidget {
  @override
  _YFHomeContentState createState() => _YFHomeContentState();
}

class _YFHomeContentState extends State<YFHomeContent> {
  final List<MovieItem> movies = [];

  @override
  void initState() {
    super.initState();
    YFHomeRequest.requestMovieList(0).then((res) {
      setState(() {
        movies.addAll(res);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return YFHomeMovieItem(movies[index]);
      },
    );
  }
}
