import 'dart:math';

import 'package:flutter/material.dart';

class PathCreator {
  static final _path = Path();
  Path get path => _path;

  static Path nStarPath(int num, double R, double r, {dx = 0, dy = 0}) {
    _path.reset();
    double perDeg = 360 / num;
    double degA = perDeg / 2 / 2;
    double degB = 360 / (num - 1) / 2 - degA / 2 + degA;
    _path.moveTo(cos(rad(degA)) * R, (-sin(rad(degA)) * R));
    _path.moveTo(cos(rad(degA)) * R + dx, (-sin(rad(degA)) * R + dy));
    for (int i = 0; i < num; i++) {
      _path.lineTo(cos(rad(degA + perDeg * i)) * R + dx,
          -sin(rad(degA + perDeg * i)) * R + dy);
      _path.lineTo(cos(rad(degB + perDeg * i)) * r + dx,
          -sin(rad(degB + perDeg * i)) * r + dy);
    }
    _path.close();
    return _path;
  }

  static double rad(double deg) => deg * pi / 180;
}
