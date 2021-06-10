import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/bloc/home/home_bloc.dart';

import 'app/bloc/search/search_bloc.dart';
import 'app/bloc/search/search_state.dart';
import 'pages/home_page.dart';

import 'app/router.dart' as router;

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
      BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.Router.generateRoute, //路由生成器
      initialRoute: router.Router.home, //<---- 搜索页
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            subhead: TextStyle(textBaseline: TextBaseline.alphabetic)),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
