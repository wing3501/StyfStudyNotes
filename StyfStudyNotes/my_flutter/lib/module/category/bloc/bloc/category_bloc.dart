import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryExtendedState());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is CategoryPageInitEvent) {
      yield await init();
    } else if (event is SwitchTabEvent) {
      yield switchTap(event);
    } else if (event is IsExtendEvent) {
      yield isExtend();
    }
  }

  Future<CategoryExtendedState> init() async {
    return (state as CategoryExtendedState).clone();
  }

  ///切换tab
  CategoryState switchTap(SwitchTabEvent event) {
    return (state as CategoryExtendedState).clone()
      ..selectedIndex = event.selectedIndex;
  }

  ///是否展开
  CategoryState isExtend() {
    return (state as CategoryExtendedState).clone()
      ..isExtended = !(state as CategoryExtendedState).isExtended;
  }
}
