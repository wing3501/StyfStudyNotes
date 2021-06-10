import 'dart:async';
import 'package:equatable/equatable.dart';
import '../../api/dao/local_dao.dart';
import '../../api/repositories/user_repository.dart';
import '../../model/user_bean.dart';
import '../../model/login_result.dart';
import '../../api/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'event.dart';

part 'state.dart';

// 验证的bloc 需要一个 UserRepository

// 在程序开始时会触发 AppStarted 事件
// 此时bloc会用 UserRepository 查看是否存在token
// 来返回状态AuthSuccess 或 AuthFailure
// AuthFailure之后出现登录界面,  AuthSuccess后会到主页

// 在登录完成后会触发LoginOver事件
// 此时bloc会通过userRepository.persistToken对token进行持久化

class AuthenticBloc extends Bloc<AuthEvent, AuthenticState> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  AuthenticBloc(AuthenticState initialState, this.authenticationRepository,
      this.userRepository)
      : super(initialState);

  // AuthenticBloc(
  //     {@required this.authenticationRepository, @required this.userRepository})
  //     : assert(authenticationRepository != null),
  //       super(null);

  // @override
  // AuthenticState get initialState => AuthInitial();

  String get token => authenticationRepository.token;

  UserBean get user {
    if (state is AuthSuccess) {
      return (state as AuthSuccess).user;
    }
    return null;
  }

  @override
  Stream<AuthenticState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await authenticationRepository.hasToken();
      await LocalDao.dao.initLocalStorage();
      if (hasToken) {
        var user = await userRepository.getLocalUser();
        yield AuthSuccess(token: authenticationRepository.token, user: user);
      } else {
        yield AuthFailure();
      }
    }

    if (event is LoginOver) {
      yield AuthLoading();
      await authenticationRepository.persistToken(event.result.msg);
      yield AuthSuccess(user: event.result.user, token: event.result.msg);
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await userRepository.deleteLocalUser();
      await authenticationRepository.deleteToken();
      yield AuthFailure();
    }
  }
}
