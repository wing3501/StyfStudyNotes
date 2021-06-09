import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/bloc/search/search_bloc.dart';
import 'app/bloc/search/search_state.dart';
import 'pages/serach_page.dart';

void main() => runApp(Wrapper());

class Wrapper extends StatelessWidget {
  final Widget child;

  Wrapper({this.child});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//使用MultiBlocProvider包裹
        providers: [
      //Bloc提供器
      BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(SearchStateNoSearch())),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            subhead: TextStyle(textBaseline: TextBaseline.alphabetic)),
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(), //使用搜索页
    );
  }
}
