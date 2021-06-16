import 'package:flutter/material.dart';

class CounterViewModel extends ChangeNotifier {
  int _counter = 1;
  int get counter => this._counter;

  set counter(int value) {
    this._counter = value;
    notifyListeners();
  }
}
