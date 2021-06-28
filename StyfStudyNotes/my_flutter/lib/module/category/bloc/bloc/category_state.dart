part of 'category_bloc.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryExtendedState extends CategoryState {
  int selectedIndex;
  bool isExtended;
  CategoryExtendedState({
    this.selectedIndex = 0,
    this.isExtended = false,
  });

  CategoryExtendedState clone() {
    return CategoryExtendedState()
      ..selectedIndex = selectedIndex
      ..isExtended = isExtended;
  }
}
