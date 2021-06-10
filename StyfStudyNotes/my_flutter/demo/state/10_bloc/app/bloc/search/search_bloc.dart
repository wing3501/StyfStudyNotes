import '../../api.dart';

import 'search_event.dart';
import 'search_state.dart';
import 'package:bloc/bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(SearchState initialState) : super(initialState);

  // @override
  // Stream<SearchState> mapEventToState(SearchEvent event) {
  //   // TODO: implement mapEventToState
  //   throw UnimplementedError();
  // }

  // @override
  // SearchState get initialState => SearchStateNoSearch(); //初始状态

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is EventTextChanged) {
      if (event.arg.isEmpty) {
        yield SearchStateNoSearch();
      } else {
        yield SearchStateLoading();
        try {
          final results = await GithubApi.search(event.arg);
          if (results.items.isEmpty) yield SearchStateEmpty();
          yield SearchStateSuccess(results);
        } catch (error) {
          yield SearchStateError();
        }
      }
    }
  }
}
