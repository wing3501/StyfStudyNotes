import 'dart:async';

import 'package:bloc/bloc.dart';
import '../authentic/bloc.dart';
import '../../api/repositories/user_repository.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';

part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticBloc authenticationBloc;

  LoginBloc(LoginState initialState, this.authenticationBloc)
      : super(initialState);

  // LoginBloc({
  //   @required this.authenticationBloc,
  // })  : assert(authenticationBloc != null),
  //       super(null);

  // @override
  // LoginState get initialState => LoginInitial();

  UserRepository get userRepository => authenticationBloc.userRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EventLogin) {
      yield LoginLoading();
      try {
        final result = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        if (result.status) {
          authenticationBloc.add(LoginOver(result: result));
          // 本地存储用户信息
          userRepository.setLocalUser(result.user);
        } else {
          yield LoginFailure(error: result.msg);
        }
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
