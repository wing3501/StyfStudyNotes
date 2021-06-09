import '../../api.dart';

import 'home_event.dart';
import 'home_state.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(null) {
    add(EventFetchData("toly1994328")); //初始时加入漂流瓶
  }

  @override
  HomeState get initialState => HomeStateLoading(); //初始状态

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is EventFetchData) {
      print(event.login);
      yield HomeStateLoading();
      try {
        final results = await GithubApi.getUserFollowers(login: event.login);
        if (results.isEmpty) yield HomeStateEmpty();
        yield HomeStateSuccess(results);
      } catch (error) {
        yield HomeStateError();
      }
    }
  }
}
