part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryPageInitEvent extends CategoryEvent {
  const CategoryPageInitEvent();
}

class SwitchTabEvent extends CategoryEvent {
  final int selectedIndex;
  SwitchTabEvent({
    @required this.selectedIndex,
  });

  @override
  List<Object> get props => [selectedIndex];
}

class IsExtendEvent extends CategoryEvent {
  const IsExtendEvent();
}
