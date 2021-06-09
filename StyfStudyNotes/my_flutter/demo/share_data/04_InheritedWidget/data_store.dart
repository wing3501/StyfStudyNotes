import 'package:flutter/material.dart';

class DataStore extends InheritedWidget {
  final StepData data;

  DataStore({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DataStore oldWidget) {
    return data.step != oldWidget.data.step;
  }

  static DataStore of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DataStore>();
}

class StepData{
  int _step = 1;
  int get step => _step;
  void updateStep(int step) => _step = step;
}
