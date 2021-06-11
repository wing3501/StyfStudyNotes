import 'package:flutter/material.dart';

class YFFilterViewModel extends ChangeNotifier {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;
  bool get isGlutenFree => this._isGlutenFree;

  set isGlutenFree(bool value) {
    this._isGlutenFree = value;
    notifyListeners();
  }

  bool get isLactoseFree => this._isLactoseFree;

  set isLactoseFree(bool value) {
    this._isLactoseFree = value;
    notifyListeners();
  }

  bool get isVegetarian => this._isVegetarian;

  set isVegetarian(bool value) {
    this._isVegetarian = value;
    notifyListeners();
  }

  bool get isVegan => this._isVegan;

  set isVegan(bool value) {
    this._isVegan = value;
    notifyListeners();
  }
}
