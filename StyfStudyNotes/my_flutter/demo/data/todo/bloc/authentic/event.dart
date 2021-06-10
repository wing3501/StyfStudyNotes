
part of 'bloc.dart';

///********************************验证行为********************************

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginOver extends AuthEvent {
  final LoginResult result;
  const LoginOver({this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'LoggedIn { token: $result }';
}

class LoggedOut extends AuthEvent {}