import '../../../bean/follower.dart';


abstract class HomeState {//基态
  const HomeState();
}

class HomeStateEmpty extends HomeState {}//结果为空

class HomeStateLoading extends HomeState {}//加载中
class HomeStateError extends HomeState {}//异常

class HomeStateSuccess extends HomeState {//有结果
  final List<Follower> result;//搜索结果
  const HomeStateSuccess(this.result);
}
