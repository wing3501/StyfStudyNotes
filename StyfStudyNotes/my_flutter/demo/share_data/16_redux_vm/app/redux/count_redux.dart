import 'package:redux/redux.dart';

class CountState {
  final int counter; //计时器数字
  CountState(this.counter);

  factory CountState.init([int counter]) => CountState(counter ?? 0);
}

//切换主题行为
class ActionCountAdd {}

//切换主题理器
var countReducer = TypedReducer<CountState, ActionCountAdd>((state, action) {
  final counter = state.counter + 1;
  return CountState(counter);
});
