import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/router/router.dart' as router;
import 'bloc/authentic/bloc.dart';
import 'bloc/login/bloc.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'api/repositories/authentication_repository.dart';
import 'pages/home_page.dart';
import 'pages/splash.dart';
import 'api/repositories/user_repository.dart';

void main() => runApp(BlocWrapper(
      child: MyApp(),
    ));

class BlocWrapper extends StatefulWidget {
  final Widget child;

  BlocWrapper({@required this.child});

  @override
  _BlocWrapperState createState() => _BlocWrapperState();
}

class _BlocWrapperState extends State<BlocWrapper> {
  final userRepository = UserRepository();
  final authenticationRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => AuthenticBloc(
              AuthInitial(), authenticationRepository, userRepository)
            ..add(AppStarted()))
    ], child: widget.child);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: router.Router.generateRoute, //路由生成器
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticBloc, AuthenticState>(
        builder: _buildContentByAuthState,
      ),
    );
  }

  Widget _buildContentByAuthState(BuildContext context, AuthenticState state) {
    if (state is AuthInitial) {
      return SplashWidget();
    }
    if (state is AuthSuccess) {
      return HomePage();
    }

    if (state is AuthLoading) {
      return LoadingPage();
    }
//    return LoadingPage();
    return BlocProvider(
      create: (context) =>
          LoginBloc(LoginInitial(), BlocProvider.of<AuthenticBloc>(context)),
      child: LoginPage(),
    );
  }
}
