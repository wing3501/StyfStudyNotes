

abstract class HomeEvent{//事件基
  const HomeEvent();
}

class EventFetchData extends HomeEvent {
  final String login;
  const EventFetchData(this.login);
}
