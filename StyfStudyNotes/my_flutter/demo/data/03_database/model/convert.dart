import 'package:flutter/material.dart';
import '../app/cons.dart';
import 'todo_bean.dart';
import 'package:intl/intl.dart';

class Convert {
  //颜色转换
  static Color string2Color(String color) =>
      Color(int.parse(color.substring(2), radix: 16));

  //毫秒转换日期
  static String millis2Date(int millis) {
    var date = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("yyyy-MM-dd").format(date);
  }

  //毫秒转换时间
  static String millis2Time(int millis) {
    var date = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("HH:mm:ss").format(date);
  }

  //毫秒转换已经过去的时间
  static String millis2PastTime(int millis) {
    var a = DateTime.now().millisecondsSinceEpoch - millis;
    var hour = a / 1000 / 60 / 60;
    var second = (hour - hour.floor()) * 60;
    var minus = ((second - second.floor()) * 60).round();
    return "${hour.floor()}:${second.floor()}:$minus";
  }

  //图标映射表
  static int2Icon(int icon) => Cons.icon_map[icon];

  //两个时间差与现在的百分比
  static double progressBetweenTime(
      int todoStartTime, int todoEndTime, int todoCreateTime) {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (now > todoStartTime && now < todoEndTime) {
      //说明正在进行中
      return (now - todoStartTime) / (todoEndTime - todoStartTime);
    }
    if (now < todoStartTime) {
      //说明还未开始
      var len = todoStartTime - todoCreateTime; //创建到开始的时间
      var past = todoStartTime - now; //以经过去的时间
      return 1 - past / len;
    }
    if (now > todoEndTime) {
      //说明已完成
      return 1;
    }
  }

  //转换为完成状态
  static TodoType date2Type(
      int todoStartTime, int todoEndTime, int todoCreateTime, bool done) {
    if (done) return TodoType.done;
    var now = DateTime.now().millisecondsSinceEpoch;
    if (now > todoStartTime && now < todoEndTime) {
      //说明正在进行中
      return TodoType.doing;
    }
    if (now < todoStartTime) {
      //说明还未开始
      return TodoType.prepare;
    }
    if (now > todoEndTime) {
      //说明已到期且未完成
      return TodoType.death;
    }
  }
}
