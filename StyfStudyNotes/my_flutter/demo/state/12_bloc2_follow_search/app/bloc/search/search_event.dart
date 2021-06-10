

abstract class SearchEvent{//事件基
  const SearchEvent();
}

class EventTextChanged extends SearchEvent {
  final String arg;
  const EventTextChanged(this.arg);
}
