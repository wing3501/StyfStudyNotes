import 'dart:ui';

import 'package:flutter/material.dart';

import 'convert.dart';

enum TodoType {
  prepare, //准备中，未开始
  doing, //正在做
  done, //已完成
  death, //过期未完成
}

class TodoBean {
  //todo数据库数据模型
  final int todoId; //id
  final String todoTitle; //标题
  final String todoContent; //内容
  final int todoCreateTime; //创建时间 存储为 时间戳
  final int todoStartTime; //开始做时间 存储为时间戳
  final int todoEndTime; //预计完成时间 存储为时间戳
  final String todoColor; //颜色 存储为 0xFFFF0000 格式
  int todoDone; //是否完成  存储为 1为true,0为false
  final int todoIcon; //图标索引  存储为数字

  TodoBean(
      {this.todoId,
      this.todoTitle,
      this.todoContent,
      this.todoCreateTime,
      this.todoEndTime,
      this.todoStartTime,
      this.todoColor = "0xFFFF0000",
      this.todoDone = 0,
      this.todoIcon = 0});

  factory TodoBean.formMap(Map<String, dynamic> map) => TodoBean(
      todoId: map["id"],
      todoTitle: map["title"],
      todoContent: map["content"],
      todoCreateTime: map["create_time"],
      todoEndTime: map["end_time"],
      todoStartTime: map["start_time"],
      todoColor: map["color"],
      todoDone: map["done"],
      todoIcon: map["icon"]); //原始数据，映射成对象

  ///数据库数据模型转化为界面UI数据模型
  int get id => todoId;
  String get title => todoTitle;
  String get content => todoContent;
  bool get done => todoDone == 1;
  Color get color => Convert.string2Color(todoColor);
  String get startDate => Convert.millis2Date(todoStartTime);
  String get startTime => Convert.millis2Time(todoStartTime);
  String get endDate => Convert.millis2Date(todoEndTime);
  String get endTime => Convert.millis2Time(todoEndTime);
  String get goneTime => Convert.millis2PastTime(todoCreateTime);
  double get progress =>
      Convert.progressBetweenTime(todoStartTime, todoEndTime, todoCreateTime);
  TodoType get type =>
      Convert.date2Type(todoStartTime, todoEndTime, todoCreateTime, done);
  IconData get icon => Convert.int2Icon(todoIcon);
}
