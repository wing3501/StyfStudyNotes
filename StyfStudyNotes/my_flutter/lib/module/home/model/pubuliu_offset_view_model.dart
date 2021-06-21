import 'package:flutter/material.dart';

class PuBuLiuOffsetViewModel extends ChangeNotifier {
  double offsetY = 0;
  double get getOffsetY => this.offsetY;

  set setOffsetY(double offsetY) {
    this.offsetY = offsetY;
    notifyListeners();
  }

  updateOffsetY(double offsetY) {
    this.offsetY = offsetY;
    notifyListeners();
  }
}
