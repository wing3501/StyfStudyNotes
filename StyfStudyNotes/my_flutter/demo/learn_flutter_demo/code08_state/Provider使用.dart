import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewModel/counter_view_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (ctx) => CounterViewModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            primaryColor: Colors.green,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Column(
          children: <Widget>[ShowData01(), ShowData02(), ShowData03()],
        ),
        floatingActionButton: Selector<CounterViewModel, CounterViewModel>(
          selector: (ctx, counterVM) => counterVM,
          shouldRebuild: (previous, next) => false,
          builder: (context, counterVM, child) {
            return FloatingActionButton(
              child: child,
              onPressed: () {
                counterVM.counter++;
              },
            );
          },
        )

        // Consumer<CounterViewModel>(
        //   builder: (ctx, counterVM, child) {
        //     return FloatingActionButton(
        //       child: child,
        //       onPressed: () {
        //         counterVM.counter++;
        //       },
        //     );
        //   },
        //   child: Icon(Icons.add),
        // )

        );
  }
}

class ShowData01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _counter = Provider.of<CounterViewModel>(context).counter;

    return Card(
      color: Colors.red,
      child: Text("当前计数：$_counter"),
    );
  }
}

class ShowData02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Consumer<CounterViewModel>(
        builder: (context, value, child) {
          return Text("当前计数：${value.counter}");
        },
      ),
    );
  }
}

class ShowData03 extends StatefulWidget {
  @override
  _ShowData03State createState() => _ShowData03State();
}

class _ShowData03State extends State<ShowData03> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_ShowData03State didChangeDependencies调用了");
  }

  @override
  Widget build(BuildContext context) {
    int _counter = Provider.of<CounterViewModel>(context).counter;

    return Container(
      color: Colors.yellow,
      child: Text("当前计数：$_counter"),
    );
  }
}
