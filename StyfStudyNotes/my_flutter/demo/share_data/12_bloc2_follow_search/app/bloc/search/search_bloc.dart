import '../../api.dart';

import 'search_event.dart';
import 'search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(SearchState initialState) : super(initialState);

  @override
  Stream<Transition<SearchEvent, SearchState>> transformTransitions(
      Stream<Transition<SearchEvent, SearchState>> transitions) {
    return transitions.debounceTime(Duration(milliseconds: 500));
  }

  // @override
  // Stream<SearchState> transformEvents(
  //     Stream<SearchEvent> events,
  //     Stream<SearchState> Function(SearchEvent event) next,
  //     ) {
  //   return super.transformEvents(
  //     events.debounceTime(
  //       Duration(milliseconds: 500),
  //     ),
  //     next,
  //   );
  // }

  // @override
  // SearchState get initialState => SearchStateNoSearch();//初始状态

  @override
  Future<void> close() {
    add(EventTextChanged(''));
    return super.close();
  }

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
