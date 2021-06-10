import 'package:flutter/material.dart';
import 'app/redux/count_redux.dart';

import 'side_page.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';
import 'app/redux/app_redux.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CountViewModel>(
        distinct: true,
        converter: CountViewModel.fromStore,
        builder: (context, vm) {
          return Scaffold(
            drawer: SlidePage(),
            appBar: AppBar(title: Text(widget.title)),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have pushed the button this many times:',
                      style: TextStyle(color: vm.color, fontSize: 18)),
                  InkWell(
                      onTap: () {
                        setState(() {
                          vm.onAdd();
                        });
                      },
                      child: Text(
                        '${vm.count}',
                        style: Theme.of(context).textTheme.display1,
                      )),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: vm.onAdd,
              backgroundColor: vm.color,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          );
        });
  }
}

class CountViewModel {
  final int count; //数字
  final Color color; //颜色
  final VoidCallback onAdd; //点击回调

  CountViewModel(
      {@required this.count, @required this.onAdd, @required this.color});

  static CountViewModel fromStore(Store<AppState> store) {
    return CountViewModel(
      color: store.state.themeState.primaryColor,
      count: store.state.countState.counter,
      onAdd: () => store.dispatch(ActionCountAdd()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountViewModel &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          color == other.color;

  @override
  int get hashCode => count.hashCode ^ color.hashCode;
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    print("----build------${DateTime.now()}");
    return Container();
  }
}
