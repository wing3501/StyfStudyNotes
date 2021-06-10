part of 'bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class EventRegister extends RegisterEvent {
  final UserBean user;

  const EventRegister({
    @required this.user,
  });

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return 'EventRegister{user: $user}';
  }
}
